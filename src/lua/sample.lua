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
local some_sample = require('some_sample')


--- This function creates a new sample object.
-- @function new
-- @return a new sample object
function sample:new()
  local o = { headers = {},
              rows = {},
              settings = settings:new() }
  setmetatable(o, self)
  
  o.sample_list = some_sample:new(o)
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
      self.sample_list:add(tmp)
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
function sample:sort_by_goal()
  table.sort(self.rows, function (a, b) return self:zitler(a, b) end)
end

function sample:faraway(row, rows)
  local distance_list = self:neighbors(row, rows or self.rows)
  return distance_list[self.settings.far * #all // 1][1]
end

--[[
--- Recursive divide rows down to size #rows^(enough = .5)
-- return one table per leaf
function sample:divide()
  -- adds to set of samples when they are sufficiently small
  -- or continue splitting
  function run()
    if #rows < enough then
      table.insert(out, self:clone(rows))
    else
      -- splits in half
      l, r = self:div(rows)
      run(l, lvl + 1)
      run(r, lvl + 1)
    end
  end ----------------------------------------------

  out = {}
  enough = 2 * self.rows^0.5
  
  -- starts the process of splitting
  run(self.rows, 0)
  
  better = function(t1, t2) return self:zitler(t1:mid(), t2:mid()) end
  -- out are samples
  -- better is zitler function
  return table.sort(out, better)
end

--- split rows via their distance to 2 faraway points
function sample:div(rows)
  one = self:faraway(randomRow)
  two = self:faraway(one)
  
  c = self:distance(one, two)
  
  tmp = {}
  for key, value in pairs(rows) do
    a = self:dist(value, one)
    b = self:dist(value, two)
    table.insert(tmp, {value, (a^2 + c^2 - b^2) / (2 * c) })
  end
  l, r = {}, {}
  
  for key, value in pairs(tmp) do
    -- put smallest in left and largest on right of tmp[2]
  end
  
  return l, r
end
]]



for k,_ in pairs(_ENV) do if not b4[k] then print("?? ".. k) end end

return sample

