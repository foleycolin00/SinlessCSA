package.path = '../../src/lua/?.lua;' .. package.path

tools = require('tools')
skip = require('skip')
num = require('num')
sym = require('sym')
goal = require('goal')
sample = require('sample')

samplobj = sample:new()
samplobj:load('../../data/auto93.csv')

for key, value in pairs(samplobj.rows) do
    for i = 1, #value do 
        io.write(value[i], ' ')
    end
    print()
end


--table.sort(samplobj.rows, samplobj:zitler())

print(unpack(samplobj:sort_by_goal()))