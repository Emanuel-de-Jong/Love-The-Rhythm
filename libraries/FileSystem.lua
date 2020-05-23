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
    -- everything in the path
    local directory = io.popen('dir "'..path..'" /b')
    local pathsEmpty = true

    for filename in directory:lines() do
        pathsEmpty = false
        paths[filename] = path .. "/" .. filename
    end
    directory:close()

    if not pathsEmpty then
        return paths
    end
end

FileSystem.getDirectories = function(path)
    local paths = {}
    -- every directory in the path
    local directory = io.popen('dir "'..path..'" /b /ad')
    local pathsEmpty = true

    for filename in directory:lines() do
        pathsEmpty = false
        paths[filename] = path .. "/" .. filename
    end
    directory:close()

    if not pathsEmpty then
        return paths
    end
end

FileSystem.getFiles = function(path, extension)
    local paths = {}
    -- everything in the path
    local directory = io.popen('dir "'..path..'" /b')
    local pathsEmpty = true

    for filename in directory:lines() do
        -- checks if the file has the right extension
        -- or when no extension given, if it is not a directory (has a .)
        if (extension and filename:find(extension)) or (not extension and filename:find("%.")) then
            pathsEmpty = false
            paths[filename] = path .. "/" .. filename
        end
    end
    directory:close()
    
    if not pathsEmpty then
        return paths
    end
end

FileSystem.getFile = function(path, extension, name)
    if name and extension then
        local filename = name .. extension
        for k, v in pairs(FileSystem.getFiles(path, extension)) do
            if k == filename then
                return {[k] = v}
            end
        end
    elseif name then
        for k, v in pairs(FileSystem.getFiles(path)) do
            if FileSystem.getFilenameWithoutExtension(k) == name then
                return {[k] = v}
            end
        end
    elseif extension then
        for k, v in pairs(FileSystem.getFiles(path, extension)) do
            return {[k] = v}
        end
    end
end

FileSystem.getFilenameWithoutExtension = function(filename)
    local extensionStart = filename:find("%.[^%.]*$")

    if extensionStart then
        return filename:sub(1, extensionStart - 1)
    else
        return filename
    end
end

return FileSystem