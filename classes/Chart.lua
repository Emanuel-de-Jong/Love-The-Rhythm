--[[
represents a single .osu file.
--]]

local Chart = Class:new()

-- decides how the data of the catrgory should be imported
local typePerCategory = {
    Format = "format",
    General = "kv1space",
    Editor = "kv1space",
    Metadata = "kv",
    Difficulty = "kv",
    Events = "csl",
    TimingPoints = "csl",
    Colours = "kv2space",
    HitObjects = "csl"
}

-- chart will be invalid if any of these values are missing
local requiredOptions = {
    General = {"AudioFilename", "PreviewTime", "Mode"},
    Editor = {},
    Metadata = {"Title", "Version"},
    Difficulty = {"CircleSize"}
}

local columnPerKeymode = {
    ["4"] = {["64"] = 1, ["192"] = 2, ["320"] = 3, ["448"] = 4}
}

local function syncWithFile(self)
    self.Format = nil
    self.General = {}
    self.Editor = {}
    self.Metadata = {}
    self.Difficulty = {}
    self.Events = {}
    self.TimingPoints = {}
    self.Colours = {}
    self.HitObjects = {}

    local category = "Format"
    local type = "format"
    local colonPos = nil

    for line in io.lines(self.path) do
        -- // is a comment
        if #line ~= 0 and line:sub(1, 2) ~= "//" then
             -- a new category always starts with [
            if line:sub(1, 1) == "[" then
                category = line:sub(2, #line - 1)
                type = typePerCategory[category]
            else
                if type == "format" then
                    self.Format = line:sub(#line - 1)
                elseif type == "kv" then
                    colonPos = line:find(":")
                    self[category][line:sub(1, colonPos - 1)] = line:sub(colonPos + 1)
                elseif type == "kv1space" then
                    colonPos = line:find(":")
                    self[category][line:sub(1, colonPos - 1)] = line:sub(colonPos + 2)
                elseif type == "kv2space" then
                    colonPos = line:find(":")
                    self[category][line:sub(1, colonPos - 2)] = line:sub(colonPos + 2)
                elseif type == "csl" then
                    table.insert(self[category], line)
                end
            end
        end
    end
end

-- goes through every requiredOptions to check if it exists
local function checkValid(self)
    for k, v in pairs(requiredOptions) do
        for i, o in ipairs(v) do
            if not self[k][o] then
                self.isValid = false
                return false
            end
        end
    end

    if self.General.Mode ~= "3" or self.Difficulty.CircleSize ~= "4" then 
        self.isValid = false
        return false
    end

    self.isValid = true
    return true
end

local function setHitObjects(self)
    local newHitObjects = {}
    local index = nil
    local keymode = self.Difficulty.CircleSize

    for i, v in ipairs(self.HitObjects) do
        newHitObjects[i] = {}
        index = 1

        for s in v:gmatch("([^,]+)") do
            if index == 1 then
                newHitObjects[i].column = columnPerKeymode[keymode][s]
            elseif index == 3 then
                newHitObjects[i].time = tonumber(s)
            end
            
            index = index + 1
        end
    end

    self.HitObjects = newHitObjects
end

Chart.construct = function(self, filename, path)
    self.filename = filename
    self.path = path

    syncWithFile(self)

    if not checkValid(self) then
        return
    end
    
    self.name = self.Metadata.Version

    setHitObjects(self)
end

return Chart