local Song = require("classes/Song")
local Select = Class:new()

local songs = {}
local songsFont = FontList.getFont("Modak.ttf", 13)
local songsSpacing = 50
local songsX = 0

local scrollY = 0

Select.song = nil

Select.load = function()
    local songPaths = FileSystem.getDirectories(love.filesystem.getWorkingDirectory() .. "\\resources\\songs")

    for k, v in pairs(songPaths) do
        table.insert(songs, Song:new(nil, k, v))
    end

    songsX = (love.graphics.getWidth() / 2)
end

Select.draw = function()
    love.graphics.push()
    love.graphics.translate(0, scrollY)

    for i, v in ipairs(songs) do
        love.graphics.print(v.name, songsX, i * songsSpacing)
    end
    
    love.graphics.pop()
end

Select.mousepressed = function(x, y, button, istouch, presses)
    if button == 1 then
        if x > songsX and x < love.graphics.getWidth() then
            y = y - scrollY
            local index = math.floor(y / songsSpacing)

            Select.song = songs[index]

            scene = "Play"
            _G[scene].load()
        end
    end
end

Select.wheelmoved = function(x, y)
    scrollY = scrollY + (y * 15)
end

return Select