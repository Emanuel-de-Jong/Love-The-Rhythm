local SceneManager = Class:new()

-- keeps the previous scenes for when you want to go back
local sceneHistory = {}

SceneManager.scene = nil

SceneManager.set = function(name)
    name = name .. "Scene"
    sceneHistory[#sceneHistory + 1] = require("scenes/" .. name)
    SceneManager.scene = sceneHistory[#sceneHistory]
    
    if SceneManager.scene.load then
        SceneManager.scene.load()
    end
end

SceneManager.goBack = function()
    if(#sceneHistory > 1) then
        if SceneManager.scene.unload then
            SceneManager.scene.unload()
        end

        sceneHistory[#sceneHistory] = nil
        SceneManager.scene = sceneHistory[#sceneHistory]

        if SceneManager.scene.load then
            SceneManager.scene.load()
        end
    end
end

return SceneManager