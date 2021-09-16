local b4 = {}; for k,_ in pairs(_ENV) do b4[k] = k end

package.path = '../../src/lua/?.lua;' .. package.path

-- running stdev not tested, is an approximation

local num = require('num')

local numSample = num:new('numSample')
            
assert(numSample.name == 'numSample')
assert(numSample.count == 0)
assert(numSample.min == nil)
assert(numSample.max == nil)
assert(numSample.mean == 0)
assert(numSample.stdev == 0)
assert(numSample.m2 == 0)
assert(numSample.sample_list ~= nil)


-- test add
numSample:add(1)
assert(numSample.count == 1)
assert(numSample.min == 1)
assert(numSample.max == 1)
assert(numSample.mean == 1)
--assert(numSample.stdev == 0)
--assert(numSample.m2 == 0)

-- make sure numbers change right
numSample:add(2)
numSample:add(3)
numSample:add(4)
numSample:add(5)
numSample:add(4)
assert(numSample.count == 6)
assert(numSample.min == 1)
assert(numSample.max == 5)
assert(numSample.mean > 3.16 and numSample.mean < 3.17)
--assert(numSample.stdev > 1.34 and numSample.stdev < 1.35)
--assert(numSample.m2 == 0)

-- try unknown ?
numSample:add('?')
assert(numSample.count == 6)
assert(numSample.min == 1)
assert(numSample.max == 5)
assert(numSample.mean > 3.16 and numSample.mean < 3.17)
--assert(numSample.stdev > 1.34 and numSample.stdev < 1.35)
--assert(numSample.m2 == 0)

numSample:add('a')
assert(numSample.count == 6)
assert(numSample.min == 1)
assert(numSample.max == 5)
assert(numSample.mean > 3.16 and numSample.mean < 3.17)
--assert(numSample.stdev > 1.34 and numSample.stdev < 1.35)
--assert(numSample.m2 == 0)

-- test clone
local numClone = numSample:clone()
assert(numClone.count == 6)
assert(numClone.min == 1)
assert(numClone.max == 5)
assert(numClone.mean > 3.16 and numClone.mean < 3.17)
--assert(numClone.stdev > 1.34 and numClone.stdev < 1.35)
--assert(numClone.m2 == 0)

numClone:add(30)
assert(numClone.count == 7)
assert(numClone.min == 1)
assert(numClone.max == 30)
assert(numClone.mean == 7)
--assert(numSample.stdev > 9.47 and numSample.stdev < 9.48)
--assert(numClone.m2 == 0)

assert(numSample.count == 6)
assert(numSample.min == 1)
assert(numSample.max == 5)
assert(numSample.mean > 3.16 and numSample.mean < 3.17)
--assert(numSample.stdev > 1.34 and numSample.stdev < 1.35)
--assert(numSample.m2 == 0)

-- test norm
assert(numSample:norm(3) == 0.5)
assert(numClone:norm(3) > 0.06896551 and numClone:norm(3) < 0.06896552)

for k,_ in pairs(_ENV) do if not b4[k] then print("?? ".. k) end end