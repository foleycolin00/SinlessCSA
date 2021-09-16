local b4 = {}; for k,_ in pairs(_ENV) do b4[k] = k end

package.path = '../../src/lua/?.lua;' .. package.path

local sample = require('sample')
local skip = require('skip')
local num = require('num')
local sym = require('sym')
local goal = require('goal')
local klass = require('klass')

local sampleTest = sample:new()
sampleTest:load('../data/csv1_good.csv')

-- make another sample after load, just to make sure we can have multiple and dont overwrite
local clonedSample = sample:new()

-- need to test header gets filled with proper types
assert(getmetatable(sampleTest.headers[1]) == sym)
assert(getmetatable(sampleTest.headers[2]) == num)
assert(getmetatable(sampleTest.headers[3]) == skip)
assert(getmetatable(sampleTest.headers[4]) == klass)
assert(getmetatable(sampleTest.headers[5]) == goal)
assert(getmetatable(sampleTest.headers[6]) == goal)

-- need to test rows
local testTable = {
  {'sunny', 85, '85', 'FALSE', 10, 20},
  {'sunny', 80, '90', 'TRUE', 12, 40},
  {'overcast', 83, '86', 'FALSE', 40, 40},
  {'rainy', 70, '96', 'FALSE', 40, 50},
  {'rainy', 65, '70', 'TRUE', 4, 10},
  {'overcast', 64, '65', 'TRUE', 30, 60},
  {'sunny', 72, '95', 'FALSE', 7, 20},
  {'sunny', 69, '70', 'FALSE', 70, 70},
  {'rainy', 75, '80', 'FALSE', 80, 40},
  {'sunny', 75, '70', 'TRUE', 30, 50},
  {'overcast', 72, '90', 'TRUE', 60, 50},
  {'overcast', 81, '75', 'FALSE', 30, 60},
  {'rainy', 71, '91', 'TRUE', 50, 40}
}

-- checks that nums and goals are actually numbers, if they arent
-- this would fail, the rest stay as strings when they are stored
-- the values also display confidence in loading the rows from the file
for i = 1, #sampleTest.rows do
  for j = 1, #sampleTest.rows[i] do
    assert(sampleTest.rows[i][j] == testTable[i][j])
  end
end

-- test header function, use clonedSample to overwrite and make sure that works fine
local headerTableCheck = {'A!', 'Aaa', 'aaa', 'AAA+', 'aaa-', 'Aaa?'}

clonedSample:header(headerTableCheck)
assert(getmetatable(clonedSample.headers[1]) == klass)
assert(getmetatable(clonedSample.headers[2]) == num)
assert(getmetatable(clonedSample.headers[3]) == sym)
assert(getmetatable(clonedSample.headers[4]) == goal)
assert(getmetatable(clonedSample.headers[5]) == goal)
assert(getmetatable(clonedSample.headers[6]) == skip)

-- need to test cloning, check that the cloned item has all the values of the other
-- also change some values and make sure nothing changes on other
clonedSample = sampleTest:clone()
assert(getmetatable(clonedSample.headers[1]) == getmetatable(sampleTest.headers[1]))
assert(getmetatable(clonedSample.headers[2]) == getmetatable(sampleTest.headers[2]))
assert(getmetatable(clonedSample.headers[3]) == getmetatable(sampleTest.headers[3]))
assert(getmetatable(clonedSample.headers[4]) == getmetatable(sampleTest.headers[4]))
assert(getmetatable(clonedSample.headers[5]) == getmetatable(sampleTest.headers[5]))
assert(getmetatable(clonedSample.headers[6]) == getmetatable(sampleTest.headers[6]))


for i = 1, #sampleTest.rows do
  for j = 1, #sampleTest.rows[i] do
    assert(sampleTest.rows[i][j] == clonedSample.rows[i][j])
  end
end

clonedSample.rows[1][1] = 'diffValue'
sampleTest.rows[2][1] = 'anotherDiffValue'
assert(clonedSample.rows[1][1] == 'diffValue')
assert(sampleTest.rows[1][1] ~= 'diffValue')
assert(clonedSample.rows[2][1] ~= 'anotherDiffValue')
assert(sampleTest.rows[2][1] == 'anotherDiffValue')

assert(clonedSample ~= sampleTest)
assert(getmetatable(clonedSample) == getmetatable(sampleTest))

-- need to test zitler sort function
local zitlerSample = sample:new()
zitlerSample.headers = {goal:new('goal1', -1), goal:new('goal2', -1), goal:new('goal3', -1), goal:new('goal4', -1)}
local zitlerTable = {
  {1, 2, 3, 4}, -- 2 -- base condition
  {1, 1, 3, 4}, -- 1 -- -1 in a single row from base
  {1, 3, 5, 4}, -- 4 -- +2 in a single row from base
  {1, 2, 5, 4} -- 3  -- +2 in one row and +1 in another from base
}

-- all minimized, so lowest values at top, should result in this as shown above
local zitlerTableSorted = {
  {1, 1, 3, 4},
  {1, 2, 3, 4},
  {1, 2, 5, 4},
  {1, 3, 5, 4}
}

for i = 1, #zitlerTable do
  for j = 1, #zitlerTable[i] do
    zitlerSample.headers[i]:add(zitlerTable[i][j])
  end
end

zitlerSample.rows = zitlerTable

zitlerSample:sort_by_goal()

for i = 1, #zitlerTable do
  for j = 1, #zitlerTable[i] do
    assert(zitlerTable[i][j] == zitlerTableSorted[i][j])
  end
end

for k,_ in pairs(_ENV) do if not b4[k] then print("?? ".. k) end end