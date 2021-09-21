--- This sample class is used for classification.
-- @module sample.lua
-- @author Steven Jones & Azeeza Eagal
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
local settings = require('settings')

--- This function creates a new sample object.
-- @function new
-- @return a new sample object
function sample:new()
  local o = { headers = {},
              rows = {},
              settings = settings:new(),
              children = {},
              c}
  setmetatable(o, self)
  
  return o
end

--- This function loads in data from a file.
-- @function load
-- @param filename the file path
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
  
--- This function discerns the attributes of the columns.
-- @function header
-- @param list a list of the headers
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

--- This function clones sample object.
-- @function clone
-- @return a clone of a sample object
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

--- This function creates a sub-sample. 
-- @function createSubSample 
-- @param list a list of data points
-- @return a new sub-sample
function sample:createSubSample(list)
  local newSample = sample:new()
  newSample.settings = self.settings
  
  for i = 1, #self.headers do
    newSample.headers[i] = getmetatable(self.headers[i]):new()
  end
  
  for i = 1, #list do
    for j = 1, #list[i] do
      newSample.headers[j]:add(list[i][j])
    end
    
    table.insert(newSample.rows, list[i])
  end
  
  table.insert(self.children, newSample)
  
  return newSample
end

---This function creates a dendogram.
-- @function dendogram 
-- @param inString denotes the levels of the tree
-- @param the_dendogram 
function sample:dendogram(inString, the_dendogram)
  local dendogram = {}
  
  local level = '../' .. (inString or '')
  
  for i = 1, #self.children do
    self.children[i]:dendogram(level, the_dendogram or dendogram)
  end
  
  level = level .. ' n = ' .. #self.rows
  
  if self.c then
    level = level .. ', c = ' .. string.format('%.2f', self.c or '')
  end
  
  if #self.children == 0 then
    level = level .. '    randomRow = { ' .. table.concat(self.rows[#self.rows // 2], ', ') .. ' }'
  end
  
  if the_dendogram then
    table.insert(the_dendogram, level)
  else
    table.insert(dendogram, level)
    for i = #dendogram, 1, -1 do
      print(dendogram[i])
    end
  end
end


--- This function performs the zitler continous domination predicate.
-- @function zitler
-- @param row1 a row to compare
-- @param row2 another row to compare
-- @return the value to determine the better row
function sample:zitler(row1, row2)
  local s1 = 0
  local s2 = 0
  local e = math.exp(1)

  for i = 1, #self.headers do
    local column = self.headers[i]
    if getmetatable(column) == goal then
      local w = column.weight 
      local x = column:norm(row1[i])
      local y = column:norm(row2[i])

      s1 = s1 - e^( w * ((x - y) / column.count) )

      s2 = s2 - e^(w * ((y - x) / column.count) )
    end
  end
  
  return s1 < s2 
end

--- This function returns the distance between two row points. 
-- @function distance
-- @param row1 one row to compare to another
-- @param row2 one row to compare to another
-- @return the distance between two rows
function sample:distance(row1, row2)
  local sum = 0
  local n = 0
  
  for i = 1, #row1 do
    if getmetatable(self.headers[i]) ~= skip and getmetatable(self.headers[i]) ~= goal and getmetatable(self.headers[i]) ~= klass then
      n = n + 1
      sum = sum + (self.headers[i]:distance(row1[i], row2[i]))^self.settings.p
    end
  end

  return (sum / n)^(1 / self.settings.p)
end

--[[
function sample:distance_heuristic(row1, row2)  
end
]]

---This function returns the neighbors of a row. 
-- @function neighbors
-- @param row a single row
-- @param rows all the other rows 
-- @return a list of neighbors 
function sample:neighbors(row, rows)
  local neighbor_list = {}
  for key, value in pairs(rows or self.rows) do
    if value ~= row then
      table.insert(neighbor_list, {value, self:distance(row, value)})
    end
  end
  
  table.sort(neighbor_list, function (x, y) return x[2] < y[2] end)
  
  return neighbor_list
end

--- This function sorts a table by its goal using the zitler continous domination predicate. 
-- @function sort_by_goal
function sample:sort_by_goal()
  table.sort(self.rows, function (a, b) return self:zitler(a, b) end)
end

---This function returns a list of ___. 
-- @function faraway 
-- @param row a single row
-- @param rows all other rows
-- @return 
function sample:faraway(row, rows)
  rows = rows or self.rows
  local distance_list = self:neighbors(row, rows)
  return distance_list[math.floor(self.settings.far * #rows)][1]
end


--- This function recursively divide rows down to size #rows^(enough = .5).
-- @return one table per leaf
function sample:divide()
  local out = {}
  local enough = (#self.rows)^self.settings.enough
  
  -- adds to set of samples when they are sufficiently small
  -- or continue splitting
  local function run(sample) 
    if #sample.rows < enough then
      table.insert(out, sample)
    else
      -- splits in half
      local l, r, c = self:div(sample.rows)
      sample.c = c
      run(sample:createSubSample(l))
      run(sample:createSubSample(r))
    end
  end ----------------------------------------------
  
  -- starts the process of splitting
  run(self)
  
  -- out are samples
  -- better is zitler function
  return out
end

---This function splits rows via their distance to 2 faraway points.
-- @param rows all rows 
-- @return ___.
function sample:div(rows)
  rows = rows or self.rows
  local one = self:faraway(rows[ math.floor(tools:rand() * #rows) + 1 ],
                     tools:randomSubList(rows, self.settings.samples))
  local two = self:faraway(one,  tools:randomSubList(rows, self.settings.samples))
  
  local c = self:distance(one, two)
  
  local tmp = {}
  for key, value in pairs(rows) do
    local a = self:distance(value, one)
    local b = self:distance(value, two)
    table.insert(tmp, {value, (a^2 + c^2 - b^2) / (2 * c) })
  end
  
  table.sort(tmp, function(x,y) return x[2] < y[2] end)
  
  local l = {}
  local r = {}
  
  for i = 1, math.floor(#tmp / 2) do
    table.insert(l, tmp[i][1])
  end

  for i = math.floor(#tmp / 2) + 1, #tmp do
    table.insert(r, tmp[i][1])
  end
  
  return l, r, c
end

for k,_ in pairs(_ENV) do if not b4[k] then print("?? ".. k) end end

return sample