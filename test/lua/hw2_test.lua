local b4 = {}; for k,_ in pairs(_ENV) do b4[k] = k end

package.path = '../../src/lua/?.lua;' .. package.path

local tools = require('tools')

-- work in progress 

expected = {{"# weather"}
{outlook, Temp!, ?Humidity, windy,Wins+,Play-},
{sunny,85,85,FALSE,10,20}
sunny,80,90,TRUE, 12,40
overcast,83,86,FALSE,40,40
rainy,70,96,FALSE,40,50
rainy,68,80,FALSE,  # data quick. cn you handle it?
       50,30
rainy,65,70,TRUE,4,10
overcast,64,65,TRUE,30,60
sunny,72,95,FALSE,7,20 #adsas
sunny,69,70,FALSE,70,70
rainy,75,80,FALSE,80,40
sunny,75,70,TRUE,30,50
overcast,72,90,TRUE,60,50
overcast,81,75,FALSE,30,60
rainy,71, 91, TRUE ,50,40}


for row in tools:csv('../../data/weather.csv') do
  for i = 1, #row do
    assert(row[i] == expected[i])
  end
  print()
end

for k,_ in pairs(_ENV) do if not b4[k] then print("?? ".. k) end end



-- while os.clock() - timeStart <= 1 do end

--[[
  local timeStart = os.clock()
myTableHeaders, myTableRows = tools.csv('../../data/weather.csv')

print(string.format('Elapsed time: %f', os.clock() - timeStart))

assert(#myTableHeaders == 6, 'wrong number of header columns')

for i = 1, #myTableRows do
  assert(#myTableRows[i] == #myTableHeaders,
    string.format('row %d: %d number cols does not match header number cols %d',
      i, #myTableRows[i], #myTableHeaders))
end
]]