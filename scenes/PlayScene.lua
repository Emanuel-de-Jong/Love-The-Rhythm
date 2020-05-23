--[[
plays a chart.
--]]

local FontManager = require("instances/FontManager")
local SongManager = require("instances/SongManager")
local PlayScene = Class:new()

local song = nil
local chart = nil
local index = nil
local wait = nil
local column = nil
local font = FontManager.get("Modak.ttf", 50)

PlayScene.load = function()
    song = SongManager.song
    chart = song.chart
    index = 1
    wait = chart.General.PreviewTime
    column = 1

    love.audio.play(song.audio)
end

PlayScene.unload = function()
    love.audio.stop()
end

PlayScene.update = function(dt)
    if chart.HitObjects[index] then
        wait = wait - (dt * 1000)

        if wait <= 0 then
            wait = chart.HitObjects[index].time
            column = chart.HitObjects[index].column
            index = index + 1
        end
    end
end

PlayScene.draw = function()
    love.graphics.rectangle("line", 160, 440, 120, 60)
    love.graphics.rectangle("line", 280, 440, 120, 60)
    love.graphics.rectangle("line", 400, 440, 120, 60)
    love.graphics.rectangle("line", 520, 440, 120, 60)

    if column == 1 then
        love.graphics.rectangle("fill", 160, 440, 120, 60)
    elseif column == 2 then
        love.graphics.rectangle("fill", 280, 440, 120, 60)
    elseif column == 3 then
        love.graphics.rectangle("fill", 400, 440, 120, 60)
    elseif column == 4 then
        love.graphics.rectangle("fill", 520, 440, 120, 60)
    end

    love.graphics.setFont(font)
    love.graphics.print(wait, 380, 100)
end

return PlayScene