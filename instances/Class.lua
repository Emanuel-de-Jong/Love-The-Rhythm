local Class = {}

Class.__newindex = function(t, key, value)
	rawset(t, key, value)
	if key == "init" then
		t.init()
	end
end

Class.new = function(self, object, ...)
	local object = object or {}
	
	setmetatable(object, self)
	self.__index = self
	self.__newindex = Class.__newindex
	
	if object["construct"] then
		object:construct(...)
	end
	
	return object
end

return Class
