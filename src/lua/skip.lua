--- This num class is used to handle data that needs to be skipped.
-- @module skip.lua
-- @author Steven Jones & Azeeza Eagal
local b4 = {}; for k,_ in pairs(_ENV) do b4[k] = k end

local skip = {}

skip.__index = skip

--- This function creates a skip sample object.
-- @function new
-- @param col_name the column name
-- @return returns a new skip object
function skip:new(col_name)
    local o = { name = col_name or '',
                count = 0 }
    setmetatable(o, self)
    return o
end

--- This function skips adding an element to the function and updates the count.
-- @function add
-- @param x a value
-- @return the value
function skip:add(x)
    if x == '?' then
      return x
    end
    
    self.count = self.count + 1
    return x
end

--- This function clones skip object.
-- @function clone
-- @return a clone of a num object
function skip:clone()
    local return_val = skip:new(self.name) 
    return_val.count = self.count

    return return_val
end

for k,_ in pairs(_ENV) do if not b4[k] then print("?? ".. k) end end

return skip