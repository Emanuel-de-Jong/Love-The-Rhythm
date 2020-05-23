--[[
represents a directory with .osu files in resources/songs.
--]]

local Chart = require("classes/Chart")
local FileSystem = require("libraries/FileSystem")
local Song = Class:new()

-- checks if charts is not empty and if the audiofile exists
local function checkValid(self)
    if self.charts[1] then
        if FileSystem.checkFileExists(self.audioPath) then
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

    if self.charts[1] then
        self.chart = self.charts[1]
        self.name = self.chart.Metadata.Title
        self.audioPath = self.path .. "/" .. self.charts[1].General.AudioFilename
    end

    if not checkValid(self) then
        return
    end
end

return Song