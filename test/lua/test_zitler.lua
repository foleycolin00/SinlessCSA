package.path = '../../src/lua/?.lua;' .. package.path

tools = require('tools')
skip = require('skip')
num = require('num')
sym = require('sym')
goal = require('goal')
sample = require('sample')
klass = require('klass')

autoSample = sample:new()
autoSample:load('../../data/auto93.csv')

weatherSample = sample:new()
weatherSample:load('../../data/weather.csv')

pomSample = sample:new()
pomSample:load('../../data/pom3a.csv')


--autoSample:og_sort()

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

-- pomSample:og_sort()

print('pomSample \n')
for i = 1, 5 do
    for j = 1, #pomSample.rows[i] do 
        io.write(pomSample.rows[i][j], ' ')
    end
    
    print()
end
print()