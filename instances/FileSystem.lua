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

FileSystem.findFile = function(path, extension, name)
    local path = {}
    local paths = FileSystem.getFiles(path, extension)
    if name then
        local filename = name .. extension

        for k, v in pairs(paths) do
            if k == filename then
                path[k] = v
                break;
            end
        end
    else
        for k, v in pairs(paths) do
            path[k] = v
            break;
        end
    end
    return path
end

FileSystem.checkFileExists = function(path)
    local file = io.open(path, "r")
    if file ~= nil then
        io.close(file)
        return true
    else
        return false
    end
end

FileSystem.checkFileEmpty = function(path)
    local file = io.open(path, "r")
    if file ~= nil then
        local content = file:read("*a")
        io.close(file)
        if content ~= "" then
            return true
        end
    end
    return false
end

FileSystem.createFile = function(path, name, extension)
    local filePath = path .. "\\" .. name .. "." .. extension
    io.open(filePath, "w"):close()
    return filePath
end

return FileSystem