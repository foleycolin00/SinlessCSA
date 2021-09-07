package.path = '../../src/lua/?.lua;' .. package.path

tools = require('tools')
skip = require('skip')
num = require('num')
sym = require('sym')
goal = require('goal')
sample = require('sample')

samplobj = sample:new()
samplobj:load('../../data/weather.csv')

for key, value in pairs(samplobj.headers) do
    if getmetatable(value) == num then 
        print(value.min) 
        print(value.max)
        print(value.mean)
    end

    if getmetatable(value) == sym then 
        print(value.mode)
        print(value.mode_frequency)
    end

end


