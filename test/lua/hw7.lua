local b4 = {}; for k,_ in pairs(_ENV) do b4[k] = k end

package.path = '../../src/lua/?.lua;' .. package.path

local sample = require('sample')
local settings = require('settings')


-- load auto93
local auto93Sample = sample:new()
auto93Sample:load('../../data/auto93.csv')

auto93Sample.settings = settings:random()
local fft_leaves = auto93Sample:fft(100)

--print(auto93Sample:goalString(fft_leaves[1][1]))

for key, value in pairs(fft_leaves) do
  --print(auto93Sample:goalString(value[1]))
end
local runtime = os.clock();
local best = {}

local csv_lines = {}

local num_runs = {1000}

for _, run_n in pairs(num_runs) do
  for i = 1, run_n do
    auto93Sample.settings = settings:random()
    --print(settings:print_out(auto93Sample.settings))
    local fft_leaves = auto93Sample:fft(100)
    local csv_line = settings:print_out(auto93Sample.settings)
    csv_line = csv_line .. ',' .. auto93Sample:goalCSV(fft_leaves[1][1]) .. ',' .. tostring(fft_leaves[1][2])
    --table.insert(best, {fft_leaves[1], settings:print_out(auto93Sample.settings)} )
    --print(auto93Sample:goalString(fft_leaves[1][1]) .. ' ' .. fft_leaves[1][2])
    table.insert(csv_lines, csv_line)
  end
  --print()

  --table.sort(best, function(x, y) return auto93Sample:zitler(x[1][1], y[1][1]) end)
  --print(auto93Sample:goalString(best[1][1][1]) .. ' ' .. best[1][1][2])
  --print(best[1][2])

  local file = io.open(tostring(run_n) .. '.csv', "w")

  local header = settings:print_out_names(auto93Sample.settings) .. ','
  header = header .. auto93Sample:headerCSV() .. ','
  header = header .. 'N+'

  file:write(header .. '\n')

  for key, value in pairs(csv_lines) do
    file:write(value)
    file:write('\n')
  end

  file:close()
 
  local optimized = sample:new()
  optimized:load(tostring(run_n) .. '.csv')

  local optimized_leaves = optimized:fft(100)

  print(table.unpack(optimized_leaves[1][1]))
  print()
  local endtime = os.clock()
  local deltaaa = endtime - runtime 
  print("Time: " .. deltaaa)
  --print(optimized_leaves[1][2])
end


--local optimized = sample:new()
--optimized:load('1000.csv')

--local optimized_leaves = optimized:fft(100)

--print(table.unpack(optimized_leaves[1][1]))
--print(optimized_leaves[1][2])


--local auto93Sample = sample:new()
--auto93Sample:load('../../data/auto93.csv')

--auto93Sample.settings = settings:random()
--local fft_leaves = auto93Sample:fft(10)


for k,_ in pairs(_ENV) do if not b4[k] then print("?? ".. k) end end