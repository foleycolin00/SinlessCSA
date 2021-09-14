# Sinless Software Engineering: Homework Documentation

## Homework 2: Create a CSV File Reader

### Tools.lua

<ul><details><summary>function tools:csv(fileName)</summary>


```lua
local tools = {}
function tools:csv(fileName)

  local headersize = 0

  local stream = fileName and io.input(fileName) or io.input()
  local tmp = io.read()
  
  return function()

    while true do

      if tmp then

        local t = {}
        while true do
          -- remove white space and comments
          tmp = tmp:gsub('[\t\r ]*', ''):gsub('#.*','')
          -- sepreate by comma
          for y in tmp:gmatch('[^,]+') do
            table.insert(t, y)
          end
          
          if string.sub(tmp, #tmp) ~= ',' then 
            tmp = io.read()
            break
          end

          tmp = io.read()
        end 
        if headersize == 0 then headersize = #t end

        if #t > 0 then
          for key, value in pairs(t) do
            value = tonumber(value) or value
          end
          if #t == headersize then return t else print("This line number of columns does not equal the header number of columns") end
        end
      else
        io.close(stream)
        break
      end
    end
  end  
end

return tools
```
</details></ul>
POM3a Runtime: 0.46 seconds