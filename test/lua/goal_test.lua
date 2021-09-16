local b4 = {}; for k,_ in pairs(_ENV) do b4[k] = k end

package.path = '../../src/lua/?.lua;' .. package.path

local sample = require('sample')
local goal = require('goal')

local goalSample = sample:new()
local negativeGoalSample = sample:new()

goalSample:load('../../data/numTest.csv')

for key, value in pairs(goalSample.headers) do
-- tests min, max, mean, stdev, count, and max weight
    if getmetatable(value) == goal then 
        assert(value.min == 4)
        assert(value.max == 80)
        assert(math.floor(value.mean) == 34)
        assert(math.floor(value.stdev) == 24)
        assert(value.count == 14)
        assert(value.weight == 1)
    end
end
  
-- test clone
local goalSampleClone = goalSample:clone()
  
for key, value in pairs(goalSampleClone.headers) do
    if getmetatable(value) == goal then 
        assert(value.min == 4)
        assert(value.max == 80)
        assert(math.floor(value.mean) == 34)
        assert(math.floor(value.stdev) == 24)
        assert(value.count == 14)
        assert(value.weight == 1)  
    end
end

-- test goal sample min weight
negativeGoalSample:load('../../data/goalTest.csv')

for key, value in pairs(negativeGoalSample.headers) do
    -- tests min, max, mean, stdev, count, and min weight
        if getmetatable(value) == goal then 
            assert(value.min == 10)
            assert(value.max == 70)
            assert(math.floor(value.mean) == 37)
            assert(math.floor(value.stdev) == 17)
            assert(value.count == 14)
            assert(value.weight == -1)
        end
    end
  
  for k,_ in pairs(_ENV) do if not b4[k] then print("?? ".. k) end end