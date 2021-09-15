local b4 = {}; for k,_ in pairs(_ENV) do b4[k] = k end

package.path = '../../src/lua/?.lua;' .. package.path


local tools = require('tools')
local skip = require('skip')
local num = require('num')
local sym = require('sym')
local goal = require('goal')
local klass = require('klass')
local sample = require('sample')

local numSample = sample:new()

numSample:load('../../data/numTest.csv')

-- doesn't work with header with exclaimation point Temp!

for key, value in pairs(numSample.headers) do
  -- tests min, max, mean, stdev, count 
    if getmetatable(value) == num then 
        assert(value.min == 6)
        assert(value.max == 85)
        print(value.mean)
        assert(math.floor(value.mean) == 69)
        assert(math.floor(value.stdev) == 18)
        assert(value.count == 14)
        -- tests normalize
    end
end
for k,_ in pairs(_ENV) do if not b4[k] then print("?? ".. k) end end