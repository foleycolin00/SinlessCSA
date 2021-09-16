local b4 = {}; for k,_ in pairs(_ENV) do b4[k] = k end

package.path = '../../src/lua/?.lua;' .. package.path

local tools = require('tools')

local a = {}
local b = {}

-- putting the contens of the csv file in a table
for row in tools:csv('../data/csv1_good.csv') do  
  table.insert(a, row)
end

-- putting the contens of the csv file in a table
for row in tools:csv('../data/csv2_diabolical.csv') do
  table.insert(b, row)
end

-- check first

assert(table.concat(a[1]) == table.concat({'outlook', 'Temp', '?Humidity', 'windy!', 'Wins+', 'Play-'}))
assert(table.concat(a[2]) == table.concat({'sunny', '85', '85', 'FALSE', '10', '20'}))
assert(table.concat(a[3]) == table.concat({'sunny', '80', '90', 'TRUE', '12', '40'}))
assert(table.concat(a[4]) == table.concat({'overcast', '83', '86', 'FALSE', '40', '40'}))
assert(table.concat(a[5]) == table.concat({'rainy', '70', '96', 'FALSE', '40', '50'}))
assert(table.concat(a[6]) == table.concat({'rainy', '65', '70', 'TRUE', '4', '10'}))
assert(table.concat(a[7]) == table.concat({'overcast', '64', '65', 'TRUE', '30', '60'}))
assert(table.concat(a[8]) == table.concat({'sunny', '72', '95', 'FALSE', '7', '20'}))
assert(table.concat(a[9]) == table.concat({'sunny', '69', '70', 'FALSE', '70', '70'}))
assert(table.concat(a[10]) == table.concat({'rainy', '75', '80', 'FALSE', '80', '40'}))
assert(table.concat(a[11]) == table.concat({'sunny', '75', '70', 'TRUE', '30', '50'}))
assert(table.concat(a[12]) == table.concat({'overcast', '72', '90', 'TRUE', '60', '50'}))
assert(table.concat(a[13]) == table.concat({'overcast', '81', '75', 'FALSE', '30', '60'}))
assert(table.concat(a[14]) == table.concat({'rainy', '71', '91', 'TRUE', '50', '40'}))

-- check second

assert(table.concat(b[1]) == table.concat({'outlook', 'Temp', '?Humidity', 'windy!', 'Wins+', 'Play-'}))
assert(table.concat(b[2]) == table.concat({'sunny', '85', '85', 'FALSE', '10', '20'}))
assert(table.concat(b[3]) == table.concat({'sunny', '80', '90', 'TRUE', '12', '40'}))
assert(table.concat(b[4]) == table.concat({'overcast', '83', '86', 'FALSE', '40', '40'}))
assert(table.concat(b[5]) == table.concat({'rainy', '70', '96', 'FALSE', '40', '50'}))
assert(table.concat(b[6]) == table.concat({'rainy', '65', '70', 'TRUE', '4', '10'}))
assert(table.concat(b[7]) == table.concat({'overcast', '64', '65', 'TRUE', '30', '60'}))
assert(table.concat(b[8]) == table.concat({'sunny', '72', '95', 'FALSE', '7', '20'}))
assert(table.concat(b[9]) == table.concat({'sunny', '69', '70', 'FALSE', '70', '70'}))
assert(table.concat(b[10]) == table.concat({'rainy', '75', '80', 'FALSE', '80', '40'}))
assert(table.concat(b[11]) == table.concat({'overcast', '72', '90', 'TRUE', '60', '50'}))
assert(table.concat(b[12]) == table.concat({'overcast', '81', '75', 'FALSE', '30', '60'}))
assert(table.concat(b[13]) == table.concat({'rainy', '71', '91', 'TRUE', '50', '40'}))

for k,_ in pairs(_ENV) do if not b4[k] then print("?? ".. k) end end