local SceneManager = Class:new()

SceneManager.sceneHistory = {}
SceneManager.scene = nil

SceneManager.change = function(name)
    name = name .. "Scene"
    SceneManager.sceneHistory[#SceneManager.sceneHistory + 1] = require("scenes\\" .. name)
    SceneManager.scene = SceneManager.sceneHistory[#SceneManager.sceneHistory]
    if SceneManager.scene["load"] then
        SceneManager.scene.load()
    end
end

SceneManager.goBack = function()
    SceneManager.sceneHistory[#SceneManager.sceneHistory] = nil
    SceneManager.scene = SceneManager.sceneHistory[#SceneManager.sceneHistory]
end

return SceneManager