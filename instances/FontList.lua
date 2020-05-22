local FontList = Class:new()

FontList.fonts = {}

FontList.set = function(filename, size)
	if not FontList.fonts[filename] then
		FontList.fonts[filename] = {}
	end

	if not FontList.fonts[filename][size] then
		local path = "resources/fonts/" .. filename
		FontList.fonts[filename][size] = love.graphics.newFont(path, size)
	end
end

FontList.get = function(filename, size)
	FontList.set(filename, size)
	
	return FontList.fonts[filename][size]
end

return FontList