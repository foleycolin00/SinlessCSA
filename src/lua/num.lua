local num = {}

-- create a new num object
function num:new(col_name)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    self.count = 0
    self.min = nil
    self.max = nil
    --self.mode = 0
    self.mean = 0
    self.stdev = 0 
    self.m2 = 0
    self.name = col_name
    return o
  
end

function num:add(x)

    
    self.count = self.count + 1
    
    local delta = x - self.mean

    self.min = (self.min and (x > self.min)) and self.min or x

    self.max = (self.max and (x < self.max)) and self.max or x

    -- https://math.stackexchange.com/questions/106700/incremental-averageing
    self.mean = self.mean + (delta) / self.count

    self.m2 = self.m2 + delta * (x - self.mean) 
    
    --https://github.com/timm/keys/blob/main/src/num.lua & https://www.youtube.com/watch?v=p5xThuN3P0I
    if self.count > 1 then  
        self.stdev = ((self.m2 / self.count - 1))^0.5 end



    
    return x
end

function num:clone()
    local return_val = num:new(self.name) 
    
    return return_val
end

return num