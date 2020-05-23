local FontManager = require("instances/FontManager")
local OptionManager = require("instances/OptionManager")
local CollisionSystem = require("libraries/CollisionSystem")
local TableSystem = require("libraries/TableSystem")
local OptionsScene = Class:new()

local spacing = 50
local scroll = 0

local optionsSettings = {
    x = 0,
    w = 0,
    font = FontManager.get("Modak.ttf", 20)
}

local valuesSettings = {
    x = 0,
    w = 0,
    font = FontManager.get("Modak.ttf", 20)
}

local function calculatePositions()
    local horizontalCenter = love.graphics.getWidth() / 2

    optionsSettings.x = 0
    optionsSettings.w = horizontalCenter

    valuesSettings.x = horizontalCenter
    valuesSettings.w = horizontalCenter
end

OptionsScene.load = function()
    calculatePositions()
end

OptionsScene.draw = function()
    -- translate offsets the coordinate system so that x and y's can stay the same but you will see movement on the screen
    -- between push and pop is where translate will have effect
    love.graphics.push()
    love.graphics.translate(0, scroll)

    love.graphics.setFont(optionsSettings.font)

    local i = 1
    for k in pairs(OptionManager.options) do
        love.graphics.print(k, optionsSettings.x, i * spacing)
        i = i + 1
    end

    love.graphics.setFont(valuesSettings.font)

    i = 1
    for k, v in pairs(OptionManager.options) do
        love.graphics.print(v, valuesSettings.x, i * spacing)
        i = i + 1
    end

    love.graphics.pop()
end

OptionsScene.mousepressed = function(x, y, button, istouch, presses)
    if button == 1 or button == 2 then
        if CollisionSystem.checkPointBoxX(x, valuesSettings.x,valuesSettings.w) then
            y = y - scroll
            local index = math.floor(y / spacing)

            local key = TableSystem.getKeyWithPosition(OptionManager.options, index)

            if OptionManager.options[key] then
                -- increments or decrements the pressed option depending on button press
                if button == 1 then
                    OptionManager.setWithElement(key, OptionManager.options[key] + 1)
                else
                    OptionManager.setWithElement(key, OptionManager.options[key] - 1)
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