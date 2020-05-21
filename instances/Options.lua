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
    local data = ConfigManager.load("Options")
    if data ~= nil then
        Options.options = data
    end
end

return Options