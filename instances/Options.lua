local ConfigManager = require("instances/ConfigManager")
local Options = Class:new()

Options.options = {
    volume = 0,
    scrollSpeed = 10,
    -- noteColor = {
    --     value= 'white',
    --     choices = {'white', 'red', 'green', 'blue'}
    -- }
}

Options.set = function(options)
    Options.options = options
    Options.setConfig()
end

Options.setWithValue = function(key, value)
    Options.options[key] = value
    Options.setConfig()
end

Options.setConfig = function()
    ConfigManager.set("Options", Options.options)
end

Options.syncWithConfig = function()
    local data = ConfigManager.get("Options")

    for k, v in pairs(data) do
        if Options.options[k] then
            Options.options[k] = v
        end
    end
end

Options.init = function()
    Options.syncWithConfig()
end

return Options