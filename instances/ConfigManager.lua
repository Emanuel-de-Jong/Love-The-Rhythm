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

    if FileSystem.checkFileEmpty(path) then
        return nil
    end

    local data = {}
    local colonPosition = nil
    local key = nil
    local value = nil
    local t = {}
    for line in io.lines(path) do
        colonPosition = string.find(line, ":")
        key = string.sub(line, 1, colonPosition - 1)
        value = string.sub(line, colonPosition + 1)

        if tonumber(value) then
            data[key] = tonumber(value)
        elseif string.find(value, ",") then
            for s in string.gmatch(value, '([^,]+)') do
                table.insert(t, s)
            end
            data[key] = t
            t = {}
        else
            data[key] = value
        end
    end

    return data
end

return ConfigManager