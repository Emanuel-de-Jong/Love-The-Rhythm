local OptionsScene = Class:new()

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

OptionsScene.load = function()
    optionsSettings.x = 0
    optionsSettings.w = love.graphics.getWidth() / 2

    optionsValues.x = love.graphics.getWidth() / 2
    optionsValues.w = love.graphics.getWidth() / 2
end

OptionsScene.draw = function()
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

OptionsScene.mousepressed = function(x, y, button, istouch, presses)
    if button == 1 or button == 2 then
        if Collision.checkPointBoxX(x, optionsValues.x,optionsValues.w) then
            y = y - scroll
            local index = math.floor(y / spacing)

            local key = TableSystem.getDataKey(Options.options, index)

            if Options.options[key] ~= nil then
                if button == 1 then
                    Options.options[key] = Options.options[key] + 1
                else
                    Options.options[key] = Options.options[key] - 1
                end

                ConfigManager.save("Options", Options.options)
            end
        end
    end
end

OptionsScene.wheelmoved = function(x, y)
    mouseX = love.mouse.getX()
    scroll = scroll + (y * 15)
end

return OptionsScene