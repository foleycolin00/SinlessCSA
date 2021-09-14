local b4 = {}; for k,_ in pairs(_ENV) do b4[k] = k end

local goal = {}

local num = require('num')

goal.__index = goal
setmetatable(goal, num)

-- create a new goal object
function goal:new(col_name, min_or_max)
  local o = num:new(col_name)
  setmetatable(o, self)
  
  o.weight = min_or_max
  
  return o
end

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