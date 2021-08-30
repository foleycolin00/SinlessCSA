package.path = '../../src/lua/?.lua;' .. package.path

tools = require('tools')

myTableHeaders, myTableRows = tools.csv('../../data/weather.csv')

print(table.concat(myTableHeaders, ','))


for i = 1, #myTableRows do
  --print(table.concat(myTableRows[i], ','))
end