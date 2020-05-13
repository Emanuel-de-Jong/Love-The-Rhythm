local Quit = Class:new()

Quit.load = function()
    ConfigManager.saveAll()

    love.event.quit()
end

return Quit