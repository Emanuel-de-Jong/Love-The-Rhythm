local SongManager = require("instances/SongManager")
local SceneManager = require("instances/SceneManager")
local Collision = require("libraries/Collision")
local FontList = require("instances/FontList")
local SelectScene = Class:new()

local songsSettings = {
    spacing = 50,
    x = 0,
    w = 0,
    scroll = 0,
    font = FontList.get("Modak.ttf", 20)
}

local chartsSettings = {
    spacing = 50,
    x = 0,
    w = 0,
    scroll = 0,
    font = FontList.get("Modak.ttf", 15)
}

SelectScene.calculatePositions = function()
    local horizontalCenter = love.graphics.getWidth() / 2

    songsSettings.x = horizontalCenter
    songsSettings.w = horizontalCenter

    chartsSettings.x = 0
    chartsSettings.w = horizontalCenter
end

SelectScene.load = function()
    SelectScene.calculatePositions()
end

SelectScene.draw = function()
    love.graphics.push()
    love.graphics.translate(0, songsSettings.scroll)

    love.graphics.setFont(songsSettings.font)

    for i, v in ipairs(SongManager.songs) do
        love.graphics.print(v.name, songsSettings.x, i * songsSettings.spacing)
    end
    
    love.graphics.pop()

    if SongManager.song then
        love.graphics.push()
        love.graphics.translate(0, chartsSettings.scroll)

        love.graphics.setFont(chartsSettings.font)

        for i, v in ipairs(SongManager.song.charts) do
            love.graphics.print(v.name, chartsSettings.x, i * chartsSettings.spacing)
        end
        
        love.graphics.pop()
    end
end

SelectScene.mousepressed = function(x, y, button, istouch, presses)
    if button == 1 then
        if Collision.checkPointBoxX(x, songsSettings.x,songsSettings.w) then
            y = y - songsSettings.scroll
            local index = math.floor(y / songsSettings.spacing)

            SongManager.changeByIndex(index)
        elseif Collision.checkPointBoxX(x, chartsSettings.x,chartsSettings.w) then
            y = y - chartsSettings.scroll
            local index = math.floor(y / chartsSettings.spacing)

            SongManager.song.chart = SongManager.song.charts[index]

            SceneManager.set("Play")
        end
    end
end

SelectScene.wheelmoved = function(x, y)
    local mouseX = love.mouse.getX()

    if Collision.checkPointBoxX(mouseX, songsSettings.x,songsSettings.w) then
        songsSettings.scroll = songsSettings.scroll + (y * 15)
    elseif Collision.checkPointBoxX(mouseX, chartsSettings.x,chartsSettings.w) then
        chartsSettings.scroll = chartsSettings.scroll + (y * 15)
    end
end

SelectScene.resize = function(w, h)
    SelectScene.calculatePositions()
end

return SelectScene