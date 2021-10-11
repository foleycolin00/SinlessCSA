# Homework 6: Build a FFT forest 

## Output: 
```
1
 1      if Cylinders <= 4               [ 1925.0 14.0 30.0 ] (208)
 1   elseif Cylinders <= 6              [ 2930.0 15.5 20.0 ] (87)
 1   elseif Displacement <= 318         [ 3672.0 11.5 20.0 ] (47)
 1   elseif Model > 72          [ 4668.0 11.5 20.0 ] (32)
 0   else [ 4274.0 12.0 10.0 ] (24)

2
 1      if Cylinders <= 4               [ 1925.0 14.0 30.0 ] (208)
 1   elseif Cylinders <= 6              [ 2930.0 15.5 20.0 ] (87)
 1   elseif Displacement <= 318         [ 3672.0 11.5 20.0 ] (47)
 0   elseif Displacement > 351          [ 4654.0 13.0 10.0 ] (29)
 1   else [ 3664.0 11.0 10.0 ] (27)

3
 1      if Cylinders <= 4               [ 1925.0 14.0 30.0 ] (208)
 1   elseif Cylinders <= 6              [ 2930.0 15.5 20.0 ] (87)
 0   elseif Horsepower > 215            [ 4425.0 10.0 10.0 ] (5)
 1   elseif Displacement <= 305         [ 3880.0 12.5 20.0 ] (45)
 1   elseif Displacement <= 318         [ 4732.0 18.5 10.0 ] (19)
 0   else [ 4274.0 12.0 10.0 ] (34)

4
 1      if Cylinders <= 4               [ 1925.0 14.0 30.0 ] (208)
 1   elseif Cylinders <= 6              [ 2930.0 15.5 20.0 ] (87)
 0   elseif Horsepower > 215            [ 4425.0 10.0 10.0 ] (5)
 1   elseif Displacement <= 305         [ 3880.0 12.5 20.0 ] (45)
 0   elseif Displacement > 318          [ 4274.0 12.0 10.0 ] (34)
 1   else [ 4732.0 18.5 10.0 ] (19)

5
 1      if Cylinders <= 4               [ 1925.0 14.0 30.0 ] (208)
 1   elseif Cylinders <= 6              [ 2930.0 15.5 20.0 ] (87)
 0   elseif Horsepower > 215            [ 4425.0 10.0 10.0 ] (5)
 0   elseif Displacement > 305          [ 4154.0 13.5 10.0 ] (71)
 1   else [ 4141.0 14.0 20.0 ] (27)

6
 1      if Cylinders <= 4               [ 1925.0 14.0 30.0 ] (208)
 0   elseif Displacement > 350          [ 4615.0 14.0 10.0 ] (37)
 1   elseif Cylinders <= 6              [ 2930.0 15.5 20.0 ] (87)
 1   elseif Model > 72          [ 4082.0 13.0 20.0 ] (46)
 0   else [ 4077.0 14.0 10.0 ] (20)

7
 1      if Cylinders <= 4               [ 1925.0 14.0 30.0 ] (208)
 0   elseif Displacement > 350          [ 4615.0 14.0 10.0 ] (37)
 1   elseif Cylinders <= 6              [ 2930.0 15.5 20.0 ] (87)
 0   elseif Displacement > 340          [ 3664.0 11.0 10.0 ] (18)
 1   else [ 4140.0 13.7 20.0 ] (48)

8
 1      if Cylinders <= 4               [ 1925.0 14.0 30.0 ] (208)
 0   elseif Displacement > 350          [ 4615.0 14.0 10.0 ] (37)
 0   elseif Cylinders > 6               [ 4190.0 13.0 20.0 ] (66)
 1   elseif Model > 76          [ 2965.0 15.8 20.0 ] (38)
 0   else [ 3730.0 19.0 20.0 ] (49)

9
 1      if Cylinders <= 4               [ 1925.0 14.0 30.0 ] (208)
 0   elseif Displacement > 350          [ 4615.0 14.0 10.0 ] (37)
 0   elseif Cylinders > 6               [ 4190.0 13.0 20.0 ] (66)
 0   elseif origin == 1         [ 3620.0 18.7 20.0 ] (74)
 1   else [ 2930.0 15.5 20.0 ] (13)

10
 0      if Cylinders > 4                [ 3830.0 15.2 20.0 ] (190)
 1   elseif origin == 3         [ 2100.0 16.5 30.0 ] (73)
 1   elseif origin == 2         [ 1925.0 14.0 30.0 ] (63)
 1   elseif Model <= 77         [ 2125.0 14.5 30.0 ] (28)
 0   else [ 2635.0 16.4 30.0 ] (44)

11
 0      if Cylinders > 4                [ 3830.0 15.2 20.0 ] (190)
 1   elseif origin == 3         [ 2100.0 16.5 30.0 ] (73)
 1   elseif origin == 2         [ 1925.0 14.0 30.0 ] (63)
 0   elseif Displacement > 140          [ 2572.0 14.9 30.0 ] (39)
 1   else [ 2075.0 15.9 30.0 ] (33)

12
 0      if Cylinders > 4                [ 3830.0 15.2 20.0 ] (190)
 1   elseif origin == 3         [ 2100.0 16.5 30.0 ] (73)
 0   elseif Displacement > 114          [ 2592.0 18.5 20.0 ] (66)
 1   elseif Model > 71          [ 1963.0 15.5 30.0 ] (60)
 0   else [ 2046.0 19.0 30.0 ] (9)

13
 0      if Cylinders > 4                [ 3830.0 15.2 20.0 ] (190)
 1   elseif origin == 3         [ 2100.0 16.5 30.0 ] (73)
 0   elseif Displacement > 114          [ 2592.0 18.5 20.0 ] (66)
 0   elseif Horsepower > 62             [ 1990.0 14.9 30.0 ] (56)
 1   else [ 1835.0 20.5 30.0 ] (13)

14
 0      if Cylinders > 4                [ 3830.0 15.2 20.0 ] (190)
 0   elseif origin == 2         [ 2635.0 16.4 30.0 ] (153)
 1   elseif origin == 2         [ 1867.0 19.5 30.0 ] (14)
 0   else [ 2003.0 19.0 30.0 ] (41)

15
 0      if Cylinders > 4                [ 3830.0 15.2 20.0 ] (190)
 0   elseif origin == 2         [ 2635.0 16.4 30.0 ] (153)
 0   elseif origin == 1         [ 2380.0 20.7 30.0 ] (50)
 1   else [ 2085.0 21.7 40.0 ] (5)
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