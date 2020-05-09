local FontList = Class:new()

FontList.instances = {}

local newFont = love.graphics.newFont
FontList.getFont = function(path, size)
	path = "resources/fonts/" .. path
	if not (FontList.instances[path] and FontList.instances[path][size]) then
		FontList.instances[path] = FontList.instances[path] or {}
		FontList.instances[path][size] = newFont(path, size)
	end
	return FontList.instances[path][size]
end

return FontList