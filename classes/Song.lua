--[[
represents a directory with .osu files in resources/songs.
--]]

local Chart = require("classes/Chart")
local FileSystem = require("libraries/FileSystem")
local Song = Class:new()

-- checks if charts is not empty and if the audiofile exists
local function checkValid(self)
    if self.charts[1] then
        if FileSystem.checkFileExists(self.path .. "/" .. self.charts[1].General.AudioFilename) then
            self.isValid = true
            return true
        end
    end

    self.isValid = false
    return false
end

Song.construct = function(self, directory, path)
    self.directory = directory
    self.path = path
    self.charts = {}

    local chartPaths = FileSystem.getFiles(self.path, ".osu")

    local chart = nil
    for k, v in pairs(chartPaths) do
        chart = Chart:new(nil, k, v)
        if chart.isValid then
            table.insert(self.charts, chart)
        end
    end

    if not checkValid(self) then
        return
    end

    self.chart = self.charts[1]
    self.name = self.chart.Metadata.Title
    self.audioPath = "resources/songs/" .. self.directory .. "/" .. self.charts[1].General.AudioFilename
    self.audio = love.audio.newSource(self.audioPath)
end

return Song