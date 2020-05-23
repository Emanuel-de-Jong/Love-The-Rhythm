--[[
plays a chart.
--]]

local SongManager = require("instances/SongManager")
local PlayScene = Class:new()

local song = SongManager.song
local chart = song.chart

PlayScene.load = function()
    love.audio.play(song.audioPath)
end

PlayScene.unload = function()
    love.audio.stop()
end

PlayScene.draw = function()
    love.graphics.print(SongManager.song.chart.name, 0, 0)
end

return PlayScene