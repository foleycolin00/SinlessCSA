local b4 = {}; for k,_ in pairs(_ENV) do b4[k] = k end

package.path = '../../src/lua/?.lua;' .. package.path


local tools = require('tools')
local skip = require('skip')
local num = require('num')
local sym = require('sym')
local goal = require('goal')
local klass = require('klass')
local sample = require('sample')

local skipSample = sample:new()
local numSample = sample:new()


skipSample:load('../../data/skipTest.csv')
-- test skip, count
-- one data set
for key, value in pairs(skipSample.headers) do
    if getmetatable(value) == num then 
        assert(value.count == 14)
    end
end

-- same dataset but two '?'
for key, value in pairs(skipSample.headers) do
    if getmetatable(value) == skip then 
        assert(value.count == 16)
    end
end
--it skips!!

-- test clone
local skipSampleClone = skipSample:clone()
for key, value in pairs(skipSampleClone.headers) do
    if getmetatable(value) == skip then 
        assert(value.count == 16)
    end
end


for k,_ in pairs(_ENV) do if not b4[k] then print("?? ".. k) end end