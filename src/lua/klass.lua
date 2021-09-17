--- This klass class is used for classification.
-- @module klass.lua
-- @author Steven Jones & Azeeza Eagal
local b4 = {}; for k,_ in pairs(_ENV) do b4[k] = k end

local klass = {}

local sym = require('sym')

klass.__index = klass
setmetatable(klass, sym)

--- This function creates a new klass object.
-- @function new
-- @param col_name the column name
-- @return a new klass object
function klass:new(col_name)
  local o = sym:new(col_name)
  setmetatable(o, self)
  return o
end

--- This function clones klass object.
-- @function clone
-- @param col_name the column name
-- @return a clone of a klass object
function klass:clone()
    local return_val = klass:new(self.name) 
    return_val.count = self.count
    return_val.mode = self.mode
    return_val.mode_frequency = self.mode_frequency
    
    for key, value in pairs(self.symbol_list) do
      return_val.symbol_list[key] = value
    end

    return return_val
end

for k,_ in pairs(_ENV) do if not b4[k] then print("?? ".. k) end end

return klass