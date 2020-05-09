local Menu = Class:new()

local title = {text="VSRRG", x=0, y=0, w=0, h=0}
local titleFont = FontList.getFont("Modak.ttf", 50)

local buttons = {
    {text="Start", scene="Select", x=0, y=0, w=0, h=0},
    {text="Options", scene="Options", x=0, y=0, w=0, h=0},
    {text="Quit", scene="Quit", x=0, y=0, w=0, h=0}
}
local buttonsFont = FontList.getFont("Modak.ttf", 30)

Menu.load = function()
    local screenHeight = love.graphics.getHeight()
    -- amount of screenHeight dedicated to the buttons section
    local buttonsHeight = screenHeight * 0.7
    local buttonHeight = buttonsHeight / #buttons

    local screenWidth = love.graphics.getWidth()

    -- half of the screen width - half of the text width = center of screen
    title.x = (screenWidth / 2) - (titleFont:getWidth(title.text) / 2)
    -- upper side of screen height leftover from buttonsHeight
    title.y = (screenHeight - buttonsHeight) / 3
    title.w = titleFont:getWidth(title.text)
    title.h = titleFont:getHeight()

    for k, v in pairs(buttons) do
        -- half of the screen width - half of the text width = center of screen
        v.x = (screenWidth / 2) - (buttonsFont:getWidth(v.text) / 2)
        -- buttonHeight * button number to seperate the buttons - half a buttonHeight to center it
        v.y = (buttonHeight * k) - (buttonHeight / 2)
        -- adds the screen height leftover from buttonsHeight to fit the title above the buttons
        v.y = v.y + (screenHeight - buttonsHeight)
        v.w = buttonsFont:getWidth(v.text)
        v.h = buttonsFont:getHeight()
    end
end

Menu.draw = function()
    love.graphics.setFont(titleFont)
    love.graphics.print(title.text, title.x, title.y)

    love.graphics.setFont(buttonsFont)
    for k, v in pairs(buttons) do
        love.graphics.print(v.text, v.x, v.y)
    end
end

Menu.mousepressed = function(x, y, button, istouch, presses)
    if button == 1 then
        for k, v in pairs(buttons) do
            if Collision.checkPointBox(x,y, v.x,v.y,v.w,v.h) then
                scene = v.scene
                _G[scene].load()
            end
        end
    end
end

return Menu