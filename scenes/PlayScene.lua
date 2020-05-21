local SongManager = require("instances/SongManager")
local PlayScene = Class:new()

PlayScene.load = function()
    
end

PlayScene.update = function(dt)

end

PlayScene.draw = function()
    love.graphics.print(SongManager.song.chart.name, 0, 0)
end

return PlayScene