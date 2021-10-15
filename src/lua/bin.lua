--- This goal class is used to create and output a bin object.
-- @module bin.lua
-- @author Steven Jones & Azeeza Eagal
local b4 = {}; for k,_ in pairs(_ENV) do b4[k] = k end

local bin = {}

bin.__index = bin

--- This function creates a new bin object.
-- @function new
-- @param index column index 
-- @param name name of column 
-- @param lo lowest value in range 
-- @param best best in range 
-- @param bests total best in column
-- @param rest rest in range 
-- @param rests total rest in column 
-- @param first first in range 
-- @param last last in range 
-- @return a new bin object
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

--- This function prints out the content of a bin object
-- @function print_out
function bin:print_out()
  print(self.col_index .. ' ' .. self.col_name ..
        ' low = ' .. self.low .. ' hi = ' .. self.high ..
        ' best = ' .. self.best .. ' bests = ' .. self.bests ..
        ' rest = ' .. self.rest .. ' rests = ' .. self.rests ..
        ' first = ' .. tostring(self.first) .. ' last = ' .. tostring(self.last))
end

for k,_ in pairs(_ENV) do if not b4[k] then print("?? ".. k) end end

return bin