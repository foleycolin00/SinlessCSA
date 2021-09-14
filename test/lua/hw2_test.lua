local b4 = {}; for k,_ in pairs(_ENV) do b4[k] = k end

package.path = '../../src/lua/?.lua;' .. package.path

local tools = require('tools')

local timeStart = os.clock()

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

for row in tools:csv('../../data/weather.csv') do
  for i = 1, #row do
    io.write(row[i], ', ')
  end
  print()
end

for k,_ in pairs(_ENV) do if not b4[k] then print("?? ".. k) end end
