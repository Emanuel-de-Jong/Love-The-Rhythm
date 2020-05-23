local ConfigManager = require("instances/ConfigManager")
local OptionManager = Class:new()

OptionManager.options = {
    volume = 0,
    scrollSpeed = 10,
    -- noteColor = {
    --     value= 'white',
    --     choices = {'white', 'red', 'green', 'blue'}
    -- }
}

local setConfig = function()
    ConfigManager.set("OptionManager", OptionManager.options)
end

local syncWithConfig = function()
    for k, v in pairs(ConfigManager.get("OptionManager")) do
        if OptionManager.options[k] then
            OptionManager.options[k] = v
        end
    end
end

OptionManager.set = function(options)
    OptionManager.options = options
    setConfig()
end

OptionManager.setWithValue = function(key, value)
    OptionManager.options[key] = value
    setConfig()
end

OptionManager.init = function()
    syncWithConfig()
end

return OptionManager