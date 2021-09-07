local num = {}

function num:new()
    local o = {}
    setmetatable(o, self)
    self.__index = self
    self.count = 0
    self.min = nil
    self.max = nil
    --self.mode = 0
    self.mean = 0
    --self.stdev = look at menzies 
    return o
  
end

function num:add(x)
    self.count = self.count + 1
    
    self.min = (self.min and (x > self.min)) and self.min or x

    self.max = (self.max and (x < self.max)) and self.max or x

    -- https://math.stackexchange.com/questions/106700/incremental-averageing
    self.mean = self.mean + (x - self.mean) / self.count

    --https://github.com/timm/keys/blob/main/src/num.lua

    
    return x
end


return num