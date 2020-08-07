--[[
testing stuff.
--]]

function getS(t)
	local c = 0
	for _, v in pairs(t) do
		c = c + 1
		if type(v) == "table" then c = c + getS(v) end
	end
	return c
end

tableStrings = {}
function getD(o, r)
	if not r then
		tableStrings = {}
		r = 0
	end
	if type(o) == "table" then
		local i = 0
		local e = 0
		for _ in pairs(o) do e = e + 1 end
		local s = "{ -- " .. tostring(o) .. "\n"
		for k, v in pairs(o) do
			if type(k) ~= "number" then k = '"'..k..'"' end
			if type(v) == "table" then
				local ts = tostring(v)
				if tableStrings[ts] then
					v = '"'..ts..'"'
				else
					tableStrings[ts] = true
					v = getD(v, r + 1)
				end
			else
				v = getD(v, r + 1)
			end
			s = s .. ("\t"):rep(r) .. "\t["..k.."] = " .. v
			i = i + 1
			if i ~= e then s = s .. "," end
			s = s .. "\n"
		end
		return s .. ("\t"):rep(r) .. "}"
	else
		return tostring(o)
	end
end

function printS(t)
	print(
		("-"):rep(50) ..
		"\nsize: " .. getS(t) ..
		"\n" .. ("-"):rep(50)
	)
end

function printD(t)
	print(
		("-"):rep(50) ..
		"\ndump: \n" ..
		getD(t) ..
		"\n" .. ("-"):rep(50)
	)
end

function printT(t)
	print(
		("-"):rep(50) ..
		"\nsize: " .. getS(t) ..
		"\n" .. ("-"):rep(50) ..
		"\ndump: \n" ..
		getD(t) ..
		"\n" .. ("-"):rep(50)
	)
end

local TestScene = Class:new()

TestScene.load = function()
	local arr = {
		-- 3x2
		-- {01,02,03},
		-- {06,05,04}

		-- 2x3
		-- {01,02},
		-- {06,03},
		-- {05,04}

		-- 3x3
		-- {01,02,03},
		-- {08,09,04},
		-- {07,06,05}

		-- 4x3
		-- {01,02,03,04},
		-- {10,11,12,05},
		-- {09,08,07,06}

		-- 3x4
		-- {01,02,03},
		-- {10,11,04},
		-- {09,12,05},
		-- {08,07,06}

		-- 4x4
		-- {01,02,03,04},
		-- {12,13,14,05},
		-- {11,16,15,06},
		-- {10,09,08,07}

		-- 5x4
		-- {01,02,03,04,05},
		-- {14,15,16,17,06},
		-- {13,20,19,18,07},
		-- {12,11,10,09,08}

		-- 4x5
		-- {01,02,03,04},
		-- {14,15,16,05},
		-- {13,20,17,06},
		-- {12,19,18,07},
		-- {11,10,09,08}

		-- 5x5
		{01,02,03,04,05},
		{16,17,18,19,06},
		{15,24,25,20,07},
		{14,23,22,21,08},
		{13,12,11,10,09}
	}

	local result = {}
	
	local length = #arr[1]
	local height = #arr

	local right = length
	local bottom = height
	local left = 1
	local top = 1

	while #result < length * height do
		-- to the right
		for j = left, right do
			result[#result + 1] = arr[top][j]
		end
		top = top + 1
		
		-- down
		for j = top, bottom do
			result[#result + 1] = arr[j][right]
		end
		right = right - 1

		-- to the left
		for j = right, left, -1 do
			result[#result + 1] = arr[bottom][j]
		end
		bottom = bottom - 1

		-- up
		for j = bottom, top, -1 do
			result[#result + 1] = arr[j][left]
		end
		left = left + 1
	end

	print(table.concat(result, ", "))
end

return TestScene