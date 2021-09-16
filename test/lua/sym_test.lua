local b4 = {}; for k,_ in pairs(_ENV) do b4[k] = k end

package.path = '../../src/lua/?.lua;' .. package.path

local sym = require('sym')

local sampleSym = sym:new('sampleSym')

assert(sampleSym.name == 'sampleSym')
assert(sampleSym.count == 0)
assert(sampleSym.mode == nil)
assert(sampleSym.mode_frequency == 0)
assert(#sampleSym.symbol_list == 0)
assert(sampleSym.symbol_list['hello'] == nil)

-- test add
sampleSym:add('hello')
assert(sampleSym.count == 1)
assert(sampleSym.mode == 'hello')
assert(sampleSym.mode_frequency == 1)
assert(sampleSym.symbol_list['hello'] == 1)

-- make sure numbers change right
sampleSym:add('world')
assert(sampleSym.count == 2)
assert(sampleSym.mode == 'hello')
assert(sampleSym.mode_frequency == 1)
assert(sampleSym.symbol_list['hello'] == 1)
assert(sampleSym.symbol_list['world'] == 1)

-- get a new mode, check numbers
sampleSym:add('world')
assert(sampleSym.count == 3)
assert(sampleSym.mode == 'world')
assert(sampleSym.mode_frequency == 2)
assert(sampleSym.symbol_list['hello'] == 1)
assert(sampleSym.symbol_list['world'] == 2)

-- unkown value, do not add, make sure numbers didnt change
sampleSym:add('?')
assert(sampleSym.count == 3)
assert(sampleSym.mode == 'world')
assert(sampleSym.mode_frequency == 2)
assert(sampleSym.symbol_list['hello'] == 1)
assert(sampleSym.symbol_list['world'] == 2)

-- test clone
local cloneSym = sampleSym:clone()
assert(cloneSym ~= sampleSym)
assert(cloneSym.count == 3)
assert(cloneSym.mode == 'world')
assert(cloneSym.mode_frequency == 2)
assert(cloneSym.symbol_list['hello'] == 1)
assert(cloneSym.symbol_list['world'] == 2)

-- test changes in cloned item vs original item
cloneSym:add('!')
cloneSym:add('hello')
cloneSym:add('hello')
assert(cloneSym.count == 6)
assert(cloneSym.mode == 'hello')
assert(cloneSym.mode_frequency == 3)
assert(cloneSym.symbol_list['hello'] == 3)
assert(cloneSym.symbol_list['world'] == 2)
assert(cloneSym.symbol_list['!'] == 1)

assert(sampleSym.count == 3)
assert(sampleSym.mode == 'world')
assert(sampleSym.mode_frequency == 2)
assert(sampleSym.symbol_list['hello'] == 1)
assert(sampleSym.symbol_list['world'] == 2)
assert(sampleSym.symbol_list['!'] == nil)


for k,_ in pairs(_ENV) do if not b4[k] then print("?? ".. k) end end