--- TODO
-- @module some.lua
-- @author Steven Jones & Azeeza Eagal
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