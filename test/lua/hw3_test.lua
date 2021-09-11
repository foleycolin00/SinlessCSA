package.path = '../../src/lua/?.lua;' .. package.path

tools = require('tools')
skip = require('skip')
num = require('num')
sym = require('sym')
goal = require('goal')
sample = require('sample')

samplobj = sample:new()
samplobj:load('../../data/weather.csv')

print('First object')

for key, value in pairs(samplobj.headers) do
  print('col_name ' .. value.name .. '\n')
  
    if getmetatable(value) == num then 
        print(value.min) 
        print(value.max)
        print(value.mean)
        print(value.stdev)
        print(value.count)
    end
    
    if getmetatable(value) == sym then 
        print(value.mode)
        print(value.mode_frequency)
    end
    
    if getmetatable(value) == skip then
      print(value.count)
    end
    
    if getmetatable(value) == goal then 
        print(value.min) 
        print(value.max)
        print(value.mean)
        print(value.stdev)
        print(value.count)
        print(value.weight)
    end
    
    print()
end

for key, value in pairs(samplobj.rows) do
  for i = 1, #value do
    io.write(value[i], ' ')
  end
  print()
end

new_samplobj = samplobj:clone()

print('Copy of first obj')
for key, value in pairs(new_samplobj.headers) do
  print('col_name ' .. value.name .. '\n')
  
    if getmetatable(value) == num then 
        print(value.min) 
        print(value.max)
        print(value.mean)
        print(value.stdev)
        print(value.count)
    end
    
    if getmetatable(value) == sym then 
        print(value.mode)
        print(value.mode_frequency)
    end
    
    if getmetatable(value) == skip then
      print(value.count)
    end
    
    if getmetatable(value) == goal then 
        print(value.min) 
        print(value.max)
        print(value.mean)
        print(value.stdev)
        print(value.count)
        print(value.weight)
    end
    
    
    print()
end

for key, value in pairs(new_samplobj.rows) do
  for i = 1, #value do
    io.write(value[i], ' ')
  end
  print()
end

samplobj.rows[2][1] = 'newVal'
new_samplobj.rows[3][1] = 'someOtherVal'

print()

for key, value in pairs(samplobj.rows) do
  for i = 1, #value do
    io.write(value[i], ' ')
  end
  print()
end

print()

for key, value in pairs(new_samplobj.rows) do
  for i = 1, #value do
    io.write(value[i], ' ')
  end
  print()
end

