local Song = require("classes/Song")
local ConfigManager = require("instances/ConfigManager")
local FileSystem = require("libraries/FileSystem")
local SongManager = Class:new()

SongManager.songs = {}

SongManager.song = nil

SongManager.setConfig = function()
    ConfigManager.set("SongManager", {song = SongManager.song.name})
end

SongManager.syncWithConfig = function()
    local data = ConfigManager.get("SongManager")

    if data then
        SongManager.setWithName(data.song)
    end
end

SongManager.set = function(songs)
    SongManager.songs = songs
end

SongManager.setWithName = function(name)
    for i, v in ipairs(SongManager.songs) do
        if v.name == name then
            SongManager.song = v
        end
    end
    SongManager.setConfig()
end

SongManager.setWithInstance = function(song)
    SongManager.song = song
    SongManager.setConfig()
end

SongManager.setWithIndex = function(index)
    if SongManager.songs[index] then
        SongManager.song = SongManager.songs[index]
    end
    SongManager.setConfig()
end

SongManager.get = function()
    return SongManager.songs
end

SongManager.init = function()
    local songPaths = FileSystem.getDirectories(FileSystem.rootPath .. "\\resources\\songs")

    for k, v in pairs(songPaths) do
        table.insert(SongManager.songs, Song:new(nil, v))
    end

    SongManager.syncWithConfig()
end

return SongManager