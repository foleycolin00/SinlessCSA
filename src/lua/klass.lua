local b4 = {}; for k,_ in pairs(_ENV) do b4[k] = k end

local klass = {}

local sym = require('sym')

klass.__index = klass
setmetatable(klass, sym)

-- create a new klass object
function klass:new(col_name)
  local o = sym:new(col_name)
  setmetatable(o, self)
  
  return o
end

function klass:clone()
    local return_val = klass:new(self.name) 
    return_val.count = self.count
    return_val.mode = self.mode
    return_val.mode_frequency = self.mode_frequency
    
    -- copy symbols over
    for i = 1, #self.symbol_list do
      return_val.symbol_list[i] = self.symbol_list[i]
    end

    return return_val
end

for k,_ in pairs(_ENV) do if not b4[k] then print("?? ".. k) end end

return klass