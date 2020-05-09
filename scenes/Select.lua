local Select = Class:new()

local songs = {}
local songsFont = FontList.getFont("Modak.ttf", 20)
local songsSpacing = 50
local songsX = 0

local scrollY = 0

Select.song = ""

Select.load = function()
    for i=1, 30 do
        songs[i] = "Song " .. i
    end

    songsX = (love.graphics.getWidth() / 3) * 2
end

Select.draw = function()
    love.graphics.push()
    love.graphics.translate(0, scrollY)

    for i, v in ipairs(songs) do
        love.graphics.print(v, songsX, i * songsSpacing)
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