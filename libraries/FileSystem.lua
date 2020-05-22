local FileSystem = Class:new()

FileSystem.rootPath = love.filesystem.getWorkingDirectory()

FileSystem.checkFileExists = function(path)
    local file = io.open(path, "r")

    if file then
        io.close(file)
        return true
    else
        return false
    end
end

FileSystem.checkFileEmpty = function(path)
    local file = io.open(path, "r")

    if file then
        local content = file:read("*a")

        io.close(file)
        if content ~= "" then
            return false
        end
    end

    return true
end

FileSystem.getAll = function(path)
    local paths = {}
    local directory = io.popen('dir "'..path..'" /b')
    local pathsEmpty = true

    for filename in directory:lines() do
        pathsEmpty = false
        paths[filename] = path .. "\\" .. filename
    end
    directory:close()

    if pathsEmpty then
        return nil
    else
        return paths
    end
end

FileSystem.getDirectories = function(path)
    local paths = {}
    local directory = io.popen('dir "'..path..'" /b /ad')
    local pathsEmpty = true

    for filename in directory:lines() do
        pathsEmpty = false
        paths[filename] = path .. "\\" .. filename
    end
    directory:close()

    if pathsEmpty then
        return nil
    else
        return paths
    end
end

FileSystem.getFiles = function(path, extension)
    local paths = {}
    local directory = io.popen('dir "'..path..'" /b')
    local pathsEmpty = true

    for filename in directory:lines() do
        if (extension and string.find(filename, extension)) or (not extension and string.find(filename, "%.")) then
            pathsEmpty = false
            paths[filename] = path .. "\\" .. filename
        end
    end
    directory:close()
    
    if pathsEmpty then
        return nil
    else
        return paths
    end
end

FileSystem.getFile = function(path, extension, name)
    local path = {}
    local pathEmpty = true

    if name and extension then
        local filename = name .. extension
        for k, v in pairs(FileSystem.getFiles(path, extension)) do
            if k == filename then
                pathEmpty = false
                path[k] = v
                break;
            end
        end
    elseif name then
        for k, v in pairs(FileSystem.getFiles(path)) do
            if FileSystem.getFilenameWithoutExtension(k) == name then
                pathEmpty = false
                path[k] = v
                break;
            end
        end
    elseif extension then
        for k, v in pairs(FileSystem.getFiles(path, extension)) do
            pathEmpty = false
            path[k] = v
            break;
        end
    end

    if pathEmpty then
        return nil
    else
        return path
    end
end

FileSystem.getFilenameWithoutExtension = function(filename)
    local extensionStart = string.find(filename, "%.[^%.]*$")

    if extensionStart then
        return string.sub(filename, 1, extensionStart - 1)
    else
        return filename
    end
end

return FileSystem