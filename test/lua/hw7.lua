local b4 = {}; for k,_ in pairs(_ENV) do b4[k] = k end

package.path = '../../src/lua/?.lua;' .. package.path

local sample = require('sample')
local settings = require('settings')

-- load auto93
local auto93Sample = sample:new()
auto93Sample:load('../../data/auto93.csv')

auto93Sample.settings = settings:random()
local fft_leaves = auto93Sample:fft(10)

--print(auto93Sample:goalString(fft_leaves[1]))

for key, value in pairs(fft_leaves) do
  print(auto93Sample:goalString(value))
end

local best = {}

for i = 1, 1000 do
  auto93Sample.settings = settings:random()
  --print(settings:print_out(auto93Sample.settings))
  local fft_leaves = auto93Sample:fft(100)
  table.insert(best, {fft_leaves[1], settings:print_out(auto93Sample.settings)} )
  --print(auto93Sample:goalString(fft_leaves[1][1]) .. ' ' .. fft_leaves[1][2])
end
print()

--table.sort(best, function(x, y) return auto93Sample:zitler(x[1][1], y[1][1]) end)
--print(auto93Sample:goalString(best[1][1][1]) .. ' ' .. best[1][1][2])
--print(best[1][2])




for k,_ in pairs(_ENV) do if not b4[k] then print("?? ".. k) end end