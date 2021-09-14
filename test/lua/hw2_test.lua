package.path = '../../src/lua/?.lua;' .. package.path

tools = require('tools')



-- while os.clock() - timeStart <= 1 do end

--[[
myTableHeaders, myTableRows = tools.csv('../../data/weather.csv')

print(string.format('Elapsed time: %f', os.clock() - timeStart))

assert(#myTableHeaders == 6, 'wrong number of header columns')

for i = 1, #myTableRows do
  assert(#myTableRows[i] == #myTableHeaders,
    string.format('row %d: %d number cols does not match header number cols %d',
      i, #myTableRows[i], #myTableHeaders))
end
]]
expected = {{'outlook','Temp','windy','Wins+','Play-'},
{'sunny',85,'FALSE',10,20},
{'sunny',80,'TRUE',12,40},
{'overcast',83,'FALSE',40,40},
{'rainy',70,'FALSE',40,50},
{'rainy',68,'FALSE',50,30},
{'rainy',65,'TRUE',4,10},
{'overcast',64,'TRUE',30,60},
{'sunny',72,'FALSE',7,20},
{'sunny',69,'FALSE',70,70},
{'rainy',75,'FALSE',80,40},
{'sunny',75,'TRUE',30,50},
{'overcast',72,'TRUE',60,50},
{'overcast',81,'FALSE',30,60},
{'rainy',71,'TRUE',50,40}}


for row in tools:csv('../../data/weather.csv') do
  for i = 1, #row do
    io.write(row[i], ', ')
  end
  print()
end


--[[ 
timeStart = os.clock()
timeEnd = os.clock()

timeTook = timeEnd - timeStart

io.write("Time took: %d", timeTook) ]]
