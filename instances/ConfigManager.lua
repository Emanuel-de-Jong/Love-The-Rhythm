local ConfigManager = Class:new()

ConfigManager.configList = {}

ConfigManager.load = function(path)
    if FileSystem.checkFileEmpty(path) == false then
        return {}
    end

    local data = {}
    local colonPos = 0
    local k = ""
    local v = ""
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

ConfigManager.loadAll = function()
    local data = {}
    for k, v in pairs(ConfigManager.configList) do
        data = ConfigManager.load(rootPath .. "\\resources\\configs\\" .. k .. ".txt")
        if #data ~= 0 then
            _G[k][v] = data
        end
    end
end

ConfigManager.save = function(path, data)
    local config = io.open(path, "w")

    local line = ""
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

    return config
end

ConfigManager.saveAll = function()
    for k, v in pairs(ConfigManager.configList) do
        ConfigManager.save(rootPath .. "\\resources\\configs\\" .. k .. ".txt", _G[k][v])
    end
end

return ConfigManager