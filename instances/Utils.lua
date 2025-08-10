local Utils = Class:new()

Utils.printT = function(parentTable, path)
    local file
    if path then file = io.open(path, "w") end
    local tostring, next, rep, type, format, pairs, concat, print = tostring, next, string.rep, type, string.format, pairs, table.concat, print
    if type(parentTable) ~= "table" then
        if path then
            file:write(tostring(parentTable))
            file:close()
            return print("printT done")
        else
            return print(tostring(parentTable))
        end
    end
    local t, tTabs, tablesInTSize
    local tableStack = {{ 1, parentTable, 1 }}
    local tableStackSize = 1
    local toPrint = {}
    local toPrintSize = 0
    local tableHistory = { [tostring(parentTable)] = true }
    local tablesInT = {}
    while next(tableStack) ~= nil do
        t = tableStack[tableStackSize]
        tTabs = rep("  ", t[3] - 1)
        if type(t[1]) == "string" then t[1] = format("\"%s\"", t[1]) end
        toPrintSize = toPrintSize + 1
        toPrint[toPrintSize] = format("%s[%s] -- %s, depth: %d\n", tTabs, tostring(t[1]), tostring(t[2]), t[3])
        tTabs = tTabs .. "  "
        tablesInTSize = 0
        for key, value in pairs(t[2]) do
            if type(value) == "table" and tableHistory[tostring(value)] == nil then
                tablesInTSize = tablesInTSize + 1
                tablesInT[tablesInTSize] = { key, value, t[3] + 1 }
                tableHistory[tostring(value)] = true
            else
                if type(key) == "string" then key = format("\"%s\"", key) end
                if type(value) == "string" then value = format("\"%s\"", value) end
                toPrintSize = toPrintSize + 1
                toPrint[toPrintSize] = format("%s[%s] = %s\n", tTabs, tostring(key), tostring(value))
            end
        end
        tableStack[tableStackSize] = nil
        tableStackSize = tableStackSize - 1
        for i = tablesInTSize, 1, -1 do
            tableStackSize = tableStackSize + 1
            tableStack[tableStackSize] = tablesInT[i]
        end
    end
    if path then
        file:write(concat(toPrint))
        file:close()
        print("printT done")
    else
        print(concat(toPrint))
    end
end

toStart = 5
toEnd = 20
fromStart = 4
fromEnd = 19
printStyle = "code" -- simple, code
-- printPath = "D:\\Media\\Downloads\\automap.txt"
local config = {}

Utils.automapGen = function()
	local groups
	local average

	local toHalfUp
	local toHalfDown
	local toEven

	local fromHalfUp
	local fromHalfDown
	local fromQuartLeft
	local fromQuartRight
	local fromEven

	local remainder
	local remHalfUp
	local remHalfDown
	local remQuartUp
	local remQuartDown
	local remEven
	local remPos

	local changeGroup

    local start

    for to = toStart, toEnd do
        config[to] = {}
        for from = fromStart, math.min(to - 1, fromEnd) do
			config[to][from] = {}

			toEven = to % 2 == 0 and true or false
			toHalfUp = math.ceil(to / 2)
			toHalfDown = math.floor(to / 2)

			fromEven = from % 2 == 0 and true or false
			fromHalfUp = math.ceil(from / 2)
			fromHalfDown = math.floor(from / 2)
			fromQuartLeft = math.floor(from / 4)
			fromQuartRight = from - fromQuartLeft + 1

			groups = {}

			average = round(to / from)

			remainder = to - (average * from)
			if (not fromEven) or (fromEven and remainder % 2 == 1) then
				remainder = remainder - 1
			end
			if toEven and fromEven then
				remainder = remainder - 2
			end
			remPos = remainder > 0 and true or false
			remainder = math.abs(remainder)
			remEven = remainder % 2 == 0 and true or false
			remHalfUp = math.ceil(remainder / 2)
			remHalfDown = math.floor(remainder / 2)
			remQuartUp = math.ceil(remainder / 4)
			remQuartDown = math.floor(remainder / 4)

			average = average + 1
			changeGroup = average + 1

			for i = 1, from do
				groups[i] = average
			end

			if remainder ~= 0 then

				if not remPos then
					remainder = from - remainder
					remEven = remainder % 2 == 0 and true or false
					remHalfUp = math.ceil(remainder / 2)
					remHalfDown = math.floor(remainder / 2)
					remQuartUp = math.ceil(remainder / 4)
					remQuartDown = math.floor(remainder / 4)
				end

				if not fromEven and to <= 10 or to <= 8 then
					for i = 0, remHalfDown - 1 do
						groups[(fromEven and fromHalfUp or fromHalfUp - 1) - i] = changeGroup
					end

					for i = 0, remHalfDown - 1 do
						groups[(fromHalfUp + 1) + i] = changeGroup
					end
				else
					for i = 0, remHalfDown - 1 do
						groups[fromQuartLeft + remQuartUp - i] = changeGroup
					end

					for i = 0, remHalfDown - 1 do
						groups[fromQuartRight - remQuartUp + i] = changeGroup
					end
				end

				if not remEven then
					groups[fromHalfUp] = changeGroup
				end

				if not remPos then
					for i, ones in pairs(groups) do
						groups[i] = ones - 1
					end
				end
			end


			for row = 1, from do
                config[to][from][row] = {}

                for col = 1, to do
                    config[to][from][row][col] = 0
                end
			end

			start = 1
			for row = 1, fromHalfUp do
				for i = 1, groups[row] do
                    config[to][from][row][start + (i - 1)] = 1
				end
				
				start = start + (groups[row] - 1)
			end

			start = to
			for row = from, fromHalfUp + 1, -1 do
				for i = 1, groups[row] do
                    config[to][from][row][start - (i - 1)] = 1
				end
				
				start = start - (groups[row] - 1)
			end
        end
	end

	if printStyle == "simple" then
		printSimple()
	elseif printStyle == "code" then
		printCode()
	end
end


function round(x)
    return math.floor(x + 0.5)
end

function printSimple()
	local sum
    local s = {}
	for i = toStart, toEnd do
		for j = fromStart, math.min(i - 1, fromEnd) do
			s[#s+1] = ("\n[%d][%d]:\n"):format(i, j)
			for x = 1, j do
				for y = 1, i do
					s[#s+1] = config[i][j][x][y]
				end
				sum = math.ceil(j / 2)
				if x == sum or (j % 2 == 0 and x - 1 == sum) then
					s[#s+1] = "--\n"
				else
					s[#s+1] = "\n"
				end
			end
		end
	end

	if printPath then
		local file = io.open(printPath, "w")
		file:write(table.concat(s))
		file:close()
		print("done")
	else
		print(table.concat(s))
	end
end

function printCode()
    local s = {}
	for i = toStart, toEnd do
		s[#s+1] = ("config[%d] = {}\n\n"):format(i)
		for j = fromStart, math.min(i - 1, fromEnd) do
			s[#s+1] = ("config[%d][%d] = {"):format(i, j)
			for x = 1, j do
				s[#s+1] = "\n\t{"
				for y = 1, i do
					s[#s+1] = config[i][j][x][y] .. ","
				end
				s[#s+1] = "},"
			end
			s[#s+1] = "\n}\n\n"
		end
	end

	if printPath then
		local file = io.open(printPath, "w")
		file:write(table.concat(s))
		file:close()
		print("done")
	else
		print(table.concat(s))
	end
end

Utils.print2DArrayClockwise = function()
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

	local length = #arr[1]
	local height = #arr

	local result = {}
	local resLength = 0
	local resLengthGoal = length * height

	local direction = 0

	local right = length
	local bottom = height
	local left = 1
	local top = 1

	while resLength < resLengthGoal do
		if direction == 0 then
			for j = left, right do
				resLength = resLength + 1
				result[resLength] = arr[top][j]
			end
			top = top + 1
		elseif direction == 1 then
			for j = top, bottom do
				resLength = resLength + 1
				result[resLength] = arr[j][right]
			end
			right = right - 1
		elseif direction == 2 then
			for j = right, left, -1 do
				resLength = resLength + 1
				result[resLength] = arr[bottom][j]
			end
			bottom = bottom - 1
		else
			for j = bottom, top, -1 do
				resLength = resLength + 1
				result[resLength] = arr[j][left]
			end
			left = left + 1
		end

		direction = (direction + 1) % 4
	end

	print(table.concat(result, ", "))
end

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

return Utils