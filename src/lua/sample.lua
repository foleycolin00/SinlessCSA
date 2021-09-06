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

function Sample.new()
  newObj = {headers = {}, rows = {}}
  self.__index = self
  setmetatable(newObj, self)
end

function Sample.load(fileName)
  for row in tools.csv(fileName) do
    if #self.headers == 0 then
      for i = 0, #row do
        -- if ? then add skip
        -- if + or - then add goal
        -- if starts cap then add Num
        -- all other are Sym
      end
      -- self.headers = row
    else
      tmp = {}
      for i = 0, #row do
        table.insert(tmp, self.headers[i].add(row[i]))
      end
      
      table.insert(rows, tmp)
    end
    
  end
end

function Sample.header(str)
  if string.find(str, '?') then
    return skip
  else
    return nil
  end
end


return Sample

