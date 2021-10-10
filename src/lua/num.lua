--- This num class is used to handle general numeric values.
-- @module num.lua
-- @author Steven Jones & Azeeza Eagal
local b4 = {}; for k,_ in pairs(_ENV) do b4[k] = k end

local num = {}

num.__index = num

local some = require('some')
local settings = require('settings')
local bin = require('bin')

--- This function creates a new num object.
-- @function new
-- @param col_name the column name
-- @return a new num object
function num:new(col_name)
  local o = { name = col_name or '',
              count = 0,
              min = nil,
              max = nil,
              mean = 0,
              stdev = 0,
              m2 = 0,
              sample_list = some:new(),
              settings = settings:new() }
  setmetatable(o, self)
  
  return o
end

--- This function adds a element, updates the count, min, max, and standard deviation.
-- @function add
-- @param x a value
-- @return the input value
function num:add(x)
 
  x = tonumber(x) or x
  if type(x) ~= 'number' then
    return x
  end
  
  self.sample_list:add(x)
    
  self.count = self.count + 1
  local delta = x - self.mean

  self.min = (self.min and (x > self.min)) and self.min or x
  self.max = (self.max and (x < self.max)) and self.max or x

  -- https://math.stackexchange.com/questions/106700/incremental-averageing
  self.mean = self.mean + (delta) / self.count
  self.m2 = self.m2 + delta * (x - self.mean) 
  
  --https://github.com/timm/keys/blob/main/src/num.lua & https://www.youtube.com/watch?v=p5xThuN3P0I
  if self.count > 1 then  
      self.stdev = (self.m2 / (self.count - 1))^0.5 end
  
  return x
end

function num:mid()
  return self.mean
end

--- This function clones a num object.
-- @function clone
-- @return a clone of a num object
function num:clone()
    local return_val = num:new(self.name) 
    return_val.count = self.count
    return_val.min = self.min
    return_val.max = self.max
    return_val.mean = self.mean
    return_val.stdev = self.stdev
    return_val.m2 = self.m2
    
    return_val.sample_list.overall_items = self.sample_list.overall_items
    return_val.sample_list.max_items = self.sample_list.max_items
    for key, value in pairs(self.sample_list.sample_list) do
      table.insert(return_val.sample_list, value)
    end
    
    return return_val
end

--- This function normalizes a set of numeric values.
-- @function norm
-- @param x a value
-- @return a normalized value
function num:norm(x)
  if type(x) ~= 'number' then return x end
  
  if self.max == self.min then --[[print("Normalization Error: Divide by zero")]] return 1 end

  return (x - self.min) / (self.max - self.min)
end

--- This function returns the normalized disance of the 2 input values
-- @function distance
-- @param x first num
-- @param y second num
-- @return normalized distance
function num:distance(x, y)
  x = self:norm(x)
  y = self:norm(y)
  
  if type(x) ~= 'number' and type(y) ~= 'number' then return 1 end
  if type(x) ~= 'number' then x = (y > 0.5 and 0 or 1) end
  if type(y) ~= 'number' then y = (x > 0.5 and 0 or 1) end
  
  return math.abs(x - y)
end

function num:discretize(other_num)
  -- i = good sample (for us it is self)
  -- j = bad sample (for us it it other_num)
  
  -- go through some (which is a sample of num)
  -- so for the good one it would be every item in some's sample list
  -- and attach 1 to it, { { self.some[1], 1 }, { self.some[2], 1 }, ... }
  -- do the same for the bad sample (other_num), but attach 0 to it
  -- { { other_num.some[1], 0 }, { other_num.some[2], 0 }, ... }
  local sample_list_collection = {}

  -- every key should be given a zero
  for key, value in pairs(other_num.sample_list.sample_list) do
    table.insert(sample_list_collection, { value, 0 })
  end

  -- every key should be given a one
  for key, value in pairs(self.sample_list.sample_list) do
    table.insert(sample_list_collection, { value, 1 })
  end

  -- find minimum break space (.3 * expected value of standard deviation)
  local n1 = #self.sample_list.sample_list
  local n2 = #other_num.sample_list.sample_list

  local iota = self.settings.cohen * ( (self.stdev * n1 + other_num.stdev * n2) / (n1 + n2) )
  --print("Iota")
  --print(iota)
  --print()

  local ranges = self:merge(self:unsuper(sample_list_collection, (#sample_list_collection)^self.settings.bins, iota))

  --[[
  for i = 1, #ranges do
    for j = 1, #ranges[i] do
      io.write(table.concat(ranges[i][j], ' '), ', ')
    end
    print('\n')
  end
  print()
  ]]
  
 local curr_index = 0

  return function()
    curr_index = curr_index + 1
    
    if curr_index <= #ranges then
      local lo
      if curr_index > 1 then
        lo = ranges[curr_index - 1][#ranges[curr_index - 1]][1]
      else
        lo = ranges[curr_index][1][1]
      end
      
      local hi = ranges[curr_index][#ranges[curr_index]][1]
      
      local counts = {0, 0}
        
      for key, value in pairs(ranges[curr_index]) do       
        
        local best_or_worst = value[2] + 1
        
        counts[best_or_worst] = counts[best_or_worst] + 1
      end
      
      return bin:new(-1, self.name, lo, hi, counts[2], n1, counts[1], n2,  curr_index == 1, curr_index == #ranges)
    end
  end
end

function num:variance(range)
  local counts = {0, 0}
  for key, value in pairs(range) do
    local best_or_worst = value[2] + 1
    counts[best_or_worst] = counts[best_or_worst] + 1
  end
  
  if counts[1] == 0 or counts[2] == 0 then
    return 0
  end
  
  local p1 = counts[1] / #range
  local p2 = 1 - p1
  
  local w1 = math.log(p1, 2)
  local w2 = math.log(p2, 2)
  return -(p1 * w1 + p2 * w2)
end

function num:unsuper(sample_list_collection, binsize, iota)
  --[[
  print("here first")
  for i = 1, #sample_list_collection do
    io.write(sample_list_collection[i][1] .. ' ' .. sample_list_collection[i][2] .. ', ')
  end
  print()
  ]]
  
  -- sort it by value so max min collecting works
  table.sort(sample_list_collection, function(x, y) return x[1] < y[1] end)
  
  --[[
  print("here second")
  for i = 1, #sample_list_collection do
    io.write(sample_list_collection[i][1] .. ' ' .. sample_list_collection[i][2] .. ', ')
  end
  print()
  ]]
  
  local split = {}

  local i = 1
  local j = 2
  
  -- while j is not off the end of the list
  while (j <= #sample_list_collection + 1) do
    
    -- If j is at the end, do the break (bin the remaining items)
    if j > #sample_list_collection or
    
       -- It cannot break ranges unless the current lowest i value is different then
       -- the last value being checked at j
       -- unneeded, will fail the next chekck if they are the same
       --((sample_list_collection[i][1] ~= sample_list_collection[j][1]) and
       
       -- It cannot break unless the value range of the items are more different ( max - min > 0.3 * sd)
       -- max = where j is (the next item to not include in this break)
       -- min = where i is (the lowest item in the sorted list
       (sample_list_collection[j][1] - sample_list_collection[i][1] > iota and
       -- It cannot break unless there are enough items (sqrt(N)) after the break (so we can break some more, later)
       j - i > binsize and
       -- there are bin size or more items left in the list
       (#sample_list_collection - j  > binsize)) then
       
      table.insert(split, {table.unpack(sample_list_collection, i, j - 1)})

      i = j
    end
    
    j = j + 1
  end
  
  --[[
  print()
  for i = 1, #split do
    for j = 1, #split[i] do
      io.write(table.concat(split[i][j], ' '), ', ')
    end
    print()
  end
  print()
  ]]

  return split
end

function num:merge(ranges)
  local i = 1
  
  while i < #ranges do 
    local a = ranges[i]
    local b = ranges[i + 1]
    local c = {}
    table.move(a, 1, #a, 1, c)
    table.move(b, 1, #b, #c + 1, c)

    if (self:variance(c) * 0.95) <= (self:variance(a) * #a + self:variance(b) * #b) / (#a + #b) then
      ranges[i + 1] = c
      table.remove(ranges, i)
    else
      i = i + 1 
    end 
  end
 
  return ranges
end

for k,_ in pairs(_ENV) do if not b4[k] then print("?? ".. k) end end

return num