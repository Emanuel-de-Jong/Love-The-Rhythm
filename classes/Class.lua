--[[
the base class. makes lua object oriented ish.
--]]

local Class = {}

-- metamethod that looks at every new index and calls it when the key is init
-- this makes it so a class will always call init when it is required for the first time
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
	
	if object.construct then
		object:construct(...)
	end
	
	return object
end

return Class
