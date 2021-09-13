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



return klass