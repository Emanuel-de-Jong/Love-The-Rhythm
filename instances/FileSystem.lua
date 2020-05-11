local FileSystem = Class:new()

FileSystem.getAll = function(path)
    local paths = {}
    local directory = io.popen('dir "'..path..'" /b')
    for filename in directory:lines() do
        paths[filename] = path .. "\\" .. filename
    end
    directory:close()
    return paths
end

FileSystem.getDirectories = function(path)
    local paths = {}
    local directory = io.popen('dir "'..path..'" /b /ad')
    for filename in directory:lines() do
        paths[filename] = path .. "\\" .. filename
    end
    directory:close()
    return paths
end

FileSystem.getFiles = function(path, extension)
    local paths = {}
    local directory = io.popen('dir "'..path..'" /b')
    for filename in directory:lines() do
        if (extension and string.find(filename, extension)) or (not extension and string.find(filename, "%.")) then
            paths[filename] = path .. "\\" .. filename
        end
    end
    directory:close()
    return paths
end

return FileSystem