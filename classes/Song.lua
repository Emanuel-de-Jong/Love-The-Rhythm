local FileSystem = require("libraries/FileSystem")
local Chart = require("classes/Chart")
local Song = Class:new()

Song.construct = function(self, path)
    self.path = path
    self.charts = {}

    local chartPaths = FileSystem.getFiles(self.path, ".osu")

    for k, v in pairs(chartPaths) do
        table.insert(self.charts, Chart:new(nil, v))
    end

    if self.charts[1] then
        self.chart = self.charts[1]
        self.name = self.chart.Metadata["Title"]
    end
end

return Song