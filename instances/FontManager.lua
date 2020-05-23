local FontManager = Class:new()

local fonts = {}

-- makes a new [font][size] index with a love newFont value if the index doesn't exist
FontManager.set = function(filename, size)
	if not fonts[filename] then
		fonts[filename] = {}
	end

	if not fonts[filename][size] then
		local path = "resources/fonts/" .. filename
		fonts[filename][size] = love.graphics.newFont(path, size)
	end
end

FontManager.get = function(filename, size)
	FontManager.set(filename, size)
	
	return fonts[filename][size]
end

return FontManager