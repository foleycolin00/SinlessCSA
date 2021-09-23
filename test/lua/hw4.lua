local b4 = {}; for k,_ in pairs(_ENV) do b4[k] = k end

package.path = '../../src/lua/?.lua;' .. package.path

local tools = require('tools')
local skip = require('skip')
local num = require('num')
local sym = require('sym')
local goal = require('goal')
local sample = require('sample')
local klass = require('klass')

--load all the data samples
local weatherSample = sample:new()
weatherSample:load('../../data/weather.csv')

local pom3aSample = sample:new()
pom3aSample:load('../../data/pom3a.csv')

local auto93Sample = sample:new()
auto93Sample:load('../../data/auto93.csv')

--task 1: print the nearest and furthest item for each row for every sample

local start_time = os.clock()

for i = 1, #weatherSample.rows do
  local neighbors = weatherSample:neighbors(weatherSample.rows[i])
  -- row in question
  print(string.format('Row %d: {%s}', i, table.concat(weatherSample.rows[i], ", ")))
    -- closest
      io.write('Closest: {')
      print(table.concat(neighbors[1][1], " ") .. "}" .. " Distance: " .. neighbors[1][2])
    -- furthest
      io.write('Furthest: {')
      print(table.concat(neighbors[#neighbors][1], " ") .. "}" .. " Distance: " .. neighbors[#neighbors][2])
   print()
end

  for i = 1, #auto93Sample.rows do
    local neighbors = auto93Sample:neighbors(auto93Sample.rows[i])
    print(string.format('Row %d: {%s}', i, table.concat(auto93Sample.rows[i], ", ")))
    -- closest
    io.write('Closest: {')
    print(table.concat(neighbors[1][1], " ") .. "}" .. " Distance: " .. neighbors[1][2])
  -- furthest
    io.write('Furthest: {')
    print(table.concat(neighbors[#neighbors][1], " ") .. "}" .. " Distance: " .. neighbors[#neighbors][2])
    print()
  end


  --[[
for i = 1, #pom3aSample.rows do
  local neighbors = pom3aSample:neighbors(pom3aSample.rows[i])
  -- row in question
  print(string.format('Row %d: {%s}', i, table.concat(pom3aSample.rows[i], ", ")))
  -- closest
  io.write('Closest: {')
  print(table.concat(neighbors[1][1], " ") .. "}" .. " Distance: " .. neighbors[1][2])
-- furthest
  io.write('Furthest: {')
  print(table.concat(neighbors[#neighbors][1], " ") .. "}" .. " Distance: " .. neighbors[#neighbors][2])
  print()
end
]]
  local end_time = os.clock()

  local delta_time = end_time - start_time

  print(delta_time)