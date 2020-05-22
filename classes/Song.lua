local Chart = require("classes/Chart")
local FileSystem = require("libraries/FileSystem")
local Song = Class:new()

local function checkValid(self)
    if self.charts[1] then
        local path = self.path .. "\\" .. self.charts[1].General.AudioFilename -- has space before AudioFilename because of stupid .osu file
        print(path)
        if FileSystem.checkFileExists(path) then
            self.isValid = true
            return true
        end
    end

    self.isValid = false
    return false
end

Song.construct = function(self, path)
    self.path = path
    self.charts = {}

    local chartPaths = FileSystem.getFiles(self.path, ".osu")

    local chart = nil
    for k, v in pairs(chartPaths) do
        chart = Chart:new(nil, v)
        if chart.isValid then
            table.insert(self.charts, chart)
        end
    end

    if checkValid(self) then
        self.chart = self.charts[1]
        self.name = self.chart.Metadata.Title
    end
end

return Song