local FileSystem = require("libraries/FileSystem")
local ConfigManager = Class:new()

ConfigManager.set = function(name, data)
    local path = FileSystem.rootPath .. "\\resources\\configs\\" .. name .. ".txt"
    local config = io.open(path, "w")

    local line = nil
    for k, v in pairs(data) do
        line = k .. ":"

        if type(v) == "table" then
            for s in pairs(v) do
                line = line .. s .. ","
            end
        else
            line = line .. v
        end

        line = line .. "\n"
        config:write(line)
    end

    config:close()
end

ConfigManager.get = function(name)
    local path = FileSystem.rootPath .. "\\resources\\configs\\" .. name .. ".txt"

    if FileSystem.checkFileEmpty(path) == true then
        return nil
    end

    local data = {}
    local colonPos = nil
    local k = nil
    local v = nil
    local t = {}
    for line in io.lines(path) do
        colonPos = string.find(line, ":")
        k = string.sub(line, 1, colonPos - 1)
        v = string.sub(line, colonPos + 1)

        if tonumber(v) then
            data[k] = tonumber(v)
        elseif string.find(v, ",") then
            for s in string.gmatch(v, '([^,]+)') do
                table.insert(t, s)
            end
            data[k] = t
            t = {}
        else
            data[k] = v
        end
    end

    return data
end

return ConfigManager