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
		{01,02,03,04},
		{12,13,14,05},
		{11,16,15,06},
		{10,09,08,07}

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
		-- {01,02,03,04,05},
		-- {16,17,18,19,06},
		-- {15,24,25,20,07},
		-- {14,23,22,21,08},
		-- {13,12,11,10,09}
	}

	local length = #arr[0]
	local height = #arr
	local direction = "R"
	local result = {}
	local row = 1
	local col = 1
	local val

	while #result < length * height do
		val = 1

		print(
			"direction: " .. direction ..
			"\nrow: " .. row ..
			"\ncol: " .. col
		)

		if direction == "R" then
			for j = 1, length - col do
				print(("[%d02][%d02]"):format(row, j + math.floor(col/2)))
				-- val = arr[row][j + math.floor(col/2)]
				result[#result + 1] = val
			end

			row = row + 1
			direction = "D"
		elseif direction == "L" then
			for j = length, col, -1 do
				print(("[%d02][%d02]"):format(row, j - math.floor(col/2)))
				-- val = arr[row][j - math.floor(col/2)]
				result[#result + 1] = val
			end

			row = row + 1
			direction = "U"
		elseif direction == "D" then
			for j = 1, height - row do
				print(("[%d02][%d02]"):format(j + math.floor(row/2), col))
				-- val = arr[j + math.floor(row/2)][col]
				result[#result + 1] = val
			end

			col = col + 1
			direction = "L"
		else
			for j = height, row, -1 do
				print(("[%d02][%d02]"):format(j - math.floor(row/2), col))
				-- val = arr[j - math.floor(row/2)][col]
				result[#result + 1] = val
			end

			col = col + 1
			direction = "R"
		end

		print(("-"):rep(32))
	end


	print(table.concat(result, ", "))
end

return TestScene