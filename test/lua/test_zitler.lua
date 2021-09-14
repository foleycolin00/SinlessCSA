local b4 = {}; for k,_ in pairs(_ENV) do b4[k] = k end

package.path = '../../src/lua/?.lua;' .. package.path

local tools = require('tools')
local skip = require('skip')
local num = require('num')
local sym = require('sym')
local goal = require('goal')
local sample = require('sample')
local klass = require('klass')

local autoSample = sample:new()
autoSample:load('../../data/auto93.csv')

local weatherSample = sample:new()
weatherSample:load('../../data/weather.csv')

local pomSample = sample:new()
pomSample:load('../../data/pom3a.csv')


--autoSample:og_sort()
--autoSample:sort_by_goal()

print('autoSample \n')
for i = 1, 5 do
    for j = 1, #autoSample.rows[i] do 
        io.write(autoSample.rows[i][j], ' ')
    end
    
    print()
end
print()

for i = #autoSample.rows - 5, #autoSample.rows do
    for j = 1, #autoSample.rows[i] do 
        io.write(autoSample.rows[i][j], ' ')
    end
    
    print()
end

-- weatherSample:og_sort()

print('weatherSample \n')
for i = 1, #weatherSample.rows do
    for j = 1, #weatherSample.rows[i] do 
        io.write(weatherSample.rows[i][j], ' ')
    end
    
    print()
end
print()

--pomSample:og_sort()
--pomSample:sort_by_goal()
-- table.sort(pomSample.rows, function(a, b) return pomSample:zitler(a, b) end)

print('pomSample \n')
for i = 1, 5 do
    for j = 1, #pomSample.rows[i] do 
        io.write(pomSample.rows[i][j], ' ')
    end
    
    print()
end
print()

for k,_ in pairs(_ENV) do if not b4[k] then print("?? ".. k) end end