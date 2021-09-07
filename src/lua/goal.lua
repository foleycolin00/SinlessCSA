local goal = {}

function goal:new()
    local o = {}
    setmetatable(o, self)
    self.__index = self
    self.count = 0
    return o
  
end

function goal:add(x)
    self.count = self.count + 1
    return x
end

return goal