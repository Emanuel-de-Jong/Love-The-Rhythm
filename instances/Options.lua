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

local function saveConfig()
    ConfigManager.save("Options", Options.options)
end

local function loadConfig()
    local data = ConfigManager.load("Options")
    if data ~= nil then
        Options.options = data
    end
end

Options.change = function(options)
    Options.options = options
    saveConfig()
end

Options.changeValue = function(key, value)
    Options.options[key] = value
    saveConfig()
end

Options.init = function()
    loadConfig()
end

return Options