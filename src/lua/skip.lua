local skip = {}

skip.__index = skip

function skip:new(col_name)
    local o = { name = col_name or '',
                count = 0 }
    setmetatable(o, self)
    return o
end

function skip:add(x)
    self.count = self.count + 1
    return x
end

function skip:clone()
    local return_val = skip:new(self.name) 
    return_val.count = self.count

    return return_val
end

return skip