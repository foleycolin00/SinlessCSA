--- This tools class is used to read in data.
-- @module tools.lua
-- @author Steven Jones & Azeeza Eagal
local b4 = {}; for k,_ in pairs(_ENV) do b4[k] = k end

local tools = {}

-- split function
function tools:stringToTable(inputString, delimiter)
  local retTable = {}
  local i = 1
  
  for word in string.gmatch(inputString, string.format('[^%s]+', delimiter)) do
    retTable[i] = word
    i = i + 1
  end
  
  return retTable
end

-- if a list has key inserts, this cannot be used because #list would be 0
-- if size is greater than list, it will just shuffle the whole list
function tools:randomSubList(list, size)
  size = math.min(size, #list)
  for i = 1, size do
    local j = i + (tools:rand() * (#list - i) // 1)
    
    list[i], list[j] = list[j], list[i]
  end
  
  return size and { table.unpack(list, 1, size) } or list
end


-- https://github.com/timm/keys/blob/main/src/rand.lua
local Seed = 62884 -- beware. do not lose control of your seeds

-- **randi(?lo : int, ?hi : int) : int**  
-- Return an int between `lo`  and `hi` (default 0..1).
--- This function returns an integer between the max and min values.
-- @param lo the minimum value 
-- @param hi the maximum value 
-- @return an integer between the max and min values
function tools:randi(lo,hi) 
  return math.floor(0.5 + tools:rand(lo,hi)) end

-- **rand(?lo : num, ?hi : num) : float**   
-- Return a float between `lo`  and `hi` (default 0..1).
--- This function returns an float between the max and min values.
-- @param lo the minimum value 
-- @param hi the maximum value 
-- @return an value between the max and min values
function tools:rand(lo,hi,     mult,mod)
  lo,hi = lo or 0, hi or 1
  mult, mod = 16807, 2147483647
  Seed = (mult * Seed) % mod 
  return lo + (hi-lo) * Seed / mod end 

--- This function takes in a csv and returns the column headers and rows that match.
-- @function csv
-- @param filename the file path 
function tools:csv(fileName)
  local headersize = 0

  local stream = fileName and io.input(fileName) or io.input()
  local tmp = io.read()
  
  local line_number = 1
  
  return function()

    while true do

      if tmp then

        local t = {}
        while true do
          
          -- remove whitespace and anything after comment characters
          tmp = tmp:gsub('[\t\r ]*', ''):gsub('#.*','')
          
          -- insert elements that are after commas into a table
          for y in tmp:gmatch('[^,]+') do
            table.insert(t, y)
          end
          
          line_number = line_number + 1
          
          if string.sub(tmp, #tmp) ~= ',' then 
            tmp = io.read()
            break
          end

          tmp = io.read()
        end 
        if headersize == 0 then headersize = #t end

        if #t > 0 then
          if #t == headersize then
            return t 
          else print(string.format("%s - Line %d: Number of columns does not match title row.", fileName, line_number - 1))
          end
        end
      else
        io.close(stream)
        break
      end
    end
  end  
end

for k,_ in pairs(_ENV) do if not b4[k] then print("?? ".. k) end end

return tools