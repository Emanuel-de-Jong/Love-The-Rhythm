local Quit = Class:new()

Quit.load = function()
    love.event.quit()
end

return Quit