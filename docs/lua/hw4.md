# Homework 4: Investigate "Peeking"

In this homework assignment, we attempt to implement the cluster and contrast peeking method. 
## Task 1
The first task of this homework was to implement an AHA distance function for Nums and Syms and for each row, print the row item, it's nearest item and the distance between them, and its furthest item and the distance between them. The runtime of this is 0.75 seconds on both the weather dataset and the AUTO93 set; the POM3a set took a LONG time. The code can be found at [test/lua/hw4.lua](https://github.com/foleycolin00/SinlessCSA/blob/hw4-lua/test/lua/hw4.lua) and [src/lua/sample.lua](https://github.com/foleycolin00/SinlessCSA/blob/hw4-lua/src/lua/sample.lua). 

### num.lua
````lua
function num:distance(x, y)
  x = self:norm(x)
  y = self:norm(y)
  
  if type(x) ~= 'number' and type(y) ~= 'number' then return 1 end
  if type(x) ~= 'number' then x = (y > 0.5 and 0 or 1) end
  if type(y) ~= 'number' then y = (x > 0.5 and 0 or 1) end
  
  return math.abs(x - y)
end
```

### sym.lua
```
function sym:distance(x, y)
  -- unknown should always be max distance
  if x == '?' or y == '?' then return 1 end
  
  return x == y and 0 or 1
end
```

### sample.lua
```
function sample:distance(row1, row2)
  local sum = 0
  local n = 0
  
  for i = 1, #row1 do
    if getmetatable(self.headers[i]) ~= skip and getmetatable(self.headers[i]) ~= goal and getmetatable(self.headers[i]) ~= klass then
      n = n + 1
      sum = sum + (self.headers[i]:distance(row1[i], row2[i]))^self.settings.p
    end
  end

  return (sum / n)^(1 / self.settings.p)
end
```


An example of the output: 
```
Row 14: {rainy, 71, 91, TRUE, 50, 40}
Closest: {rainy, 65, 70, TRUE, 4, 10  Distance: 0.16495721976846}
Furthest: {sunny, 85, 85, FALSE, 10, 20  Distance: 0.90267093384844}
```
## Task 2
The next task given was to show the derivation of the cosine rule. That can be seen here: https://user-images.githubusercontent.com/89092830/134360525-14f2d5b8-d40b-4bfa-934b-6c94c0fb090b.png
<br>

## Task 3
The last task given was to complement the faraway function by implementing a div1 function that does one random based on two distant points, and a divs function that does many random projections, dividing the data down to sqrt(n) of the data. The implementation can be found at [src/lua/sample.lua](https://github.com/foleycolin00/SinlessCSA/blob/hw4-lua/src/lua/sample.lua).

### sample.lua 

```
function sample:faraway(row, rows)
  rows = rows or self.rows
  local distance_list = self:neighbors(row, rows)
  local index = math.floor(self.settings.far * #rows)
  return distance_list[index > 0 and index or 1][1]
end
```

```
function sample:divide()
  local out = {}
  local enough = (#self.rows)^self.settings.enough
  
  -- adds to set of samples when they are sufficiently small
  -- or continue splitting
  local function run(sample) 
    if #sample.rows < enough then
      table.insert(out, sample)
    else
      -- splits in half
      local l, r, c = self:div(sample.rows)
      sample.c = c
      run(sample:createSubSample(l))
      run(sample:createSubSample(r))
    end
  end ----------------------------------------------
  
  -- starts the process of splitting
  run(self)
  
  local out_sortedMid = {}
  
  for key, value in pairs(out) do
    table.insert(out_sortedMid, { value, value:mid()} )
  end
  
  table.sort(out_sortedMid, function(x, y) return self:zitler(x[2], y[2]) end)
  
  return out_sortedMid
end
```

```
function sample:div(rows)
  rows = rows or self.rows
  local one = self:faraway(rows[ math.floor(tools:rand() * #rows) + 1 ],
                     tools:randomSubList(rows, self.settings.samples))
  local two = self:faraway(one,  tools:randomSubList(rows, self.settings.samples))
  
  local c = self:distance(one, two)
  
  local tmp = {}
  for key, value in pairs(rows) do
    local a = self:distance(value, one)
    local b = self:distance(value, two)
    table.insert(tmp, {value, (a^2 + c^2 - b^2) / (2 * c) })
  end
  
  table.sort(tmp, function(x,y) return x[2] < y[2] end)
  
  local l = {}
  local r = {}
  
  for i = 1, math.floor(#tmp / 2) do
    table.insert(l, tmp[i][1])
  end

  for i = math.floor(#tmp / 2) + 1, #tmp do
    table.insert(r, tmp[i][1])
  end
  
  return l, r, c
end
```