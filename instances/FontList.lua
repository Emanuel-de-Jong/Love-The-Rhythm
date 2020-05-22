local FontList = Class:new()

FontList.fonts = {}

local newFont = love.graphics.newFont

FontList.set = function(path, size)
	path = "resources/fonts/" .. path

	if not FontList.fonts[path] then
		FontList.fonts[path] = {}
	end

	if not FontList.fonts[path][size] then
		FontList.fonts[path][size] = newFont(path, size)
	end
end

FontList.get = function(path, size)
	FontList.set(path, size)
	
	return FontList.fonts[path][size]
end

return FontList