local b4 = {}; for k,_ in pairs(_ENV) do b4[k] = k end

package.path = '../../src/lua/?.lua;' .. package.path

local skip = require('skip')

local sampleSkip = skip:new('sampleSkip')

assert(sampleSkip.name == 'sampleSkip')
assert(sampleSkip.count == 0)

-- test add
sampleSkip:add('hello')
assert(sampleSkip.count == 1)

-- make sure numbers change right
sampleSkip:add('world')
assert(sampleSkip.count == 2)

-- unkown value, do not include in count
sampleSkip:add('?')
assert(sampleSkip.count == 2)

-- test clone
local cloneSkip = sampleSkip:clone()
assert(cloneSkip ~= sampleSkip)
assert(cloneSkip.count == 2)

-- test changes in cloned item vs original item
cloneSkip:add('!')
assert(cloneSkip.count == 3)

assert(sampleSkip.count == 2)

for k,_ in pairs(_ENV) do if not b4[k] then print("?? ".. k) end end