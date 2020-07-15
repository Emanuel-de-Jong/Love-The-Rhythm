--[[
testing stuff.
--]]

local FontManager = require("instances/FontManager")
local TestScene = Class:new()

local font = FontManager.get("Helvetica.ttf", 22)
local screenHeight = love.graphics.getHeight()

local callbacks = {
	gamepadaxis = {
        joystick = "",
        axis = "",
        value = "",
    },
	gamepadpressed = {
        joystick = "",
        button = "",
    },
    gamepadreleased = {
        joystick = "",
        button = "",
    },
	joystickadded = {
        joystick = "",
    },
	joystickaxis = {
        joystick = "",
        axis = "",
        value = "",
    },
	joystickhat = {
        joystick = "",
        hat = "",
        direction = "",
    },
	joystickpressed = {
        joystick = "",
        button = "",
    },
	joystickreleased = {
        joystick = "",
        button = "",
    },
	joystickremoved = {
        joystick = "",
    },
	keypressed = {
        key = "",
        scancode = "",
        isrepeat = "",
    },
	keyreleased = {
        key = "",
        scancode = "",
    },
	mousefocus = {
        focus = "",
    },
	mousemoved = {
        x = "",
        y = "",
        dx = "",
        dy = "",
        istouch = "",
    },
    mousepressed = {
        x = "",
        y = "",
        button = "",
        istouch = "",
        pressed = "",
    },
	mousereleased = {
        x = "",
        y = "",
        button = "",
        istouch = "",
        presses = "",
    },
	textinput = {
        text = "",
    },
	touchmoved = {
        id = "",
        x = "",
        y = "",
        dx = "",
        dy = "",
        pressure = "",
    },
    touchpressed = {
        id = "",
        x = "",
        y = "",
        dx = "",
        dy = "",
        pressure = "",
    },
	touchreleased = {
        id = "",
        x = "",
        y = "",
        dx = "",
        dy = "",
        pressure = "",
    },
	wheelmoved = {
        x = "",
        y = "",
    },
}

TestScene.draw = function()
    love.graphics.setFont(font)

    local x = 30
    local y = 20
    for callback in pairs(callbacks) do
        love.graphics.print(callback, x, y)

        for key, value in pairs(callbacks[callback]) do
            y = y + 25
            love.graphics.print(key .. ": " .. value, x + 15, y)
        end

        if y > screenHeight - 200 then
            x = x + 400
            y = 20
        else
            y = y + 45
        end
    end
end

TestScene.resize = function(w, h)
    screenHeight = love.graphics.getHeight()
end

for callback in pairs(callbacks) do
    TestScene[callback] = function(...)
        local args = {...}
        local i = 1

        for key in pairs(callbacks[callback]) do
            callbacks[callback][key] = tostring(args[i])
            i = i + 1
        end
    end
end

return TestScene