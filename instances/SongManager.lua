local Song = require("classes/Song")
local ConfigManager = require("instances/ConfigManager")
local FileSystem = require("libraries/FileSystem")
local SongManager = Class:new()

SongManager.songs = {}

SongManager.song = nil

local function setConfig()
    ConfigManager.set("SongManager", {song = SongManager.song.name})
end

local function getConfig()
    local data = ConfigManager.get("SongManager")

    if data then
        SongManager.changeByName(data["song"])
    end
end

SongManager.changeByName = function(name)
    for k, v in pairs(SongManager.songs) do
        if v.name == name then
            SongManager.song = v
        end
    end
    setConfig()
end

SongManager.changeByInstance = function(song)
    SongManager.song = song
    setConfig()
end

SongManager.changeByIndex = function(index)
    if SongManager.songs[index] then
        SongManager.song = SongManager.songs[index]
    end
    setConfig()
end

SongManager.init = function()
    local songPaths = FileSystem.getDirectories(FileSystem.rootPath .. "\\resources\\songs")

    for k, v in pairs(songPaths) do
        table.insert(SongManager.songs, Song:new(nil, v))
    end

    getConfig()
end

return SongManager