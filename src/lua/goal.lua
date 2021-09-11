local goal = {}

goal.__index = goal

-- create a new goall object
function goal:new(col_name)
    local o = { count = 0,
                name = col_name or '' }
    setmetatable(o, self)
    
    return o
  
end

function goal:add(x)
    self.count = self.count + 1
    return x
end

function goal:clone()
    local return_val = goal:new(self.name) 
    return_val.count = self.count

    return return_val
end

return goal