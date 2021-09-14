local b4 = {}; for k,_ in pairs(_ENV) do b4[k] = k end

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

for k,_ in pairs(_ENV) do if not b4[k] then print("?? ".. k) end end

return skip