local b4 = {}; for k,_ in pairs(_ENV) do b4[k] = k end

package.path = '../../src/lua/?.lua;' .. package.path

local klass = require('klass')
local sample = require('sample')

local klassSample = sample:new()

klassSample:load('../../data/symTest.csv')

--handle multimodal 

-- test count and mode
for key, value in pairs(klassSample.headers) do
    if getmetatable(value) == klass then 
        assert(value.count == 14)
        assert(value.mode == 'sunny')
    end
end


-- test clone 
local klassSampleClone = klassSample:clone()

for key, value in pairs(klassSampleClone.headers) do
      if getmetatable(value) == klass then 
        assert(value.count == 14)
        assert(value.mode == 'sunny')
    end
end