local SceneManager = Class:new()

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
        sceneHistory[#sceneHistory] = nil
        SceneManager.scene = sceneHistory[#sceneHistory]

        if SceneManager.scene.load then
            SceneManager.scene.load()
        end
    end
end

return SceneManager