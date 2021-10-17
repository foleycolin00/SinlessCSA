# Homework 6: Build a FFT forest 

## Output: 
```
1
 1      if Model > 73           [ 3035.0 20.5 20.0 ] (273)
 1   elseif Cylinders <= 4              [ 2123.0 14.0 30.0 ] (47)
 1   elseif Cylinders <= 6              [ 3121.0 16.5 20.0 ] (20)
 1   elseif Horsepower <= 153           [ 4294.0 16.0 10.0 ] (23)
 1   elseif Model <= 70         [ 4341.0 10.0 20.0 ] (13)
 1   elseif Cylinders <= 8              [ 4499.0 12.5 10.0 ] (22)
 0   else (0)

2
 1      if Model > 73           [ 3035.0 20.5 20.0 ] (273)
 1   elseif Cylinders <= 4              [ 2123.0 14.0 30.0 ] (47)
 1   elseif Cylinders <= 6              [ 3121.0 16.5 20.0 ] (20)
 1   elseif Horsepower <= 153           [ 4294.0 16.0 10.0 ] (23)
 1   elseif Model <= 70         [ 4341.0 10.0 20.0 ] (13)
 0   elseif Cylinders <= 8              [ 4499.0 12.5 10.0 ] (22)
 1   else (0)

3
 1      if Model > 73           [ 3035.0 20.5 20.0 ] (273)
 1   elseif Cylinders <= 4              [ 2123.0 14.0 30.0 ] (47)
 1   elseif Cylinders <= 6              [ 3121.0 16.5 20.0 ] (20)
 1   elseif Horsepower <= 153           [ 4294.0 16.0 10.0 ] (23)
 0   elseif Model > 70          [ 4499.0 12.5 10.0 ] (22)
 1   else [ 4341.0 10.0 20.0 ] (13)

4
 1      if Model > 73           [ 3035.0 20.5 20.0 ] (273)
 1   elseif Cylinders <= 4              [ 2123.0 14.0 30.0 ] (47)
 1   elseif Cylinders <= 6              [ 3121.0 16.5 20.0 ] (20)
 0   elseif Horsepower > 153            [ 4274.0 12.0 10.0 ] (35)
 1   elseif Cylinders <= 8              [ 4294.0 16.0 10.0 ] (23)
 0   else (0)

5
 1      if Model > 73           [ 3035.0 20.5 20.0 ] (273)
 1   elseif Cylinders <= 4              [ 2123.0 14.0 30.0 ] (47)
 1   elseif Cylinders <= 6              [ 3121.0 16.5 20.0 ] (20)
 0   elseif Horsepower > 153            [ 4274.0 12.0 10.0 ] (35)
 0   elseif Cylinders <= 8              [ 4294.0 16.0 10.0 ] (23)
 1   else (0)

6
 1      if Model > 73           [ 3035.0 20.5 20.0 ] (273)
 1   elseif Cylinders <= 4              [ 2123.0 14.0 30.0 ] (47)
 0   elseif Displacement > 258          [ 4129.0 13.0 10.0 ] (58)
 1   elseif Displacement <= 200         [ 2472.0 14.0 20.0 ] (7)
 0   else [ 3288.0 15.5 20.0 ] (13)

7
 1      if Model > 73           [ 3035.0 20.5 20.0 ] (273)
 1   elseif Cylinders <= 4              [ 2123.0 14.0 30.0 ] (47)
 0   elseif Displacement > 258          [ 4129.0 13.0 10.0 ] (58)
 0   elseif Model > 70          [ 2807.0 13.5 20.0 ] (16)
 1   else [ 2774.0 15.5 20.0 ] (4)

8
 1      if Model > 73           [ 3035.0 20.5 20.0 ] (273)
 0   elseif origin == 1         [ 3761.0 9.5 20.0 ] (89)
 1   elseif Model <= 71         [ 2065.0 14.5 30.0 ] (15)
 1   elseif origin == 2         [ 2979.0 19.5 20.0 ] (12)
 0   else [ 2278.0 15.5 20.0 ] (9)

9
 1      if Model > 73           [ 3035.0 20.5 20.0 ] (273)
 0   elseif origin == 1         [ 3761.0 9.5 20.0 ] (89)
 1   elseif Model <= 71         [ 2065.0 14.5 30.0 ] (15)
 0   elseif Horsepower > 75             [ 2124.0 13.5 20.0 ] (16)
 1   else [ 2254.0 23.5 20.0 ] (5)

10
 1      if Model > 73           [ 3035.0 20.5 20.0 ] (273)
 0   elseif origin == 1         [ 3761.0 9.5 20.0 ] (89)
 0   elseif Model > 71          [ 2158.0 15.5 20.0 ] (21)
 1   else [ 2065.0 14.5 30.0 ] (15)

11
 0      if origin == 1          [ 3651.0 17.7 20.0 ] (249)
 1   elseif Horsepower <= 77            [ 2254.0 23.5 20.0 ] (83)
 1   elseif Horsepower <= 92            [ 2130.0 14.5 30.0 ] (27)
 1   elseif Cylinders <= 4              [ 2489.0 15.0 20.0 ] (29)
 0   else [ 2807.0 13.5 20.0 ] (10)

12
 0      if origin == 1          [ 3651.0 17.7 20.0 ] (249)
 1   elseif Horsepower <= 77            [ 2254.0 23.5 20.0 ] (83)
 1   elseif Horsepower <= 92            [ 2130.0 14.5 30.0 ] (27)
 0   elseif Displacement > 108          [ 2795.0 15.7 20.0 ] (33)
 1   else [ 2330.0 13.5 20.0 ] (6)

13
 0      if origin == 1          [ 3651.0 17.7 20.0 ] (249)
 1   elseif Horsepower <= 77            [ 2254.0 23.5 20.0 ] (83)
 0   elseif Horsepower > 92             [ 2330.0 13.5 20.0 ] (39)
 1   elseif origin == 3         [ 2130.0 14.5 30.0 ] (9)
 1   elseif Model > 74          [ 2202.0 15.3 30.0 ] (10)
 0   else [ 2300.0 14.5 30.0 ] (8)

14
 0      if origin == 1          [ 3651.0 17.7 20.0 ] (249)
 1   elseif Horsepower <= 77            [ 2254.0 23.5 20.0 ] (83)
 0   elseif Horsepower > 92             [ 2330.0 13.5 20.0 ] (39)
 1   elseif origin == 3         [ 2130.0 14.5 30.0 ] (9)
 0   elseif Horsepower > 78             [ 2123.0 14.0 30.0 ] (14)
 1   else [ 2190.0 14.1 30.0 ] (4)

15
 0      if origin == 1          [ 3651.0 17.7 20.0 ] (249)
 1   elseif Horsepower <= 77            [ 2254.0 23.5 20.0 ] (83)
 0   elseif Horsepower > 92             [ 2330.0 13.5 20.0 ] (39)
 0   elseif origin == 2         [ 2123.0 14.0 30.0 ] (18)
 1   else [ 2130.0 14.5 30.0 ] (9)

16
 0      if origin == 1          [ 3651.0 17.7 20.0 ] (249)
 0   elseif Horsepower > 77             [ 2671.0 13.5 30.0 ] (68)
 1   elseif Horsepower <= 62            [ 2050.0 17.3 40.0 ] (21)
 1   elseif origin == 3         [ 2145.0 18.0 30.0 ] (36)
 1   elseif Horsepower <= 74            [ 1963.0 15.5 30.0 ] (16)
 0   else [ 3530.0 20.1 30.0 ] (8)

17
 0      if origin == 1          [ 3651.0 17.7 20.0 ] (249)
 0   elseif Horsepower > 77             [ 2671.0 13.5 30.0 ] (68)
 1   elseif Horsepower <= 62            [ 2050.0 17.3 40.0 ] (21)
 1   elseif origin == 3         [ 2145.0 18.0 30.0 ] (36)
 0   elseif Horsepower > 74             [ 3530.0 20.1 30.0 ] (8)
 1   else [ 1963.0 15.5 30.0 ] (16)

18
 0      if origin == 1          [ 3651.0 17.7 20.0 ] (249)
 0   elseif Horsepower > 77             [ 2671.0 13.5 30.0 ] (68)
 1   elseif Horsepower <= 62            [ 2050.0 17.3 40.0 ] (21)
 0   elseif origin == 2         [ 1937.0 14.2 30.0 ] (24)
 1   elseif Horsepower <= 68            [ 2020.0 19.2 30.0 ] (21)
 0   else [ 2155.0 16.4 30.0 ] (15)

19
 0      if origin == 1          [ 3651.0 17.7 20.0 ] (249)
 0   elseif Horsepower > 77             [ 2671.0 13.5 30.0 ] (68)
 1   elseif Horsepower <= 62            [ 2050.0 17.3 40.0 ] (21)
 0   elseif origin == 2         [ 1937.0 14.2 30.0 ] (24)
 0   elseif Model > 74          [ 1990.0 17.0 30.0 ] (32)
 1   else [ 1773.0 19.0 30.0 ] (4)

20
 0      if origin == 1          [ 3651.0 17.7 20.0 ] (249)
 0   elseif Horsepower > 77             [ 2671.0 13.5 30.0 ] (68)
 0   elseif Horsepower > 62             [ 1985.0 16.0 30.0 ] (60)
 1   elseif origin == 2         [ 1835.0 20.5 30.0 ] (11)
 0   else [ 1985.0 19.4 30.0 ] (10)

21
 0      if origin == 1          [ 3651.0 17.7 20.0 ] (249)
 0   elseif Horsepower > 77             [ 2671.0 13.5 30.0 ] (68)
 0   elseif Horsepower > 62             [ 1985.0 16.0 30.0 ] (60)
 0   elseif origin == 3         [ 1985.0 19.4 30.0 ] (10)
 1   else [ 1835.0 20.5 30.0 ] (11)
 ```

 ## Code: 
 ### bin.lua
 ```
 local b4 = {}; for k,_ in pairs(_ENV) do b4[k] = k end

local bin = {}

bin.__index = bin

--- This function creates a new sym object.
-- @function new
-- @param col_name the column name
-- @return a new sym object
function bin:new(index, name, lo, hi, _best, _bests, _rest, _rests, _first, _last)
    local o = { col_index = index,
                col_name = name,
                low = lo,
                high = hi,
                best = _best,
                bests = _bests,
                rest = _rest,
                rests = _rests,
                first = _first or false,
                last = _last or false}
    setmetatable(o, self)
    
    return o
end

function bin:print_out()
  print(self.col_index .. ' ' .. self.col_name ..
        ' low = ' .. self.low .. ' hi = ' .. self.high ..
        ' best = ' .. self.best .. ' bests = ' .. self.bests ..
        ' rest = ' .. self.rest .. ' rests = ' .. self.rests ..
        ' first = ' .. tostring(self.first) .. ' last = ' .. tostring(self.last))
end

for k,_ in pairs(_ENV) do if not b4[k] then print("?? ".. k) end end

return bin
```
 ### sample.lua 
```
function sample:fft(max_choices)
  local stop = stop or 2 * (#self.rows)^self.settings.bins --0.5 should be bins hyperparameter
  
  local tree = {}
  
  self:fft_recurse(tree, {}, stop)
  
  -- pretty print the tree

  for key, value in pairs(tree) do
    if #value <= max_choices then
      print(key)
      for k, v in pairs(value) do
        -- print the 0/1
        io.write(' ' .. v[1], '   ')
        
        -- print if/elseif/else depending on key position
        if k == 1 then
          io.write("   if ")
        elseif k == #value then
          io.write("else ")
        else
          io.write("elseif ")
        end
        
        if k ~= #value then
          -- if it is a 1, then use bestIdea to index
          -- else use the worstIdea to index
          if v[1] == 1 then
            io.write(self:show(v[2]), '\t\t')
          else
            io.write(self:show(v[2]), '\t\t')
          end
        end
        
        table.sort(v[3], function (a, b) return self:zitler(a, b) end)
        
        
        if #v[3] > 0 then
          io.write(self:goalString(v[3][(#v[3] // 2) + 1]), ' ')
        end
        
        io.write('(' .. #v[3] .. ')', '\n')
        
      end
      print()
      end
  end
  
  
  local leaves = {}
  -- build the leaves from the tree
  for key, value in pairs(tree) do
    for k, v in pairs(value) do
      table.sort(v[3], function (a, b) return self:zitler(a, b) end)
      if #v[3] > 0 then
        table.insert(leaves, { v[3][(#v[3] // 2) + 1], #v[3] })
      end
    end
  end
  
  table.sort(leaves, function (a, b) return self:zitler(a[1], b[1]) end)
  
  return leaves
end

function sample:fft_recurse(tree, level_info, stop)
  -- call discretize to get the bins (the low, high, etc)
  self:discretize()
  
  -- call values on plan and monitor, return the highest
  -- scoring item, one will be best because plan calculates
  -- differently than monitor, and monitor is rest
  local bestIdeas = self:score_best_plan()
  local worstIdeas = self:score_best_monitor()
  
  --[[
  for key, value in pairs(bestIdeas) do
    io.write(value[1] .. ' ')
    value[2]:print_out()
  end
  print()
  for key, value in pairs(worstIdeas) do
    io.write(value[1] .. ' ')
    value[2]:print_out()
  end
  print()
  ]]
  
  local i = 1
  -- do 1
  local matching_list, non_matching_list = self:matches(bestIdeas[1][2])
  
  --[[
  while (#matching_list < stop and i < #bestIdeas) do
    i = i + 1
    matching_list, non_matching_list = self:matches(bestIdeas[i][2])
    
    if i == #bestIdeas then
      matching_list, non_matching_list = self:matches(bestIdeas[1][2])
    end
  end
  ]]
  
  local tmp_match, tmp_non_match
  while (i < #bestIdeas) do
    i = i + 1
    tmp_match, tmp_non_match = self:matches(bestIdeas[i][2])
    
    if (#tmp_match)^bestIdeas[i][1] > #matching_list then
      matching_list, non_matching_list = tmp_match, tmp_non_match
    end
  end
  
  table.insert(level_info, { 1, bestIdeas[1][2], {table.unpack(matching_list)} })
  
  if #non_matching_list < stop then
    table.insert(level_info, { 0, nil, {table.unpack(non_matching_list)} })
    table.insert(tree, { table.unpack(level_info) })
    table.remove(level_info, #level_info)
  else
    local sample_list = self:createSubSample(non_matching_list)
    sample_list:fft_recurse(tree, level_info, stop)
  end
  
  -- clean up the 1
  table.remove(level_info, #level_info)
  
  i = 1
  -- do 0
  matching_list, non_matching_list = self:matches(worstIdeas[1][2])
  
  --[[
  while (#matching_list < stop and i < #worstIdeas) do
    i = i + 1
    matching_list, non_matching_list = self:matches(worstIdeas[i][2])
    
    if i == #bestIdeas then
      matching_list, non_matching_list = self:matches(worstIdeas[1][2])
    end
    
  end
  ]]
  
  while (i < #worstIdeas) do
    i = i + 1
    tmp_match, tmp_non_match = self:matches(worstIdeas[i][2])
    
    if (#tmp_match)^worstIdeas[i][1]  > #matching_list then
      matching_list, non_matching_list = tmp_match, tmp_non_match
    end
  end
  
  table.insert(level_info, { 0, worstIdeas[1][2], {table.unpack(matching_list)} })
  
  if #non_matching_list < stop then
    table.insert(level_info, { 1, nil, {table.unpack(non_matching_list)} })
    table.insert(tree, { table.unpack(level_info) })
    table.remove(level_info, #level_info)
  else
    local sample_list = self:createSubSample(non_matching_list)
    sample_list:fft_recurse(tree, level_info, stop)
  end
  
  -- clean up the 0
  table.remove(level_info, #level_info)
end


function sample:score_best_plan()
  local bins_w_score = {}
  
  local s = self.settings.support
  
  for key, value in pairs(self.bins) do
    local b = value.best / value.bests
    local r = value.rest / value.rests
    
    if b > r then
      table.insert(bins_w_score, {(b^s)/(b + r), value})
    end
  end
  
  table.sort(bins_w_score, function(x, y) return x[1] > y[1] end)
  
  return bins_w_score
end

function sample:score_best_monitor()
  local bins_w_score = {}
  
  local s = self.settings.support
  
  for key, value in pairs(self.bins) do
    local b = value.best / value.bests
    local r = value.rest / value.rests
    
    if r > b then
      table.insert(bins_w_score, {(r^s)/(b + r), value})
    end
  end
  
  table.sort(bins_w_score, function(x, y) return x[1] > y[1] end)
  
  return bins_w_score
end
```