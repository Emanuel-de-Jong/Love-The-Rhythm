local Chart = Class:new()

local typePerCategory = {
    Format = "format",
    General = "setting",
    Editor = "setting",
    Metadata = "setting",
    Difficulty = "setting",
    Events = "event",
    TimingPoints = "event",
    HitObjects = "event",
}

Chart.construct = function(self, name, path)
    self.name = name
    self.path = path

    self.Format = ""
    self.General = {}
    self.Editor = {}
    self.Metadata = {}
    self.Difficulty = {}
    self.Events = {}
    self.TimingPoints = {}
    self.HitObjects = {}

    self:load()
end

Chart.load = function(self)
    self:getFileInfo()
end

Chart.getFileInfo = function(self)
    local category = "Format"
    local type = "format"
    local colonPos = 0
    for line in io.lines(self.path) do
        if #line ~= 0 and string.sub(line, 1, 2) ~= "//" then
            if string.sub(line, 1, 1) == "[" then
                category = string.sub(line, 2, #line - 1)
                type = typePerCategory[category]
            else
                if type == "format" then
                    self.Format = string.sub(line, #line - 1)
                elseif type == "setting" then
                    colonPos = string.find(line, ":")
                    self[category][string.sub(line, 1, colonPos - 1)] = string.sub(line, colonPos + 1)
                elseif type == "event" then
                    table.insert(self[category], line)
                end
            end
        end
    end
end

return Chart