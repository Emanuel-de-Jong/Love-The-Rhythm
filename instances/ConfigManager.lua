--[[
reads from and writes to text files to keep data after closing.
--]]

local FileSystem = require("libraries/FileSystem")
local ConfigManager = Class:new()

-- turns data into a txt file
ConfigManager.set = function(name, data)
    local path = FileSystem.rootPath .. "/resources/configs/" .. name .. ".txt"
    local config = io.open(path, "w")

    local line = nil
    for k, v in pairs(data) do
        line = k .. ":"

        if type(v) == "table" then -- tables get turned into comma seperated lines
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

-- turns a txt file into data
ConfigManager.get = function(name)
    local path = FileSystem.rootPath .. "/resources/configs/" .. name .. ".txt"

    if FileSystem.checkFileEmpty(path) then
        return nil
    end

    local data = {}
    local colonPosition = nil
    local key = nil
    local value = nil
    local t = {}
    for line in io.lines(path) do
        colonPosition = line:find(":")
        key = line:sub(1, colonPosition - 1)
        value = line:sub(colonPosition + 1)

        if tonumber(value) then
            data[key] = tonumber(value)
        elseif value:find(",") then
            -- adds every value between a comma to a table
            for s in value:gmatch("([^,]+)") do
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