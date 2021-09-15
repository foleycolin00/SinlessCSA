local b4 = {}; for k,_ in pairs(_ENV) do b4[k] = k end

-- a non parameteric collector

local some = {}

some.__index = some

-- create a new some object
function some:new(sample_list_max)
    -- what should go in here
    local o = { overall_items = 0,
                sample_list = {},
                max_items = sample_list_max or 256 }
    setmetatable(o, self)
    
    return o
end

function some:add(item)
  if #self.sample_list < self.max_items then
    self.overall_items = self.overall_items + 1
    self:insert_sorted(item)
  elseif some:rand() < #self.sample_list / self.overall_items then
    for i = math.floor( some:rand() * #self.sample_list + 1), #self.sample_list do
      self.sample_list[i] = self.sample_list[i + 1]
      self:insert_sorted(item)
    end
  end
end

function some:insert_sorted(item)
  
  if #self.sample_list == 0 then self.sample_list[1] = item
  else
    for i = #self.sample_list, 1, -1 do
      if item <= self.sample_list[i] or i == 1 then
        for j = #self.sample_list + 1, i + 1, -1 do
          self.sample_list[j] = self.sample_list[j - 1]
        end
        self.sample_list[i] = item
      end
    end
  end
  
  for i = 1, #self.sample_list do
  --  print(self.sample_list[i])
  end
  
  --print()
  
end

--- https://github.com/timm/keys/blob/main/src/rand.lua
local Seed = 62884 -- beware. do not lose control of your seeds

-- **randi(?lo : int, ?hi : int) : int**  
-- Return an int between `lo`  and `hi` (default 0..1).
function some:randi(lo,hi) 
  return math.floor(0.5 + rand(lo,hi)) end

-- **rand(?lo : num, ?hi : num) : float**   
-- Return a float between `lo`  and `hi` (default 0..1).
function some:rand(lo,hi,     mult,mod)
  lo,hi = lo or 0, hi or 1
  mult, mod = 16807, 2147483647
  Seed = (mult * Seed) % mod 
  return lo + (hi-lo) * Seed / mod end 

for k,_ in pairs(_ENV) do if not b4[k] then print("?? ".. k) end end

return some

