local Chart = require("classes/Chart")
local Song = Class:new()

Song.path = ""
Song.name = ""
Song.difficulties = {}

Song.construct = function(self, path)
    Song.path = path
    self.load()
end

Song.load = function(self)
    
end

return Song