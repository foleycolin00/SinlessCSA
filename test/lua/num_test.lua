local b4 = {}; for k,_ in pairs(_ENV) do b4[k] = k end

package.path = '../../src/lua/?.lua;' .. package.path

local goal = require('goal')
local sample = require('sample')

local numSample = sample:new()

numSample:load('../../data/numTest.csv')


for key, value in pairs(numSample.headers) do
    print("in here")
  -- tests min, max, mean, stdev, count 
    if getmetatable(value) == num then
        print("in here") 
        -- whathappend?
        print(value.min)
        print(value.max)
        assert(value.min == 6)
        assert(value.max == 85)
        assert(math.floor(value.mean) == 69)
        assert(math.floor(value.stdev) == 18)
        assert(value.count == 14)
        
    end
end

-- test clone
local numSampleClone = numSample:clone()

for key, value in pairs(numSampleClone.headers) do
      if getmetatable(value) == num then 
          assert(value.min == 6)
          assert(value.max == 85)
          assert(math.floor(value.mean) == 69)
          assert(math.floor(value.stdev) == 18)
          assert(value.count == 14)
      end
end


for k,_ in pairs(_ENV) do if not b4[k] then print("?? ".. k) end end