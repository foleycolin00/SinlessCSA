local b4 = {}; for k,_ in pairs(_ENV) do b4[k] = k end

package.path = '../../src/lua/?.lua;' .. package.path

local tools = require('tools')
local skip = require('skip')
local num = require('num')
local sym = require('sym')
local goal = require('goal')
local sample = require('sample')
local klass = require('klass')

local samplobj = sample:new()
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
        --for i = 1, #value.sample_list.sample_list do
           --print('hello')
        --end
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
--[[
local new_samplobj = samplobj:clone()

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
    if getmetatable(value) == klass then 
      print("HERE! HERE! HERE!")
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
]]


for k,_ in pairs(_ENV) do if not b4[k] then print("?? ".. k) end end