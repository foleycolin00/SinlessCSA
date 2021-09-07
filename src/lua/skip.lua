local skip = {}

function skip:new()
    local o = {}
    setmetatable(o, self)
    self.__index = self
    self.count = 0
    return o
end

function skip:add(x)
    self.count = self.count + 1
    return x
end


return skip