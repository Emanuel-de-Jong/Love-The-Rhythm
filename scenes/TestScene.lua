--[[
testing stuff.
--]]

local TestScene = Class:new()

function printT(parentTable)
    local tostring, next, rep, type, format, pairs, print = tostring, next, string.rep, type, string.format, pairs, print
    if type(parentTable) ~= "table" then return print(tostring(parentTable)) end
    local t, tTabs, tablesInT, tablesInTSize
    local tableStack = {{ 1, parentTable, 1 }}
    local tableStackSize = 1
    local strToPrint = ""
    local tableHistory = { tostring(parentTable) }
    local loopsSincePrint = 0
    while next(tableStack) ~= nil do
        t = tableStack[tableStackSize]
        tTabs = rep("  ", t[3] - 1)
        if type(t[1]) == "number" then
            strToPrint = strToPrint .. format("%s[%s] = %s - %s\n", tTabs, tostring(t[1]), tostring(t[2]), tostring(t[3]))
        else
            strToPrint = strToPrint .. format("%s[\"%s\"] = %s - %s\n", tTabs, tostring(t[1]), tostring(t[2]), tostring(t[3]))
        end
        tTabs = tTabs .. "  "
        tablesInT = {}
        tablesInTSize = 0
        for key, value in pairs(t[2]) do
            if type(value) == "table" and tableHistory[tostring(value)] == nil then
                tablesInTSize = tablesInTSize + 1
                tablesInT[tablesInTSize] = { key, value, t[3] + 1 }
                tableHistory[tostring(value)] = true
            else
                if type(key) == "number" then
                    strToPrint = strToPrint .. format("%s[%s] = %s\n", tTabs, tostring(key), tostring(value))
                else
                    strToPrint = strToPrint .. format("%s[\"%s\"] = %s\n", tTabs, tostring(key), tostring(value))
                end
            end
        end
        tableStack[tableStackSize] = nil
        tableStackSize = tableStackSize - 1
        for i = tablesInTSize, 1, -1 do
            tableStackSize = tableStackSize + 1
            tableStack[tableStackSize] = tablesInT[i]
        end
        loopsSincePrint = loopsSincePrint + 1
        if loopsSincePrint == 50 then
            print(strToPrint)
            strToPrint = ""
            loopsSincePrint = 0
        end
    end
    print(strToPrint)
end

return TestScene