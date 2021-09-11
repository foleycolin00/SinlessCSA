local goal = {}

-- create a new goall object
function goal:new(col_name)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    self.count = 0
    self.name = col_name
    
    return o
  
end

function goal:add(x)
    self.count = self.count + 1
    return x
end

return goal