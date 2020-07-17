--[[
starts the program and handles the main loops
--]]

Class = require("classes/Class")

local InputManager = require("instances/InputManager")
local SceneManager = require("instances/SceneManager")

local callbacks = {
	"directorydropped",
	"displayrotated",
	"draw",
	"errhand",
	"errorhandler",
	"filedropped",
	"focus",
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
	"lowmemory",
	"mousefocus",
	"mousemoved",
	"mousepressed",
	"mousereleased",
	"quit",
	"resize",
	"textedited",
	"textinput",
	"threaderror",
	"touchmoved",
	"touchpressed",
	"touchreleased",
	"update",
	"visible",
	"wheelmoved",
}

function love.load(arg, unfilteredArg)
    SceneManager.set("Test")
    -- SceneManager.set("Menu")
end

-- goes through all love callback functions and calls the corresponding function of the current scene
for _, callback in pairs(callbacks) do
    love[callback] = function(...)
        if InputManager[callback] then
            InputManager[callback](...)
        end
        if SceneManager.scene[callback] then
            SceneManager.scene[callback](...)
        end
    end
end