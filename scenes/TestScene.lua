--[[
testing stuff.
--]]

local FontManager = require("instances/FontManager")
local TestScene = Class:new()

local font = FontManager.get("Helvetica.ttf", 22)
local screenHeight = love.graphics.getHeight()

local callbacks = {
	"gamepadaxis",
	"gamepadpressed",
	"gamepadreleased",
	"joystickadded",
	"joystickaxis",
	"joystickhat",
	"joystickpressed",
	"joystickreleased",
	"joystickremoved",
	"keypressed",
	"keyreleased",
	"mousefocus",
	"mousemoved",
	"mousepressed",
	"mousereleased",
	"textedited",
	"textinput",
	"touchmoved",
	"touchpressed",
	"touchreleased",
	"wheelmoved",
}

local values = {
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
	textedited = {
        text = "",
        start = "",
        length = "",
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
    for _, callback in pairs(callbacks) do
        love.graphics.print(callback, x, y)

        for key, value in pairs(values[callback]) do
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

for callback in pairs(values) do
    TestScene[callback] = function(...)
        local args = {...}
        local i = 1

        for key in pairs(values[callback]) do
            values[callback][key] = tostring(args[i])
            i = i + 1
        end
    end
end

return TestScene