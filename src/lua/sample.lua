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

function Sample.new()
  newObj = {headers = {}, rows = {}}
  self.__index = self
  return setmetatable(newObj, self)
end



function Sample.load(fileName)
  print("got here")
  for row in tools.csv(fileName) do
    if #self.headers == 0 then
      
      Sample.header(row)
        -- if ? then add skip
        -- if + or - then add goal
        -- if starts cap then add Num
        -- all other are Sym
        -- self.headers = row
        
    else
      tmp = {}
      for i = 0, #row do
        table.insert(tmp, self.headers[i].add(row[i]))
      end
    --maybe an end will be a problem later
      table.insert(rows, tmp)
    end
    
  end
end

function Sample.header(list)
  -- equivalent to isSkip, isGoal, isNum 
  -- ask about isKlass, what's klass goal in this context?
  
  self.headers = #list

  for item in list do 

    if string.find(item, '?') then -- isSkip
      return skip
    elseif string.find(item, '+') or string.find(item, '-') then -- weight: max or min
      return goal 
    elseif string.sub(1,1):match('%u') then -- uppercase isNum
      return num
    else
      return sym
    end
    
  end
end


return Sample

