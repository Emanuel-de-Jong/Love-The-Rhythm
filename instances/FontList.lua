local FontList = Class:new()

local fonts = {}

FontList.set = function(filename, size)
	if not fonts[filename] then
		fonts[filename] = {}
	end

	if not fonts[filename][size] then
		local path = "resources/fonts/" .. filename
		fonts[filename][size] = love.graphics.newFont(path, size)
	end
end

FontList.get = function(filename, size)
	FontList.set(filename, size)
	
	return fonts[filename][size]
end

return FontList