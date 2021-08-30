package.path = '../../src/lua/?.lua;' .. package.path

tools = require('tools')

myTableHeaders, myTableRows = tools.csv('../../data/weather.csv')

assert(#myTableHeaders == 6, 'wrong number of header columns')

for i = 1, #myTableRows do
  assert(#myTableRows[i] == #myTableHeaders,
    string.format('row %d: %d number cols does not match header number cols %d',
      i, #myTableRows[i], #myTableHeaders))
end