local b4 = {}; for k,_ in pairs(_ENV) do b4[k] = k end

package.path = '../../src/lua/?.lua;' .. package.path

local tools = require('tools')
local skip = require('skip')
local num = require('num')
local sym = require('sym')
local goal = require('goal')
local sample = require('sample')
local klass = require('klass')
local settings = require('settings')

-- load auto93
local auto93Sample = sample:new()
auto93Sample:load('../../data/auto93.csv')

-- task 1: clustering 
auto93Sample:fft(10)
--auto93Sample:discretize()
--auto93Sample:dendogram()

--[[
local leafs = auto93Sample:divide()
for i = 1, #leafs do
    --print(auto93Sample:goalString(leafs[i][2]))
    --print(table.unpack(leafs[i][1]:mid()))
end
]]
for k,_ in pairs(_ENV) do if not b4[k] then print("?? ".. k) end end