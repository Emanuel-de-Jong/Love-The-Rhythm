local Chart = require("classes/Chart")
local Song = Class:new()

Song.path = ""
Song.name = ""
Song.charts = {}

function dirtree(dir)
    assert(dir and dir ~= "", "Please pass directory parameter")
    if string.sub(dir, -1) == "/" then
        dir=string.sub(dir, 1, -2)
    end

    local function yieldtree(dir)
        for entry in lfs.dir(dir) do
            if entry ~= "." and entry ~= ".." then
                entry=dir.."/"..entry
                local attr=lfs.attributes(entry)
                coroutine.yield(entry,attr)
                if attr.mode == "directory" then
                    yieldtree(entry)
                end
            end
        end
    end

    return coroutine.wrap(function() yieldtree(dir) end)
end

Song.construct = function(self, path)
    Song.path = path
    self.load()
end

Song.load = function(self)
    for filename, attr in dirtree("D:\\Programming\\Repos\\Learning-Love\\resources\\songs") do
        print(attr.mode, filename)
    end 
end

return Song