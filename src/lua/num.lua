local num = {}

num.__index = num

-- create a new num object
function num:new(col_name)
    local o = { name = col_name or '',
                count = 0,
                min = nil,
                max = nil,
                mean = 0,
                stdev = 0,
                m2 = 0 }
    setmetatable(o, self)
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
    return_val.count = self.count
    return_val.min = self.min
    return_val.max = self.max
    return_val.mean = self.mean
    return_val.stdev = self.stdev
    return_val.m2 = self.m2
    return return_val
end

return num