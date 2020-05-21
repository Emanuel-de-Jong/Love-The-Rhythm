require "init"

Class = require("instances/Class")

ConfigManager = require("instances/ConfigManager")
SceneManager = require("instances/SceneManager")
Collision = require("instances/Collision")
FontList = require("instances/FontList")
FileSystem = require("instances/FileSystem")
TableSystem = require("instances/TableSystem")

Options = require("instances/Options")
SongManager = require("instances/SongManager")

MenuScene = require("scenes/MenuScene")
SelectScene = require("scenes/SelectScene")
PlayScene = require("scenes/PlayScene")
OptionsScene = require("scenes/OptionsScene")
QuitScene = require("scenes/QuitScene")

rootPath = love.filesystem.getWorkingDirectory()

function love.load(arg, unfilteredArg)
    Options.load()
    SongManager.load()

    SceneManager.change("Menu")
end

function love.update(dt)
    if _G[SceneManager.scene]["update"] then
        _G[SceneManager.scene].update(dt)
    end
end

function love.draw()
    if _G[SceneManager.scene]["draw"] then
        _G[SceneManager.scene].draw()
    end
end

function love.mousepressed(x, y, button, istouch, presses)
    if _G[SceneManager.scene]["mousepressed"] then
        _G[SceneManager.scene].mousepressed(x, y, button, istouch, presses)
    end
end

function love.keypressed(key, scancode, isrepeat)
    if _G[SceneManager.scene]["keypressed"] then
        _G[SceneManager.scene].keypressed(key, scancode, isrepeat)
    end
end

function love.wheelmoved(x, y)
    if _G[SceneManager.scene]["wheelmoved"] then
        _G[SceneManager.scene].wheelmoved(x, y)
    end
end