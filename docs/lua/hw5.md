# Homework 5: Discretization

In this homework assignment, we attempt to discretize data. 

## Task 1: Clustering 
```
../ n = 398, c = 0.73
../../ n = 199, c = 0.51
../../../ n = 100, c = 0.51
../../../../ n = 50, c = 0.29
../../../../../ n = 25, c = 0.19
../../../../../../ n = 13    goals = [ 3301.5 17.3 20.0 ]
../../../../../../ n = 12    goals = [ 3044.3 15.8 24.2 ]
../../../../../ n = 25, c = 0.26
../../../../../../ n = 13    goals = [ 3742.2 14.4 20.8 ]
../../../../../../ n = 12    goals = [ 3461.8 17.1 20.0 ]
../../../../ n = 50, c = 0.29
../../../../../ n = 25, c = 0.28
../../../../../../ n = 13    goals = [ 2261.2 17.2 23.8 ]
../../../../../../ n = 12    goals = [ 2737.2 16.1 22.5 ]
../../../../../ n = 25, c = 0.12
../../../../../../ n = 13    goals = [ 3265.8 17.0 20.0 ]
../../../../../../ n = 12    goals = [ 3393.2 17.6 20.0 ]
../../../ n = 99, c = 0.40
../../../../ n = 50, c = 0.32
../../../../../ n = 25, c = 0.18
../../../../../../ n = 13    goals = [ 4417.3 12.9 16.2 ]
../../../../../../ n = 12    goals = [ 4144.6 13.6 15.8 ]
../../../../../ n = 25, c = 0.20
../../../../../../ n = 13    goals = [ 4470.7 12.1 10.0 ]
../../../../../../ n = 12    goals = [ 4377.7 10.3 12.5 ]
../../../../ n = 49, c = 0.29
../../../../../ n = 25, c = 0.15
../../../../../../ n = 13    goals = [ 4047.7 12.9 14.6 ]
../../../../../../ n = 12    goals = [ 3953.7 12.3 14.2 ]
../../../../../ n = 24, c = 0.30
../../../../../../ n = 12    goals = [ 3018.1 15.0 20.0 ]
../../../../../../ n = 12    goals = [ 3870.6 13.6 14.2 ]
../../ n = 199, c = 0.56
../../../ n = 100, c = 0.52
../../../../ n = 50, c = 0.54
../../../../../ n = 25, c = 0.17
../../../../../../ n = 13    goals = [ 2680.4 15.9 25.4 ]
../../../../../../ n = 12    goals = [ 2269.2 15.4 28.3 ]
../../../../../ n = 25, c = 0.54
../../../../../../ n = 13    goals = [ 2403.2 17.5 33.8 ]
../../../../../../ n = 12    goals = [ 2540.4 17.6 34.2 ]
../../../../ n = 50, c = 0.20
../../../../../ n = 25, c = 0.16
../../../../../../ n = 13    goals = [ 2250.8 16.6 30.0 ]
../../../../../../ n = 12    goals = [ 2481.2 16.0 29.2 ]
../../../../../ n = 25, c = 0.09
../../../../../../ n = 13    goals = [ 2634.1 15.5 30.0 ]
../../../../../../ n = 12    goals = [ 2410.8 17.1 31.7 ]
../../../ n = 99, c = 0.57
../../../../ n = 50, c = 0.48
../../../../../ n = 25, c = 0.16
../../../../../../ n = 13    goals = [ 2100.4 17.5 26.9 ]
../../../../../../ n = 12    goals = [ 2493.7 16.0 25.0 ]
../../../../../ n = 25, c = 0.19
../../../../../../ n = 13    goals = [ 2165.5 15.7 26.2 ]
../../../../../../ n = 12    goals = [ 2236.7 16.8 25.8 ]
../../../../ n = 49, c = 0.23
../../../../../ n = 25, c = 0.24
../../../../../../ n = 13    goals = [ 1965.2 17.0 40.0 ]
../../../../../../ n = 12    goals = [ 2417.1 15.7 29.2 ]
../../../../../ n = 24, c = 0.17
../../../../../../ n = 12    goals = [ 2119.3 17.1 30.8 ]
../../../../../../ n = 12    goals = [ 2368.3 15.3 27.5 ]
```
## Task 2: Sorting the Leaves
```
[ 1974.4 17.3 39.2 ]
[ 2626.2 19.4 33.3 ]
[ 2350.0 16.8 32.5 ]
[ 2162.7 16.8 30.0 ]
[ 2166.9 17.8 27.5 ]
[ 2291.7 16.2 32.3 ]
[ 2250.8 16.6 30.0 ]
[ 2100.2 16.1 29.2 ]
[ 2211.7 16.9 26.9 ]
[ 2297.7 17.3 24.6 ]
[ 2438.3 15.1 30.8 ]
[ 2158.7 15.8 25.8 ]
[ 2391.4 15.2 29.2 ]
[ 2644.1 16.2 29.2 ]
[ 2531.2 15.5 29.2 ]
[ 2469.2 15.8 26.9 ]
[ 3005.8 17.1 20.8 ]
[ 2784.8 15.3 21.7 ]
[ 3237.6 17.4 21.7 ]
[ 2811.2 15.3 20.8 ]
[ 3146.2 15.6 22.3 ]
[ 3382.3 17.6 20.0 ]
[ 3165.5 16.0 20.0 ]
[ 3437.0 17.2 20.0 ]
[ 3716.2 14.4 20.8 ]
[ 4025.7 13.9 16.2 ]
[ 3834.5 12.4 15.4 ]
[ 4210.5 12.8 18.5 ]
[ 4135.8 13.3 12.5 ]
[ 4314.1 12.5 10.0 ]
[ 4468.8 12.3 12.3 ]
[ 4330.2 10.5 12.5 ]
```


## Task 3: Discretization
```
best
4 91 68 2025 18.2 82 3 40
4 91 67 1965 15.7 82 3 30
4 91 67 1995 16.2 82 3 40
4 91 67 1850 13.8 80 3 40
4 91 67 1965 15 82 3 40
4 86 65 2019 16.4 80 3 40
4 86 65 2110 17.9 80 3 50
4 85 65 2110 19.2 80 3 40
4 85 65 1975 19.4 81 3 40
4 89 62 2050 17.3 81 3 40
4 89 60 1968 18.8 80 3 40
4 81 60 1760 16.1 81 3 40
4 79 58 1755 16.9 81 3 40
worst
8 455 225 3086 10 70 1 10
8 455 225 4425 10 70 1 10
8 454 220 4354 9 70 1 10
8 440 215 4312 8.5 70 1 10
8 429 198 4341 10 70 1 20
8 455 225 4951 11 73 1 10
8 360 215 4615 14 70 1 10
8 429 208 4633 11 72 1 10
8 440 215 4735 11 73 1 10
8 390 190 3850 8.5 70 1 20
8 400 230 4278 9.5 73 1 20
8 429 198 4952 11.5 73 1 10
```

and 

```
1 Cylinders low = 4 hi = 8 best = 13 rest = 12
2 Displacement low = 360 hi = 455 best = 0 rest = 12
2 Displacement low = 79 hi = 91 best = 13 rest = 0
3 Horsepower low = 190 hi = 230 best = 0 rest = 12
3 Horsepower low = 58 hi = 68 best = 13 rest = 0
6 Model low = 70 hi = 82 best = 13 rest = 12
7 :name origin :lo 3 :hi 3 :best 13 :rest nil
7 :name origin :lo 1 :hi 1 :best nil :rest 12
```

The code for this assignment can be found at [test/lua/hw5.lua](https://github.com/foleycolin00/SinlessCSA/blob/hw5-lua/test/lua/hw5.lua), [src/lua/sample.lua](https://github.com/foleycolin00/SinlessCSA/blob/hw5-lua/src/lua/sample.lua), [src/lua/num.lua](https://github.com/foleycolin00/SinlessCSA/blob/hw5-lua/src/lua/num.lua), and [src/lua/sym.lua](https://github.com/foleycolin00/SinlessCSA/blob/hw5-lua/src/lua/sym.lua).

## Code: 

### sample.lua 
````lua
function sample:discretize()
  local ret = {}
  self.bins = {}
  
  local leafs = self:divide()
  
  local best, worst = leafs[1][1], leafs[#leafs][1]
  
  --[[
  print('best')
 
  for key, value in pairs(best.rows) do
    print(table.concat(value, ' '))
  end
  print('worst')
  for key, value in pairs(worst.rows) do
    print(table.concat(value, ' '))
  end
  print()
  ]]
  
  for i = 1, #best.headers do
    if getmetatable(best.headers[i]) == num or getmetatable(best.headers[i]) == sym then
      for discretized_item in best.headers[i]:discretize(worst.headers[i]) do
        discretized_item.col_index = i
        --discretized_item:print_out()
        table.insert(self.bins, discretized_item)
      end
      --print()
    end
  end
  --print()
end
````

### num.lua 
````lua
function num:discretize(other_num)
  -- i = good sample (for us it is self)
  -- j = bad sample (for us it it other_num)
  
  -- go through some (which is a sample of num)
  -- so for the good one it would be every item in some's sample list
  -- and attach 1 to it, { { self.some[1], 1 }, { self.some[2], 1 }, ... }
  -- do the same for the bad sample (other_num), but attach 0 to it
  -- { { other_num.some[1], 0 }, { other_num.some[2], 0 }, ... }
  local sample_list_collection = {}

  -- every key should be given a zero
  for key, value in pairs(other_num.sample_list.sample_list) do
    table.insert(sample_list_collection, { value, 0 })
  end

  -- every key should be given a one
  for key, value in pairs(self.sample_list.sample_list) do
    table.insert(sample_list_collection, { value, 1 })
  end

  -- find minimum break space (.3 * expected value of standard deviation)
  local n1 = #self.sample_list.sample_list
  local n2 = #other_num.sample_list.sample_list

  local iota = self.settings.cohen * ( (self.stdev * n1 + other_num.stdev * n2) / (n1 + n2) )
  --print("Iota")
  --print(iota)
  --print()

  local ranges = self:merge(self:unsuper(sample_list_collection, (#sample_list_collection)^self.settings.bins, iota))

  --[[
  for i = 1, #ranges do
    for j = 1, #ranges[i] do
      io.write(table.concat(ranges[i][j], ' '), ', ')
    end
    print('\n')
  end
  print()
  ]]
  
 local curr_index = 0

  return function()
    curr_index = curr_index + 1
    
    if curr_index <= #ranges then
      local lo
      if curr_index > 1 then
        lo = ranges[curr_index - 1][#ranges[curr_index - 1]][1]
      else
        lo = ranges[curr_index][1][1]
      end
      
      local hi = ranges[curr_index][#ranges[curr_index]][1]
      
      local counts = {0, 0}
        
      for key, value in pairs(ranges[curr_index]) do       
        
        local best_or_worst = value[2] + 1
        
        counts[best_or_worst] = counts[best_or_worst] + 1
      end
      
      return bin:new(-1, self.name, lo, hi, counts[2], n1, counts[1], n2,  curr_index == 1, curr_index == #ranges)
    end
  end
end

--- This function calculates the variance in a range 
-- @function variance 
-- @param range a discretized range 
-- @return information about the variance in the range (best/rest)
function num:variance(range)
  local counts = {0, 0}

  for key, value in pairs(range) do
    local best_or_worst = value[2] + 1
    counts[best_or_worst] = counts[best_or_worst] + 1
  end
  
  if counts[1] == 0 or counts[2] == 0 then
    return 0
  end
  
  local p1 = counts[1] / #range
  local p2 = 1 - p1
  
  local w1 = math.log(p1, 2)
  local w2 = math.log(p2, 2)
  return -(p1 * w1 + p2 * w2)
end

--- This function divides the sample into a set of ranges
-- @function unsuper 
-- @param sample_list_collection a subsample with best/rest col
-- @param binsize max of binsize
-- @param iota minimum break span 
-- @return split the sample split into seperate "bins" (not the object 'bin')
function num:unsuper(sample_list_collection, binsize, iota)
  if binsize < 1 then
    print('error!! bin too small')
  end
  
  --[[
  print("here first")
  for i = 1, #sample_list_collection do
    io.write(sample_list_collection[i][1] .. ' ' .. sample_list_collection[i][2] .. ', ')
  end
  print()
  ]]
  
  -- sort it by value so max min collecting works
  table.sort(sample_list_collection, function(x, y) return x[1] < y[1] end)
  
  --[[
  print("here second")
  for i = 1, #sample_list_collection do
    io.write(sample_list_collection[i][1] .. ' ' .. sample_list_collection[i][2] .. ', ')
  end
  print()
  ]]
  
  local split = {}

  local i = 1
  local j = 2
  
  -- while j is not off the end of the list
  while (j <= #sample_list_collection + 1) do
    
    -- If j is at the end, do the break (bin the remaining items)
    if j > #sample_list_collection or
    
       -- It cannot break ranges unless the current lowest i value is different then
       -- the last value being checked at j
       -- unneeded, will fail the next chekck if they are the same
       --((sample_list_collection[j - 1][1] ~= sample_list_collection[j][1]) and
       
       -- It cannot break unless the value range of the items are more different ( max - min > 0.3 * sd)
       -- max = where j is (the next item to not include in this break)
       -- min = where i is (the lowest item in the sorted list
       (sample_list_collection[j][1] - sample_list_collection[i][1] > iota and
       -- It cannot break unless there are enough items (sqrt(N)) after the break (so we can break some more, later)
       j - i > binsize and
       -- there are bin size or more items left in the list
       (#sample_list_collection - j  > binsize)) then
       
      table.insert(split, {table.unpack(sample_list_collection, i, j - 1)})

      i = j
    end
    
    j = j + 1
  end
  
  --[[
  print()
  for i = 1, #split do
    for j = 1, #split[i] do
      io.write(table.concat(split[i][j], ' '), ', ')
    end
    print()
  end
  print()
  ]]
  

  return split
end

--- This function goes through the ranges that were made in unsuper and merges bins that are "uneven."
-- @function merge
-- @param ranges ranges made in unsuper 
-- @return ranges ranges 
function num:merge(ranges)
  local i = 1
  
  while i < #ranges do 
    local a = ranges[i]
    local b = ranges[i + 1]
    local c = {}
    table.move(a, 1, #a, 1, c)
    table.move(b, 1, #b, #c + 1, c)

    if (self:variance(c) * 0.95) <= (self:variance(a) * #a + self:variance(b) * #b) / (#a + #b) then
      ranges[i + 1] = c
      table.remove(ranges, i)
    else
      i = i + 1 
    end 
  end
 
  return ranges
end
````

### sym.lua 
````lua
function sym:discretize(other_sym)
  ---
  local symbol_list_collection = {}
  
  local n1 = 0
  for key, value in pairs(self.symbol_list) do
    symbol_list_collection[key] = 1
    n1 = n1 + self.symbol_list[key]
  end
  
  local n2 = 0
  for key, value in pairs(other_sym.symbol_list) do
    symbol_list_collection[key] = 1
    n2 = n2 + other_sym.symbol_list[key]
  end
  
  local sym_col = {}
  
  for key, value in pairs(symbol_list_collection) do
    table.insert(sym_col, key)
  end
  
  local curr_index = 1
  
  return function()
    if curr_index <= #sym_col then
      local item = sym_col[curr_index]
      
      curr_index = curr_index + 1
      return bin:new(-1, self.name, item, item, self.symbol_list[item] or 0, n1, other_sym.symbol_list[item] or 0, n2)
    end
  end
end
````

