local Chart = require("classes/Chart")
local Song = Class:new()

Song.path = ""
Song.name = ""
Song.charts = {}

Song.construct = function(self, path)
    Song.path = path
    self.load()
end

Song.load = function(self)
    for k, v in pairs(FileSystem.getDirectories("D:\\Programming\\Repos\\Learning-Love\\resources\\songs")) do
        print('key: ', k, '        value: ', v)
    end
end

return Song