--[[
testing stuff.
--]]

local TestScene = Class:new()

function printT(tableToPrint)
    local next, pairs, type, format, tostring, remove, print = next, pairs, type, string.format, tostring, table.remove, print
    local tables = {{tableToPrint,"  "}}
    local oldTables = {}
    local tablesLength
    local tTabs
    local str = ""
    local loopCount = 0
    while next(tables) ~= nil do
        tablesLength = #tables
        tTabs = tables[tablesLength][2]
        for key, value in pairs(tables[tablesLength][1]) do
            if type(value) ~= "table" then
                str = str .. format("%s%s  =  %s\n", tTabs, tostring(key), tostring(value))
            elseif oldTables[tostring(value)] == nil then
                tables[#tables+1] = {
                    value,
                    tTabs .. "  "
                }
                oldTables[tostring(value)] = true
            end
        end
        remove(tables, tablesLength)
        loopCount = loopCount + 1
        if loopCount == 50 then
            print(str)
            str = ""
            loopCount = 0
        end
    end
    print(str)
end

return TestScene