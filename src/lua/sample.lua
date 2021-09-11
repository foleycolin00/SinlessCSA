-- stores rows, which are simple lists made up of columns

-- stores headers, which define the name and type of a column

-- calling a function calls the particular function associated with the column type

-- reads in from the csv to construct the headers and rows

package.path = '?.lua;' .. package.path

local sample = {}

sample.__index = sample

tools = require('tools')
skip = require('skip')
num = require('num')
sym = require('sym')
goal = require('goal')


-- create a new sample object
function sample:new()
  local o = { headers = {},
              rows = {} }
  setmetatable(o, self)

  return o
end



function sample:load(fileName)
  for row in tools:csv(fileName) do
    if #self.headers == 0 then
      if #row > 0 then self:header(row) end
    else
      local tmp = {}
      for i = 1, #row do
        --unsure about this line of code
        table.insert(tmp, self.headers[i]:add(row[i]))
      end
      -- loads rows in temporary array
      table.insert(self.rows, tmp)
    end
  end
end
  
  
function sample:header(list)
  -- equivalent to isSkip, isGoal, isNum 
  -- ask about isKlass, what's klass in this context?
  
  for key, item in pairs(list) do
    if string.find(item, '?') then -- isSkip
      table.insert(self.headers, skip:new(item))
      --return skip
    elseif string.find(item, '+') or string.find(item, '-') then -- weight: max or min
      local weight = string.find(item, '+') and 1 or -1
      table.insert(self.headers, goal:new(item, weight))
      --return goal 
    elseif string.sub(item,1,1):match('[A-Z]') then -- uppercase isNum
      table.insert(self.headers, num:new(item))
      --return num
    else
      table.insert(self.headers, sym:new(item))
      --return sym
    end
  end
end


function sample:clone()
  local ret_sample = sample:new()
  -- clone the header value
  for i = 1, #self.headers do
    ret_sample.headers[i] = self.headers[i]:clone()
  end
  
  for i = 1, #self.rows do
    local item = {}
    for j = 1, #self.rows[i] do
      item[j] = self.rows[i][j]
    end
    ret_sample.rows[i] = item
  end
  
  return ret_sample
end

return sample

