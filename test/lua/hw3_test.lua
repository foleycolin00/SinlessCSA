package.path = '../../src/lua/?.lua;' .. package.path

tools = require('tools')
skip = require('skip')
num = require('num')
sym = require('sym')
goal = require('goal')
Sample = require('sample')

samplobj = Sample.new()
sample.load('../../data/weather.csv')
