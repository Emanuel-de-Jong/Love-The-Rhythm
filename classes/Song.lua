local FileSystem = require("instances/FileSystem")
local Chart = require("classes/Chart")
local Song = Class:new()

Song.construct = function(self, name, path)
    self.name = name
    self.path = path
    self.charts = {}
    self.currentChart = nil

    local chartPaths = FileSystem.getFiles(self.path, ".osu")

    for k, v in pairs(chartPaths) do
        table.insert(self.charts, Chart:new(nil, k, v))
    end

    self.chart = self.charts[1]
end

return Song