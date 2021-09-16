local b4 = {}; for k,_ in pairs(_ENV) do b4[k] = k end

package.path = '../../src/lua/?.lua;' .. package.path


local tools = require('tools')
local skip = require('skip')
local num = require('num')
local sym = require('sym')
local goal = require('goal')
local klass = require('klass')
local sample = require('sample')

local symSample = sample:new()

symSample:load('../../data/symTest.csv')

-- test count, mode 
-- don't handle multimodal 

for key, value in pairs(symSample.headers) do
    if getmetatable(value) == sym then 
        assert(value.count == 14)
        assert(value.mode == 'sunny')
    end
end

-- test clone 
local symSampleClone = symSample:clone()

for key, value in pairs(symSampleClone.headers) do
      if getmetatable(value) == sym then 
        assert(value.count == 14)
        assert(value.mode == 'sunny')
    end
end