local klass = {}

num = require('num')

klass.__index = klass
setmetatable(klass, num)

-- create a new klass object
function klass:new(col_name)
  local o = num:new(col_name)
  setmetatable(o, self)
  return o
end

function klass:clone()
    local return_val = klass:new(self.name)
    return_val.count = self.count
    return_val.min = self.min
    return_val.max = self.max
    return_val.mean = self.mean
    return_val.stdev = self.stdev
    return_val.m2 = self.m2
    return return_val
end


return klass