local b4={}; for k,_ in pairs(_ENV) do b4[k]=k end -- first line

local klass = {}

sym = require('sym')

klass.__index = klass
setmetatable(klass, sym)

-- create a new klass object
function klass:new(col_name)
  local o = sym:new(col_name)
  setmetatable(o, self)
  return o
end


for k,_ in pairs(_ENV) do if not b4[k] then print("?? "..k) end end -- last lines before return
return klass
