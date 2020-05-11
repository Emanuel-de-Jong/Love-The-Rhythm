local Chart = Class:new()

Chart.path = ""
Chart.name = ""

Chart.construct = function(self, name, path)
    self.name = name
    self.path = path
    self:load()
end

Chart.load = function(self)
end

return Chart