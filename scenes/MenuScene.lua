--[[
the main menu.
--]]

local FontManager = require("instances/FontManager")
local SceneManager = require("instances/SceneManager")
local CollisionSystem = require("libraries/CollisionSystem")
local MenuScene = Class:new()

local title = {text="VSRG", x = 0, y = 0, w = 0, h = 0, font = FontManager.get("Modak.ttf", 50)}

local buttons = {
    {text = "Start", scene = "Select", x = 0, y = 0, w = 0, h = 0},
    {text = "Options", scene = "Options", x = 0, y = 0, w = 0, h = 0},
    {text = "Quit", scene = "Quit", x = 0, y = 0, w = 0, h = 0}
}
local buttonsFont = FontManager.get("Modak.ttf", 30)

local function calculatePositions()
    local screenHeight = love.graphics.getHeight()
    -- amount of screenHeight dedicated to the buttons section
    local buttonsHeight = screenHeight * 0.7
    local buttonHeight = buttonsHeight / #buttons

    local screenWidth = love.graphics.getWidth()

    -- half of the screen width - half of the text width = center of screen
    title.x = (screenWidth / 2) - (title.font:getWidth(title.text) / 2)
    -- upper side of screen height leftover from buttonsHeight
    title.y = (screenHeight - buttonsHeight) / 3
    title.w = title.font:getWidth(title.text)
    title.h = title.font:getHeight()

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

MenuScene.load = function()
    calculatePositions()
end

MenuScene.draw = function()
    love.graphics.setFont(title.font)
    love.graphics.print(title.text, title.x, title.y)

    love.graphics.setFont(buttonsFont)
    for k, v in pairs(buttons) do
        love.graphics.print(v.text, v.x, v.y)
    end
end

MenuScene.mousepressed = function(x, y, button, istouch, presses)
    if button == 1 then
        for k, v in pairs(buttons) do
            if CollisionSystem.checkPointBox(x,y, v.x,v.y,v.w,v.h) then
                SceneManager.set(v.scene)
            end
        end
    end
end

MenuScene.resize = function(w, h)
    calculatePositions()
end

return MenuScene