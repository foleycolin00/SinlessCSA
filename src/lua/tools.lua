local b4 = {}; for k,_ in pairs(_ENV) do b4[k] = k end

local tools = {}

--[[
function tools.stringToTable(inputString, delimiter)
  retTable = {}
  local i = 1
  
  for word in string.gmatch(inputString, string.format('[^%s]+', delimiter)) do
    retTable[i] = word
    i = i + 1
  end
  
  return retTable
end

-- take in a csv
-- return column headers, and rows that match
function tools.csv(fileName)
  headers = {}
  rows = {}
  
  local i = 0
  local tempTable = {}
  
  -- fill the table with lines from file
  for line in io.lines(fileName) do
    table.insert(tempTable, line)
  end
  
  -- temp value used for line extensions
  savedVal = ''
  
  -- for all lines in table, first split on ,
  -- then on the split items, remove whitespace
  for k,v in pairs(tempTable) do
    -- remove comments, if there was one
    local val = string.find(v, '#')
    if val then v = string.sub(v, 0, val - 1) end
    
    -- remove whitespace
    v = string.gsub(v, '[\t\n ]', '')
    
    -- if the line had a comma, then add to the saved line, keeps appending
    -- if there is a saved line with a comma and the current did not have comma, we have end
    if string.sub(v, #v) == ','then
      savedVal = savedVal .. v
      -- make sure it isnt accidently the right length for the following cases
      v = ''
    elseif string.sub(savedVal, #savedVal) == ',' then
      v = savedVal .. v
      savedVal = ''
    end
    
    -- split by commas
    v = tools.stringToTable(v, ',')
    
    -- empty if it is empty and also not a continuation
    if #v == 0 and #savedVal == 0 then print(string.format('Empty at line %d', i)) end
    
    -- when headers is empty, it is first one, fill headers
    if #headers == 0 then
      -- remove these symbols ?!+-
      for j = 1, #v do
        v[j] = string.gsub(v[j], '[?!]*+*-*', '')
      end
      headers = v
    elseif #v == #headers then table.insert(rows, v)
    elseif #savedVal == 0 then print(string.format('Number of columns does not match at line %d', i))
    end
    
    i = i + 1
  end
  
  for i = 1, #rows do
    for j = 1, #rows[1] do
      tempVal = tonumber(rows[i][j])
      if tempVal ~= nil then
        rows[i][j] = tempVal
      end
    end
  end

  
  return headers, rows
end
]]

-- take in a csv
-- return column headers, and rows that match
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
            -- convert to type number if possible 
            y = tonumber(y) or y
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
          else print(string.format("%s - Line %d: Number of columns does not match title row.", fileName, line_number - 2))
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