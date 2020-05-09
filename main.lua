require "init"
Class = require("instances/Class")
Collision = require("instances/Collision")
FontList = require("instances/FontList")
Menu = require("scenes/Menu")
Select = require("scenes/Select")
Quit = require("scenes/Quit")

scene = "Menu"

function love.load(arg, unfilteredArg)
    Menu.load()
end

function love.update(dt)
    if scene == "Menu" then
        Menu.update(dt)
    elseif scene == "Select" then
        Select.update(dt)
    end
end

function love.draw()
    if scene == "Menu" then
        Menu.draw()
    elseif scene == "Select" then
        Select.draw()
    end
end

function love.mousepressed(x, y, button, istouch, presses)
    if scene == "Menu" then
        Menu.mousepressed(x, y, button)
    elseif scene == "Select" then
        Select.mousepressed(x, y, button)
    end
end

function love.keypressed(key, scancode, isrepeat)

end