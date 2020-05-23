local Song = require("classes/Song")
local ConfigManager = require("instances/ConfigManager")
local FileSystem = require("libraries/FileSystem")
local SongManager = Class:new()

SongManager.songs = {}
SongManager.song = nil

local setConfig = function()
    ConfigManager.set("SongManager", {song = SongManager.song.name})
end

local syncWithConfig = function()
    local data = ConfigManager.get("SongManager")

    if data then
        SongManager.setWithName(data.song)
    end
end

SongManager.set = function(song)
    SongManager.song = song
    setConfig()
end

SongManager.setWithName = function(name)
    for i, v in ipairs(SongManager.songs) do
        if v.name == name then
            SongManager.song = v
            setConfig()
            return
        end
    end
end

SongManager.setWithIndex = function(index)
    if SongManager.songs[index] then
        SongManager.song = SongManager.songs[index]
        setConfig()
    end
end

-- fills SongManager.songs with all valid songs and charts in the resources/songs dir
-- this program will only support osu mania songs
SongManager.init = function()
    local songPaths = FileSystem.getDirectories(FileSystem.rootPath .. "/resources/songs")

    local song = nil
    for k, v in pairs(songPaths) do
        song = Song:new(nil, v)
        if song.isValid then
            table.insert(SongManager.songs, song)
        end
    end

    syncWithConfig()
end

return SongManager