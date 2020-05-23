--[[
represents a single .osu file.
--]]

local Chart = Class:new()

-- decides how the data of the catrgory should be imported
local typePerCategory = {
    Format = "format",
    General = "setting",
    Editor = "setting",
    Metadata = "setting",
    Difficulty = "setting",
    Events = "event",
    TimingPoints = "event",
    HitObjects = "event"
}

-- chart will be invalid if any of these values are missing
local requiredOptions = {
    General = {"AudioFilename", "PreviewTime", "Mode"},
    Editor = {},
    Metadata = {"Title", "Version"},
    Difficulty = {},
    Events = {}
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
                elseif type == "setting" then
                    colonPos = line:find(":")
                    -- key is before the colon, value after. the gsub removes spaces before and after the value
                    self[category][line:sub(1, colonPos - 1)] = line:sub(colonPos + 1):gsub("^%s*(.-)%s*$", "%1")
                elseif type == "event" then
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

    self.isValid = true
    return true
end

local function setHitObjects(self)
    local newHitObjects = {}
    local index = nil
    local keymode = self.Difficulty.CircleSize

    if keymode ~= "4" then
        self.isValid = false
        return 
    end

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