local sym = {}

sym.__index = sym

function sym:new(col_name)
    local o = { name = col_name or '',
                count = 0,
                mode = nil,
                mode_frequency = 0,
                symbol_list = {} }
    setmetatable(o, self)
    
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

function sym:clone()
    local return_val = sym:new(self.name) 
    return_val.count = self.count
    return_val.mode = self.mode
    return_val.mode_frequency = self.mode_frequency
    
    -- copy symbols over
    for i = 1, #self.symbol_list do
      return_val.symbol_list[i] = self.symbol_list[i]
    end

    return return_val
end

return sym