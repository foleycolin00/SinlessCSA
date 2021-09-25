--- This num class is used to handle general numeric values.
-- @module num.lua
-- @author Steven Jones & Azeeza Eagal
local b4 = {}; for k,_ in pairs(_ENV) do b4[k] = k end

local num = {}

num.__index = num

local some = require('some')
local settings = require('settings')

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
      self.stdev = ((self.m2 / self.count - 1))^0.5 end
  
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

  for key, value in pairs(self.sample_list.sample_list) do
    sample_list_collection[key] = 1
  end
 

  for key, value in pairs(other_num.sample_list.sample_list) do
    sample_list_collection[key] = 0
  end


  for key, value in pairs(sample_list_collection) do
    print("Key: " .. sample_list_collection[key])
  end

  local curr_index = 1

  -- find minimum break space (.3 * expected value of standard deviation)
  local n1 = #self.sample_list.sample_list
  local n2 = #other_num.sample_list.sample_list

  local iota = self.settings.cohen * (self.stdev * n1 + other_num.stdev * n2) / (n1 + n2)
  
  -- i do not like the comment he left at this line
  --local ranges = merge(unsuper(xys, #xys**self.settings.bins, iota))
  local ranges = self:unsuper(sample_list_collection, (#sample_list_collection)^self.settings.bins, iota)

  return function()
--[[
    if curr_index <= #xys then
      local item = xys[curr_index]
      local ret = self.name .. ' ' .. item .. ' ' .. item .. ' '
                  .. tostring(self.sample_list[item]) .. ' ' .. tostring(other_num.sample_list[item])
      curr_index = curr_index + 1
      return ret
    end

  
  ]]
  end
  
end

function num:variance(other_num)

  
end

function num:unsuper(xys, binsize, iota)

  --xys.sort(key=lambda s:s[0])
  -- this line sorts xys by keys, so the lowest keys are at the front of the array: https://www.youtube.com/watch?v=Ob9rY6PQMfI (4:13)
  -- order by keys
  xkeys = {}

  for k in pairs(xys) do table.insert(xkeys, k) end
  table.sort(xkeys)

  for _,k in pairs(xkeys) do print(k, xys[k]) end

  
--[[
  local split = {}

  local i = 0
  local j = 0 

  while (i < (#xys - 1)) and ((#xys - 1) > binsize) do 

    if ( (j >= #xys - 1) or (xys[j][0] ~= xys[j + 1][0])) and (math.abs(i-j) > iota) and ((#xys - 1 - j) > binsize ) then 
      local temp = {}

      for key, value in pairs(i, j + 1) do 
        table.insert(temp, xys[key])
      end

      table.insert(split, temp)

      i = j + 1
      j = 1 
    elseif j < #xys then 
      j = j + 1 
    else 
      i = i + 1 
    end 

    temp = {} 

    for key, value in pairs(i, #xys) do
      table.insert(temp, xys[key])
    end

    table.insert(split, temp)
  end
]]
--return split

return 1
end

function num:merge(ranges)
  local i = 0
  
  while i < #ranges do 
    local a = ranges[i]
    local b = ranges[i + 1]
    local c = a + b 

    if (variance(c) * 0.95) <= (variance(a)*#a) + (variance(b)*#b / #a + #b) then 
      ranges[i+1] = ranges[i] + ranges[i+1]
      --ranges.pop(i)
    else 
      i = i + 1 
    end 
  end 
  return ranges

end



for k,_ in pairs(_ENV) do if not b4[k] then print("?? ".. k) end end

return num