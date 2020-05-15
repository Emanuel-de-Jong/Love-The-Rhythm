local Options = Class:new()

Options.options = {
    volume = 0,
    scrollSpeed = 10,
    -- noteColor = {
    --     value= 'white',
    --     choices = {'white', 'red', 'green', 'blue'}
    -- }
}

Options.load = function()
    ConfigManager.configList["Options"] = "options"
end

Options.load()

return Options