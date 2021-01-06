--[[
testing stuff.
--]]

local TestScene = Class:new()

function printT(parentTable, path)
    local file
    if path then file = io.open(path, "w") end
    local tostring, next, rep, type, format, pairs, concat, print = tostring, next, string.rep, type, string.format, pairs, table.concat, print
    if type(parentTable) ~= "table" then
        if path then
            file:write(tostring(parentTable))
            file:close()
            return print("printT done")
        else
            return print(tostring(parentTable))
        end
    end
    local t, tTabs, tablesInTSize
    local tableStack = {{ 1, parentTable, 1 }}
    local tableStackSize = 1
    local toPrint = {}
    local toPrintSize = 0
    local tableHistory = { [tostring(parentTable)] = true }
    local tablesInT = {}
    while next(tableStack) ~= nil do
        t = tableStack[tableStackSize]
        tTabs = rep("  ", t[3] - 1)
        if type(t[1]) == "string" then t[1] = format("\"%s\"", t[1]) end
        toPrintSize = toPrintSize + 1
        toPrint[toPrintSize] = format("%s[%s] -- %s, depth: %d\n", tTabs, tostring(t[1]), tostring(t[2]), t[3])
        tTabs = tTabs .. "  "
        tablesInTSize = 0
        for key, value in pairs(t[2]) do
            if type(value) == "table" and tableHistory[tostring(value)] == nil then
                tablesInTSize = tablesInTSize + 1
                tablesInT[tablesInTSize] = { key, value, t[3] + 1 }
                tableHistory[tostring(value)] = true
            else
                if type(key) == "string" then key = format("\"%s\"", key) end
                if type(value) == "string" then value = format("\"%s\"", value) end
                toPrintSize = toPrintSize + 1
                toPrint[toPrintSize] = format("%s[%s] = %s\n", tTabs, tostring(key), tostring(value))
            end
        end
        tableStack[tableStackSize] = nil
        tableStackSize = tableStackSize - 1
        for i = tablesInTSize, 1, -1 do
            tableStackSize = tableStackSize + 1
            tableStack[tableStackSize] = tablesInT[i]
        end
    end
    if path then
        file:write(concat(toPrint))
        file:close()
        print("printT done")
    else
        print(concat(toPrint))
    end
end

return TestScene