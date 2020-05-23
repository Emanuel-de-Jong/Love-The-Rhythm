--[[
plays a chart.
--]]

local SongManager = require("instances/SongManager")
local PlayScene = Class:new()

local song = nil
local chart = nil

PlayScene.load = function()
    song = SongManager.song
    chart = song.chart
    love.audio.play(song.audio)
end

PlayScene.unload = function()
    love.audio.stop()
end

PlayScene.draw = function()
    love.graphics.print(chart.name, 0, 0)
end

return PlayScene