local b4 = {}; for k,_ in pairs(_ENV) do b4[k] = k end

local num = {}

num.__index = num

local some = require('some')

-- create a new num object
function num:new(col_name)
  local o = { name = col_name or '',
              count = 0,
              min = nil,
              max = nil,
              mean = 0,
              stdev = 0,
              m2 = 0,
              sample_list = some:new() }
  setmetatable(o, self)
  
  return o
end

function num:add(x)
  x = tonumber(x) or x
  
  if type(x) ~= 'number' then
    return x
  end
  
  self.sample_list:add(x)
  
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

function num:norm(x)
  if type(x) ~= 'number' then return x end
  
  if self.max == self.min then --[[print("Normalization Error: Divide by zero")]] return 1 end 

  return (x - self.min) / (self.max - self.min)
end 


for k,_ in pairs(_ENV) do if not b4[k] then print("?? ".. k) end end

return num