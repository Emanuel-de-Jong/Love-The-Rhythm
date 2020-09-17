--[[
testing stuff.
--]]

local TestScene = Class:new()

function printT(tableToPrint)
    if type(tableToPrint) ~= "table" then
        print(tostring(tableToPrint))
        return
    end
    local next, pairs, type, format, tostring, remove, print = next, pairs, type, string.format, tostring, table.remove, print
    local tables = {{tableToPrint,"  "}}
    local oldTables = {}
    local tablesLength
    local t
    local tTabs
    local str = ""
    local loopCount = 0
    while next(tables) ~= nil do
        tablesLength = #tables
        t = tables[tablesLength]
        remove(tables, tablesLength)
        tTabs = t[2]
        str = str .. format("%s%s  =  %s\n", tTabs,tostring(t[3]), tostring(t[1]))
        for key, value in pairs(t[1]) do
            if type(value) ~= "table" then
                str = str .. format("%s  %s  =  %s\n", tTabs, tostring(key), tostring(value))
            elseif oldTables[tostring(value)] == nil then
                tables[#tables+1] = {
                    value,
                    tTabs .. "  ",
                    key
                }
                oldTables[tostring(value)] = true
            end
        end
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