--- This some class is a non parameteric collector.
-- @module some.lua
-- @author Steven Jones & Azeeza Eagal
local b4 = {}; for k,_ in pairs(_ENV) do b4[k] = k end

local some = {}

some.__index = some

--- This function creates a new some object.
-- @function new
-- @param sample_list_max
-- @return returns a new some object
function some:new(sample_list_max)
    -- what should go in here
    local o = { overall_items = 0,
                sample_list = {},
                max_items = sample_list_max or 256 }
    setmetatable(o, self)
    return o
end

--- This function adds an item to a some object. 
-- @function add
-- @param item list item
function some:add(item)
  -- increase number of items seen overall
  self.overall_items = self.overall_items + 1
  
  -- if number of items in list is less than the max items allowed, then just insert
  -- else if at a decreasing rate as the number of items seen increases, bump items
  -- out of the list and replace them with a new one in sorted order
  if #self.sample_list < self.max_items then
    self:insert_sorted(item)
  elseif self:rand() < self.max_items / self.overall_items then
    table.remove(self.sample_list, math.floor(self:rand() * self.max_items) + 1)
    self:insert_sorted(item)
  end
end

--- This function inserts an item in a sorted table.
-- @function insert_sorted
-- @param item list item
function some:insert_sorted(item)
  if #self.sample_list == 0 then
    table.insert(self.sample_list, item)
  else
    local placed = false
    
    for key, value in pairs(self.sample_list) do
      if item < value then
        table.insert(self.sample_list, key, item)
        placed = true
        break
      end
    end
    
    if not placed then table.insert(self.sample_list, item) end
  end
end

--- This function returns the standard deviation in a table.
-- @function sd
-- @return the standard deviation 
function some:sd()
  return (self:per(.9) - self:per(.1)) / 2.56
end

--- This function returns the standard deviation in a table.
-- @function sd_true
-- @return the standard deviation 
function some:sd_true()
  local mean = 0
  for i = 1, #self.sample_list do
    mean = mean + self.sample_list[i]
  end
  
  mean = mean / #self.sample_list
  
  local sum = 0
  for i = 1, #self.sample_list do
    sum = sum + (self.sample_list[i] - mean)^2
  end
  
  sum = (sum / (#self.sample_list - 1))^0.5
  
  return sum  
end
--- This function returns the percentile.
-- @function per
-- @return the percentile 
function some:per(p)
  -- percentile
  p= p or .5
  return self.sample_list[math.max(1, math.floor(#self.sample_list * p))]
end
-- should this be here? 
-- https://github.com/timm/keys/blob/main/src/rand.lua
local Seed = 62884 -- beware. do not lose control of your seeds

-- **randi(?lo : int, ?hi : int) : int**  
-- Return an int between `lo`  and `hi` (default 0..1).
--- This function returns an integer between the max and min values.
-- @param lo the minimum value 
-- @param hi the maximum value 
-- @return an integer between the max and min values
function some:randi(lo,hi) 
  return math.floor(0.5 + rand(lo,hi)) end

-- **rand(?lo : num, ?hi : num) : float**   
-- Return a float between `lo`  and `hi` (default 0..1).
--- This function returns an float between the max and min values.
-- @param lo the minimum value 
-- @param hi the maximum value 
-- @return an value between the max and min values
function some:rand(lo,hi,     mult,mod)
  lo,hi = lo or 0, hi or 1
  mult, mod = 16807, 2147483647
  Seed = (mult * Seed) % mod 
  return lo + (hi-lo) * Seed / mod end 

for k,_ in pairs(_ENV) do if not b4[k] then print("?? ".. k) end end

return some

