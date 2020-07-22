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

function printC(from, to)
    local s = ""
	for i = from or 2, to or 20 do
		s = s .. ("config[%d] = {}\n\n"):format(i)
		for j = from - 1 or 1, i - 1 do
			s = s .. ("config[%d][%d] = {"):format(i, j)
			for x = 1, j do
				s = s .. "\n\t{"
				for y = 1, i do
					s = s .. config[i][j][x][y] .. ","
				end

				s = s .. "},"
			end
			s = s .. "\n}\n\n"
		end
    end
    print(s)
end

TestScene.loada = function()
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

	local to = 9
	local from = 4

	config[to] = {}
	config[to][from] = {}

	toHalfUp = math.ceil(to / 2)
	toHalfDown = math.floor(to / 2)
	toEven = to % 2 == 0 and true or false
	print(("to: %d   toHalfUp: %d   toHalfDown: %d   toEven: %s"):format(to, toHalfUp, toHalfDown, toEven))
	print()

	fromHalfUp = math.ceil(from / 2)
	fromHalfDown = math.floor(from / 2)
	fromQuartLeft = math.ceil(from / 4)
	fromQuartRight = from - fromQuartLeft + 1
	fromEven = from % 2 == 0 and true or false
	print(("from: %d   fromHalfUp: %d   fromHalfDown: %d   fromQuartLeft: %d   fromQuartRight: %d   fromEven: %s"):format(from, fromHalfUp, fromHalfDown, fromQuartLeft, fromQuartRight, fromEven))
	print()

	groups = {}

	average = round(to / from)
	print("average: " .. average)
	print()

	remainder = to - (average * from)
	print("remainder: " .. remainder)
	if (not fromEven) or (fromEven and remainder % 2 == 1) then
		print("remainder if 1")
		remainder = remainder - 1
		print("remainder: " .. remainder)
	end
	if toEven and fromEven then
		print("remainder if 2")
		remainder = remainder - 2
		print("remainder: " .. remainder)
	end
	remPos = remainder > 0 and true or false
	remainder = math.abs(remainder)
	remHalfUp = math.ceil(remainder / 2)
	remHalfDown = math.floor(remainder / 2)
	remQuartUp = math.ceil(remainder / 4)
	remQuartDown = math.floor(remainder / 4)
	remEven = remainder % 2 == 0 and true or false
	print(("remainder: %d   remPos: %s   remHalfUp: %d   remHalfDown: %d   remQuartUp: %d   remQuartDown: %d   remEven: %s"):format(remainder, remPos, remHalfUp, remHalfDown, remQuartUp, remQuartDown, remEven))
	print()

	average = average + 1
	print("average: " .. average)
	changeGroup = average + 1
	print("changeGroup: " .. changeGroup)
	print()

	for i = 1, from do
		groups[i] = average
	end
	printD(groups)
	print()

	if remainder ~= 0 then
		print("remainder 0 if")
		print()

		if not remPos then
			print("remainder negative if 1")
			remainder = from - remainder
			remHalfUp = math.ceil(remainder / 2)
			remHalfDown = math.floor(remainder / 2)
			remQuartUp = math.ceil(remainder / 4)
			remQuartDown = math.floor(remainder / 4)
			remEven = remainder % 2 == 0 and true or false
			print(("remainder: %d   remHalfUp: %d   remHalfDown: %d   remQuartUp: %d   remQuartDown: %d   remEven: %s"):format(remainder, remHalfUp, remHalfDown, remQuartUp, remQuartDown, remEven))
			print()
		end

		-- if remHalfDown == fromHalfDown then
		-- 	for i, ones in pairs(groups) do
		-- 		if i ~= fromHalfUp or not remEven then
		-- 			groups[i] = changeGroup
		-- 		end
		-- 	end
		if to < 9 then
			print("to < 9 if")

			print("for 1")
			for i = 0, remHalfDown - 1 do
				print("i: " .. i)
				print("index: " .. (fromEven and fromHalfUp or fromHalfUp - 1) - i)
				groups[(fromEven and fromHalfUp or fromHalfUp - 1) - i] = changeGroup
			end
			print()

			print("for 1")
			for i = 0, remHalfDown - 1 do
				print("i: " .. i)
				print("index: " .. (fromHalfUp + 1) + i)
				groups[(fromHalfUp + 1) + i] = changeGroup
			end
		else
			print("to < 9 else")

			print("for 1")
			for i = 0, remHalfDown - 1 do
				print("i: " .. i)
				print("index: " .. fromQuartLeft + remQuartDown - i)
				groups[fromQuartLeft + remQuartDown - i] = changeGroup
			end
			print()

			print("for 2")
			for i = 0, remHalfDown - 1 do
				print("i: " .. i)
				print("index: " .. fromQuartRight - remQuartDown + i)
				groups[fromQuartRight - remQuartDown + i] = changeGroup
			end
		end
		print()

		if not remEven then
			print("remainder odd if")
			print("index: " .. fromHalfUp)
			groups[fromHalfUp] = changeGroup
			print()
		end

		if not remPos then
			print("remainder negative if 2")
			for i, ones in pairs(groups) do
				groups[i] = ones - 1
			end
			printD(groups)
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

	local s = ("[%d][%d]:\n"):format(to, from)
	for row = 1, from do
		for col = 1, to do
			s = s .. config[to][from][row][col]
		end
		if (not fromEven and row == fromHalfUp) or (fromEven and (row == fromHalfUp or row == fromHalfUp + 1)) then
			s = s .. "--"
		end
		s = s .. "\n"
	end
	print(s)
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

    for to = 5, 20 do
        config[to] = {}

        for from = 4, to - 1 do
			config[to][from] = {}

			toHalfUp = math.ceil(to / 2)
			toHalfDown = math.floor(to / 2)
			toEven = to % 2 == 0 and true or false

			fromHalfUp = math.ceil(from / 2)
			fromHalfDown = math.floor(from / 2)
			fromQuartLeft = math.ceil(from / 4)
			fromQuartRight = from - fromQuartLeft + 1
			fromEven = from % 2 == 0 and true or false

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
			remHalfUp = math.ceil(remainder / 2)
			remHalfDown = math.floor(remainder / 2)
			remQuartUp = math.ceil(remainder / 4)
			remQuartDown = math.floor(remainder / 4)
			remEven = remainder % 2 == 0 and true or false

			average = average + 1
			changeGroup = average + 1

			for i = 1, from do
				groups[i] = average
			end

			if remainder ~= 0 then

				if not remPos then
					remainder = from - remainder
					remHalfUp = math.ceil(remainder / 2)
					remHalfDown = math.floor(remainder / 2)
					remQuartUp = math.ceil(remainder / 4)
					remQuartDown = math.floor(remainder / 4)
					remEven = remainder % 2 == 0 and true or false
				end

				-- if remHalfDown == fromHalfDown then
				-- 	for i, ones in pairs(groups) do
				-- 		if i ~= fromHalfUp or not remEven then
				-- 			groups[i] = changeGroup
				-- 		end
				-- 	end
				if to < 9 then
					for i = 0, remHalfDown - 1 do
						groups[(fromEven and fromHalfUp or fromHalfUp - 1) - i] = changeGroup
					end

					for i = 0, remHalfDown - 1 do
						groups[(fromHalfUp + 1) + i] = changeGroup
					end
				else
					for i = 0, remHalfDown - 1 do
						groups[fromQuartLeft + remQuartDown - i] = changeGroup
					end

					for i = 0, remHalfDown - 1 do
						groups[fromQuartRight - remQuartDown + i] = changeGroup
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
			
			local s = ("[%d][%d]:\n"):format(to, from)
			for row = 1, from do
				for col = 1, to do
					s = s .. config[to][from][row][col]
				end
				if (not fromEven and row == fromHalfUp) or (fromEven and (row == fromHalfUp or row == fromHalfUp + 1)) then
					s = s .. "--"
				end
				s = s .. "\n"
			end
			print(s)

            -- for row = 1, from do
            --     for i = 1, groups[row] do
            --         config[to][from][row][i] = 1
            --     end
            -- end
        end
    end

    -- printC(5, 20)
end

-- [x][x-1]: 2 per row, 1 row down
-- [x][x/2]: 2 per row, 2 row down
-- [e][e-2]: 2 per row, 1 row down, middle 2 row down
-- [o][o-2]: 2 per row, 1 row down, middle 3 per row

return TestScene