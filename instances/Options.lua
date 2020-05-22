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

local function setConfig()
    ConfigManager.set("Options", Options.options)
end

local function getConfig()
    local data = ConfigManager.get("Options")
    if data ~= nil then
        Options.options = data
    end
end

Options.set = function(options)
    Options.options = options
    setConfig()
end

Options.setValue = function(key, value)
    Options.options[key] = value
    setConfig()
end

Options.init = function()
    getConfig()
end

return Options