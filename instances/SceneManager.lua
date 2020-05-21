local SceneManager = Class:new()

SceneManager.sceneHistory = {}
SceneManager.scene = ""

-- setmetatable(SceneManager.sceneHistory, {
--     __newindex = function(t, key, value)
--         SceneManager.scene = value
--         rawset(t, key, value)
--     end
-- })

SceneManager.change = function(scene)
    scene = scene .. "Scene"
    SceneManager.sceneHistory[#SceneManager.sceneHistory + 1] = scene
    SceneManager.scene = scene
    if _G[scene]["load"] then
        _G[scene].load()
    end
end

return SceneManager