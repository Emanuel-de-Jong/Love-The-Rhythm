local FontList = require("instances/FontList")
local Collision = require("libraries/Collision")
local Options = require("instances/Options")
local TableSystem = require("libraries/TableSystem")
local OptionsScene = Class:new()

local spacing = 50
local scroll = 0

local optionsSettings = {
    x = 0,
    w = 0,
    font = FontList.get("Modak.ttf", 20)
}

local optionsValues = {
    x = 0,
    w = 0,
    font = FontList.get("Modak.ttf", 20)
}

local function calculatePositions()
    local horizontalCenter = love.graphics.getWidth() / 2

    optionsSettings.x = 0
    optionsSettings.w = horizontalCenter

    optionsValues.x = horizontalCenter
    optionsValues.w = horizontalCenter
end

OptionsScene.load = function()
    calculatePositions()
end

OptionsScene.draw = function()
    love.graphics.push()
    love.graphics.translate(0, scroll)

    love.graphics.setFont(optionsSettings.font)

    local i = 1
    for k in pairs(Options.options) do
        love.graphics.print(k, optionsSettings.x, i * spacing)
        i = i + 1
    end

    love.graphics.setFont(optionsValues.font)

    i = 1
    for k, v in pairs(Options.options) do
        love.graphics.print(v, optionsValues.x, i * spacing)
        i = i + 1
    end

    love.graphics.pop()
end

OptionsScene.mousepressed = function(x, y, button, istouch, presses)
    if button == 1 or button == 2 then
        if Collision.checkPointBoxX(x, optionsValues.x,optionsValues.w) then
            y = y - scroll
            local index = math.floor(y / spacing)

            local key = TableSystem.getKeyWithPosition(Options.options, index)

            if Options.options[key] then
                if button == 1 then
                    Options.setWithValue(key, Options.options[key] + 1)
                else
                    Options.setWithValue(key, Options.options[key] - 1)
                end
            end
        end
    end
end

OptionsScene.wheelmoved = function(x, y)
    scroll = scroll + (y * 15)
end

OptionsScene.resize = function(w, h)
    calculatePositions()
end

return OptionsScene