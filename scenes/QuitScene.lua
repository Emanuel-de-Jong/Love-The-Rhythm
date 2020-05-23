--[[
quits the program.
--]]

local QuitScene = Class:new()

QuitScene.load = function()
    love.event.quit()
end

return QuitScene