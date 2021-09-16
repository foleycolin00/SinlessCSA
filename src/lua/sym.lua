local b4 = {}; for k,_ in pairs(_ENV) do b4[k] = k end

local sym = {}
local max = 0
local multimodal = {}

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
  -- skip if entry is a question mark
  if x == '?' then return x end
  
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
    for key, value in pairs(self.symbol_list) do
      return_val.symbol_list[key] = value
    end

    return return_val
end

for k,_ in pairs(_ENV) do if not b4[k] then print("?? ".. k) end end

return sym