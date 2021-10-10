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
                p = 2,
                far = 0.9,
                samples = 128,
                enough = 0.5,
                cohen = 0.3,
                bins = 0.5,
                support = 2}
    
    setmetatable(o, self)
    
    if fileName then
      for hyper_param in tools:csv(fileName) do
        local split_param = tools:stringToTable(hyper_param[1], '=')
        o[split_param[1]] = tonumber(split_param[2]) or split_param[2]
      end
    end
    
    return o
end

for k,_ in pairs(_ENV) do if not b4[k] then print("?? ".. k) end end

return settings