-- stores rows, which are simple lists made up of columns

-- stores headers, which define the name and type of a column

-- calling a function calls the particular function associated with the column type

-- reads in from the csv to construct the headers and rows

package.path = '?.lua;' .. package.path

local Sample = {}

tools = require('tools')
skip = require('skip')
num = require('num')
sym = require('sym')
goal = require('goal')

function Sample:new()
  local o = {}
  setmetatable(o, self)
  self.__index = self
  self.headers = {}
  self.rows = {}
  return o
end



function Sample:load(fileName)
  for row in tools:csv(fileName) do
    if #self.headers == 0 then
      if #row > 0 then Sample:header(row) end
      
        -- if ? then add skip
        -- if + or - then add goal
        -- if starts cap then add Num
        -- all other are Sym
        -- self.headers = row
        
    else
      local tmp = {}
      for i = 1, #row do
        table.insert(tmp, self.headers[i]:add(row[i]))
      end
      table.insert(self.rows, tmp)
    end
  end
end

function Sample:header(list)
  -- equivalent to isSkip, isGoal, isNum 
  -- ask about isKlass, what's klass goal in this context?

  for key, item in pairs(list) do 
    if string.find(item, '?') then -- isSkip
      table.insert(self.headers, skip)
      --return skip
    elseif string.find(item, '+') or string.find(item, '-') then -- weight: max or min
      table.insert(self.headers, goal)
      --return goal 
    elseif string.sub(1,1):match('%u') then -- uppercase isNum
      table.insert(self.headers, num)
      --return num
    else
      table.insert(self.headers, sym)
      --return sym
    end
  end
end


return Sample

