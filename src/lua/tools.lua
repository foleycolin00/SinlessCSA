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