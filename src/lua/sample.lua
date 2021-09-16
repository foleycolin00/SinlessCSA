local b4 = {}; for k,_ in pairs(_ENV) do b4[k] = k end

-- stores rows, which are simple lists made up of columns

-- stores headers, which define the name and type of a column

-- calling a function calls the particular function associated with the column type

-- reads in from the csv to construct the headers and rows

package.path = '?.lua;' .. package.path

local sample = {}

sample.__index = sample

local tools = require('tools')
local skip = require('skip')
local num = require('num')
local sym = require('sym')
local goal = require('goal')
local klass = require('klass')


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
        table.insert(tmp, self.headers[i]:add(row[i]))
      end
      table.insert(self.rows, tmp)
    end
  end
end
  
  
function sample:header(list)
  -- equivalent to isSkip, isGoal, isNum, isKlass
  for key, item in pairs(list) do
    if string.find(item, '?') then -- isSkip
      table.insert(self.headers, skip:new(item))
    elseif string.find(item, '+') or string.find(item, '-') then -- weight: max or min
      local weight = string.find(item, '+') and 1 or -1
      table.insert(self.headers, goal:new(item, weight))
    elseif string.find(item, '!')  then
      table.insert(self.headers, klass:new(item))
    elseif string.sub(item,1,1):match('[A-Z]') then -- uppercase isNum
      table.insert(self.headers, num:new(item))
    else
      table.insert(self.headers, sym:new(item))
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

function sample:zitler(row1, row2)
  local s1 = 0
  local s2 = 0
  local e = math.exp(1)
  local goal_count = 0

  for i = 1, #self.headers do
    local column = self.headers[i]
    if getmetatable(column) == goal then
      goal_count = goal_count + 1
      local w = column.weight 
      local x = column:norm(row1[i])
      local y = column:norm(row2[i])

      s1 = s1 - e^( w * ((x - y) / column.count) )

      s2 = s2 - e^(w * ((y - x) / column.count) )
    end
  end
  
  return s1 < s2 
end

function sample:sort_by_goal()
  table.sort(self.rows, function (a, b) return self:zitler(a, b) end)
end

for k,_ in pairs(_ENV) do if not b4[k] then print("?? ".. k) end end

return sample

