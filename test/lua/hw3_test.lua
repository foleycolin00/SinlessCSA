package.path = '../../src/lua/?.lua;' .. package.path

tools = require('tools')
skip = require('skip')
num = require('num')
sym = require('sym')
goal = require('goal')
Sample = require('Sample')

samplobj = Sample:new()
samplobj:load('../../data/weather.csv')