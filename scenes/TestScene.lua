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

function round(x)
    return math.floor(x + 0.5)
end

local TestScene = Class:new()

local config = {}

function printC(toStart, toEnd, fromStart, fromEnd, path)
    toStart = toStart or 5
    toEnd = toEnd or 20
    fromStart = fromStart or (toStart - 1)
    fromEnd = fromEnd or (toEnd - 1)
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

	if path then
		local file = io.open(path, "w")
		file:write(table.concat(s))
		file:close()
		print("done")
	else
		print(table.concat(s))
	end
end

TestScene.load = function()
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

    for to = 5, 88 do
        config[to] = {}
        for from = 4, to - 1 do
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
			
			-- local s = ("[%d][%d]:\n"):format(to, from)
			-- for row = 1, from do
			-- 	for col = 1, to do
			-- 		s = s .. config[to][from][row][col]
			-- 	end
			-- 	if (not fromEven and row == fromHalfUp) or (fromEven and (row == fromHalfUp or row == fromHalfUp + 1)) then
			-- 		s = s .. "--"
			-- 	end
			-- 	s = s .. "\n"
			-- end
			-- print(s)
        end
    end

    printC(5, 88, 4, 87)
    -- printC(5, 88, 4, 87, "D:\\Media\\Downloads\\automap.txt")
end

return TestScene