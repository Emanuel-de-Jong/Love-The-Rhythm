local SongManager = require("instances/SongManager")
local PlayScene = Class:new()

PlayScene.draw = function()
    love.graphics.print(SongManager.song.chart.name, 0, 0)
end

return PlayScene