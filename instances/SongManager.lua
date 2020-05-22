local Song = require("classes/Song")
local ConfigManager = require("instances/ConfigManager")
local FileSystem = require("libraries/FileSystem")
local SongManager = Class:new()

SongManager.songs = {}

SongManager.song = nil

local function saveConfig()
    ConfigManager.save("SongManager", {song = SongManager.song.name})
end

local function loadConfig()
    local data = ConfigManager.load("SongManager")
    if data ~= nil then
        SongManager.changeByName(data["song"])
    end
end

SongManager.changeByName = function(name)
    for k, v in pairs(SongManager.songs) do
        if v.name == name then
            SongManager.song = v
        end
    end
    saveConfig()
end

SongManager.changeByInstance = function(song)
    SongManager.song = song
    saveConfig()
end

SongManager.changeByIndex = function(index)
    SongManager.song = SongManager.songs[index]
    saveConfig()
end

SongManager.init = function()
    local songPaths = FileSystem.getDirectories(FileSystem.rootPath .. "\\resources\\songs")

    for k, v in pairs(songPaths) do
        table.insert(SongManager.songs, Song:new(nil, v))
    end

    loadConfig()
end

return SongManager