--- This settings class is used for the settings/configurations. 
-- @module settings.lua
-- @author Steven Jones & Azeeza Eagal
local b4 = {}; for k,_ in pairs(_ENV) do b4[k] = k end

--package.path = '?.lua;' + package.path

local settings = {}

local tools = require('tools')

settings.__index = settings

--- This function creates a new settings object.
-- @function new
-- @param fileName the file path 
-- @return a new settings object
function settings:new(fileName)
    local o = { name = 'default',
                p = 20,--2,
                far = 0.9,--0.9,
                samples = 800,--128,
                enough = 0.606,--0.5,
                cohen = 2.42,--0.3,
                bins = 0.35,--0.5,
                support = 2.032}--2}
    
    setmetatable(o, self)
    
    if fileName then
      for hyper_param in tools:csv(fileName) do
        local split_param = tools:stringToTable(hyper_param[1], '=')
        o[split_param[1]] = tonumber(split_param[2]) or split_param[2]
      end
    end
    
    return o
end

function settings:random()
  -- random is range + base, use // 1 to truncate to integer, add 1 to range when doing so
  local setting = self:new()
  setting.p = tools:randi(1, 30)--tools:randi(2, 2)--tools:randi(1, 10) -- 1-6 inclusive
  setting.far = tools:round(tools:rand(0.5, 0.99), 3)--tools:rand(0.9, 0.9)--tools:rand(0.2, 1) -- 0.1-0.9 inclusive
  setting.samples = tools:randi(64, 1024)--tools:randi(256, 256)--tools:randi(64, 512) -- 64-512
  setting.enough = tools:round(tools:rand(0.2, 0.8), 3)--tools:rand(0.5, 0.5)--tools:rand(0.5, 1) -- 0.1-0.9
  setting.cohen = tools:round(tools:rand(0.1, 1), 3)--tools:rand(0.3, 0.3)--tools:rand(0.1, 2) -- 0.1-0.9
  setting.bins = tools:round(tools:rand(0.2, 0.7), 3)--tools:rand(0.5, 0.5)--tools:rand(0.5, 0.9) -- dies at less than 0.5
  setting.support = tools:round(tools:rand(1, 5), 3)--tools:rand(2, 2)--tools:rand(0.1, 10) -- 0.5-5
  return setting
end

function settings:print_out(setting)
  return setting.p .. ',' .. setting.far .. ',' .. setting.samples .. ',' .. setting.enough .. ',' .. setting.cohen .. ',' ..
         setting.bins .. ',' .. setting.support
end

function settings:print_out_names(setting)
  return 'P,Far,Samples,Enough,Cohen,Bins,Support'
end

for k,_ in pairs(_ENV) do if not b4[k] then print("?? ".. k) end end

return settings