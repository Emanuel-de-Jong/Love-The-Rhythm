--[[
manages user changeable options.
used mostly by PlayScene and set by OptionsScene.
--]]

local ConfigManager = require("instances/ConfigManager")
local OptionManager = Class:new()

OptionManager.options = {
    volume = 0,
    scrollSpeed = 10
}

local setConfig = function()
    ConfigManager.set("OptionManager", OptionManager.options)
end

local syncWithConfig = function()
    local data = ConfigManager.get("OptionManager")
    
    if data then
        for k, v in pairs(data) do
            if OptionManager.options[k] then
                OptionManager.options[k] = v
            end
        end
    end
end

OptionManager.set = function(options)
    OptionManager.options = options
    setConfig()
end

OptionManager.setWithElement = function(key, value)
    OptionManager.options[key] = value
    setConfig()
end

OptionManager.init = function()
    syncWithConfig()
end

return OptionManager