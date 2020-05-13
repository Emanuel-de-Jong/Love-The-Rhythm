local Options = Class:new()

Options.options = {
    volume = 0,
    scrollSpeed = 10,
    -- noteColor = {
    --     value= 'white',
    --     choices = {'white', 'red', 'green', 'blue'}
    -- }
}

local spacing = 50
local scroll = 0

local optionsSettings = {
    x=0,
    w=0,
    font=FontList.getFont("Modak.ttf", 20)
}

local optionsValues = {
    x=0,
    w=0,
    font=FontList.getFont("Modak.ttf", 20)
}


Options.load = function()
    optionsSettings.x = 0
    optionsSettings.w = love.graphics.getWidth() / 2

    optionsValues.x = love.graphics.getWidth() / 2
    optionsValues.w = love.graphics.getWidth() / 2
end

Options.draw = function()
    love.graphics.push()
    love.graphics.translate(0, scroll)

    love.graphics.setFont(optionsSettings.font)

    local i = 1
    for k, v in pairs(Options.options) do
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

Options.wheelmoved = function(x, y)
    mouseX = love.mouse.getX()
    scroll = scroll + (y * 15)
end

return Options