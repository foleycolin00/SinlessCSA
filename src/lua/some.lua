-- a non parameteric collector

local some = {}
-- require ?

some.__index = some

-- create a new some object
function some:new(col_name)
    -- what should go in here
    local o = {}
    setmetatable(o, self)
    
    return o
end




return some

