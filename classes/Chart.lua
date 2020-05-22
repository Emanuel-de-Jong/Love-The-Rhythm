local Chart = Class:new()

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

local requiredOptions = {
    General = {"AudioFilename", "PreviewTime", "Mode"},
    Editor = {},
    Metadata = {"Title", "Version"},
    Difficulty = {},
    Events = {}
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
        if #line ~= 0 and line:sub(1, 2) ~= "//" then
            if line:sub(1, 1) == "[" then
                category = line:sub(2, #line - 1)
                type = typePerCategory[category]
            else
                if type == "format" then
                    self.Format = line:sub(#line - 1)
                elseif type == "setting" then
                    colonPos = line:find(":")
                    self[category][line:sub(1, colonPos - 1)] = line:sub(colonPos + 1):gsub("^%s*(.-)%s*$", "%1")
                elseif type == "event" then
                    table.insert(self[category], line)
                end
            end
        end
    end
end

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

Chart.construct = function(self, path)
    self.path = path

    syncWithFile(self)

    if checkValid(self) then
        self.name = self.Metadata.Version
    end
end

return Chart