local sym = {}

function sym:new()
    local o = {}
    setmetatable(o, self)
    self.__index = self
    self.count = 0
    self.mode = nil
    self.mode_frequency = 0
    self.symbol_list = {}
    return o
  
end

function sym:add(x)
    self.count = self.count + 1
    self.symbol_list[x] = (self.symbol_list[x] or 0) + 1

    if self.symbol_list[x] > self.mode_frequency then 
        self.mode_frequency = self.symbol_list[x]
        self.mode = x
    end
    
    return x
end

return sym