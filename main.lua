require "init"

Class = require("instances/Class")
ConfigManager = require("instances/ConfigManager")
Collision = require("instances/Collision")
FontList = require("instances/FontList")
FileSystem = require("instances/FileSystem")

MenuScene = require("scenes/MenuScene")
SelectScene = require("scenes/SelectScene")
PlayScene = require("scenes/PlayScene")
OptionsScene = require("scenes/OptionsScene")
QuitScene = require("scenes/QuitScene")

scene = "MenuScene"
rootPath = love.filesystem.getWorkingDirectory()

function love.load(arg, unfilteredArg)
    ConfigManager.loadAll()

    MenuScene.load()
end

function love.update(dt)
    if _G[scene]["update"] then
        _G[scene].update(dt)
    end
end

function love.draw()
    if _G[scene]["draw"] then
        _G[scene].draw()
    end
end

function love.mousepressed(x, y, button, istouch, presses)
    if _G[scene]["mousepressed"] then
        _G[scene].mousepressed(x, y, button, istouch, presses)
    end
end

function love.keypressed(key, scancode, isrepeat)
    if _G[scene]["keypressed"] then
        _G[scene].keypressed(key, scancode, isrepeat)
    end
end

function love.wheelmoved(x, y)
    if _G[scene]["wheelmoved"] then
        _G[scene].wheelmoved(x, y)
    end
end