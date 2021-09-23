--- This num class is used to handle general numeric values.
-- @module num.lua
-- @author Steven Jones & Azeeza Eagal
local b4 = {}; for k,_ in pairs(_ENV) do b4[k] = k end

local num = {}

num.__index = num

local some = require('some')

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
              sample_list = some:new() }
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
  
  
  --[[
  local symbol_list_collection = {}
  
  for key, value in pairs(self.symbol_list) do
    symbol_list_collection[key] = 1
  end
  
  for key, value in pairs(other_sym.symbol_list) do
    symbol_list_collection[key] = 1
  end
  
  local sym_col = {}
  
  for key, value in pairs(symbol_list_collection) do
    table.insert(sym_col, key)
  end
  
  local curr_index = 1
  ]]
  return function()
    --[[
    if curr_index <= #sym_col then
      local item = sym_col[curr_index]
      local ret = self.name .. ' ' .. item .. ' ' .. item .. ' '
                  .. tostring(self.symbol_list[item]) .. ' ' .. tostring(other_sym.symbol_list[item])
      curr_index = curr_index + 1
    
      return ret
    end
    ]]
  end
  
end

for k,_ in pairs(_ENV) do if not b4[k] then print("?? ".. k) end end

return num