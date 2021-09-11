local goal = {}

goal.__index = goal

-- create a new goal object
function goal:new(col_name, min_or_max)
    local o = { weight = min_or_max }
    setmetatable(o, self)
    
    return o
end

--[[
function goal:add(x)
    self.count = self.count + 1
    return x
end
]]

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

return goal