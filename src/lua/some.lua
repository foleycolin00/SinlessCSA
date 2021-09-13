-- a non parameteric collector

local some = {}

some.__index = some

-- create a new some object
function some:new(sample_list_max)
    -- what should go in here
    local o = { sample_list = {},
                max_items = sample_list_max or 256 }
    setmetatable(o, self)
    
    return o
end

function some:add(item)
  if #self.sample_list < self.max_items then
    self:insert_sorted(item)
  end
  
end

function some:insert_sorted(item)
  for i = 1, #self.sample_list do
    print(self.sample_list[i])
  end
  
  print()
  
  if #self.sample_list == 0 then self.sample_list[1] = item end
  
  for i = 1, #self.sample_list do
    if item <= self.sample_list[i] then
      for j = #self.sample_list + 1, i + 1, -1 do
        self.sample_list[j] = self.sample_list[j - 1]
      end
      self.sample_list[i] = item
    end
  end
end

return some

