--[[
testing stuff.
--]]

local FontManager = require("instances/FontManager")
local TestScene = Class:new()

local font = FontManager.get("Modak.ttf", 20)
local keyBtn = "";
local mouseBtn = "";

TestScene.draw = function()
    love.graphics.setFont(font)

    love.graphics.print("key: " .. keyBtn, 30, 20)
    love.graphics.print("mouse: " .. mouseBtn, 30, 40)
end

TestScene.keypressed = function(key, scancode, isrepeat)
    keyBtn = key
end

TestScene.mousepressed = function(x, y, button, istouch, presses)
    mouseBtn = tostring(button)
end

return TestScene