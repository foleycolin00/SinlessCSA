--- This goal class is used for values we want to maximize or minimize.
-- @module goal.lua
-- @author Steven Jones & Azeeza Eagal
local b4 = {}; for k,_ in pairs(_ENV) do b4[k] = k end

local goal = {}

local num = require('num')

goal.__index = goal
setmetatable(goal, num)
--- This function creates a new goal object
-- @function new
-- @param col_name the column name
-- @param min_or_max the weight attached to the goal
-- @return a new goal object
function goal:new(col_name, min_or_max)
  local o = num:new(col_name)
  setmetatable(o, self)
  o.weight = min_or_max
  return o
end

--- This function creates a clone of a goal object
-- @function clone
-- @return a clone of a goal object
function goal:clone()
    local return_val = goal:new(self.name, self.weight)    
    return_val.count = self.count
    return_val.min = self.min
    return_val.max = self.max
    return_val.mean = self.mean
    return_val.stdev = self.stdev
    return_val.m2 = self.m2
    return return_val
end

for k,_ in pairs(_ENV) do if not b4[k] then print("?? ".. k) end end

return goal