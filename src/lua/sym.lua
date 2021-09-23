--- This sym class is used to handle general sym values.
-- @module sym.lua
-- @author Steven Jones & Azeeza Eagal
local b4 = {}; for k,_ in pairs(_ENV) do b4[k] = k end

local sym = {}

sym.__index = sym

--- This function creates a new sym object.
-- @function new
-- @param col_name the column name
-- @return a new sym object
function sym:new(col_name)
    local o = { name = col_name or '',
                count = 0,
                mode = nil,
                mode_frequency = 0,
                symbol_list = {} }
    setmetatable(o, self)
    
    return o
end

--- This function adds a element, updates the count and the mode.
-- @function add
-- @param x a value
-- @return the input value
function sym:add(x)
  -- skip if entry is a question mark
  if x == '?' then return x end
  
  self.count = self.count + 1
  self.symbol_list[x] = (self.symbol_list[x] or 0) + 1

  if self.symbol_list[x] > self.mode_frequency then 
      self.mode_frequency = self.symbol_list[x]
      self.mode = x
  end

  return x
end

function sym:mid()
  return self.mode
end

--- This function clones a sym object.
-- @function clone
-- @return a clone of a sym object
function sym:clone()
    local return_val = sym:new(self.name) 
    return_val.count = self.count
    return_val.mode = self.mode
    return_val.mode_frequency = self.mode_frequency
    
    -- copy symbols over
    for key, value in pairs(self.symbol_list) do
      return_val.symbol_list[key] = value
    end

    return return_val
end

--- This function returns the distance between two symbols.
-- @param x first symbol
-- @param y second symbol
-- @return 0 if the two symbols are the same, 1 if the symbols are different
function sym:distance(x, y)
  -- unknown should always be max distance
  if x == '?' or y == '?' then return 1 end
  
  return x == y and 0 or 1
end

function sym:discretize(other_sym)
  ---
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
  
  return function()
    if curr_index <= #sym_col then
      local item = sym_col[curr_index]
      local ret = self.name .. ' ' .. item .. ' ' .. item .. ' '
                  .. tostring(self.symbol_list[item]) .. ' ' .. tostring(other_sym.symbol_list[item])
      curr_index = curr_index + 1
    
      return ret
    end
  end
end

for k,_ in pairs(_ENV) do if not b4[k] then print("?? ".. k) end end

return sym