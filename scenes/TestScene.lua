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
		for j = from - 1 or 1, i - 1 do
			s = s .. ("config[%d][%d] = {"):format(i, j)
			for x = 1, j do
				s = s .. "\n\t{"
				for y = 1, i do
					s = s .. config[i][j][x][y] .. ","
				end
				
				-- if (j%2==1 and x == math.ceil(j/2)) or (j%2==0 and (x==j/2 or x==(j/2)+1)) then
				-- 	s = s .. "--"
				-- end

				s = s .. "},"
			end
			s = s .. "\n}\n\n"
		end
    end
    print(s)
end

TestScene.loada = function()
	local average
	local groups
	local remainder
	local remHalf
	local remQuart
	local posLeft
	local posRight
	local fromHalf
	local remNegative
	local changeGroup

	local shift
    local rowT
    local start

	local to = 10
	local from = 5

	config[to] = {}
	config[to][from] = {}

	groups = {}

	average = round(to / from)
	print("average: " .. average)

	remainder = to - (average * from)
	print("remainder: " .. remainder)
	print()

	if (from % 2 == 1) or (remainder % 2 == 1 and from % 2 == 0) then
		print("if: true")
		remainder = remainder - 1
		print("remainder: " .. remainder)
	end

	average = average + 1
	print("average: " .. average)

	for i = 1, from do
		groups[i] = average
	end
	printD(groups)

	fromHalf = math.ceil(from / 2)
	print("fromHalf: " .. fromHalf)

	if remainder ~= 0 then
		remNegative = remainder < 0 and true or false
		print("remNegative: " .. tostring(remNegative))
		remainder = math.abs(remainder)
		print("remainder: " .. remainder)

		if remNegative then
			print("if: true")
			remainder = from - remainder
			print("remainder: " .. remainder)
		end
		print()

		changeGroup = average + 1
		remHalf = math.floor(remainder / 2)
		if remHalf == math.floor(from / 2) then
			for i, ones in pairs(groups) do
				if i ~= fromHalf or remainder % 2 == 1 then
					print("i: " .. i)
					groups[i] = changeGroup
					print("value: " .. groups[i])
				end
			end
			print()
		else
			print("remHalf: " .. remHalf)
			remQuart = math.floor(remainder / 4)
			print("remQuart: " .. remQuart)
			posLeft = math.ceil(from / 4)
			print("posLeft: " .. posLeft)
			posRight = from - posLeft + 1
			print("posRight: " .. posRight)
			print()

			for i = 1, remHalf do
				print("i: " .. i)
				print("index: " .. posLeft + remQuart - (i - 1))
				groups[posLeft + remQuart - (i - 1)] = changeGroup
				print("value: " .. groups[posLeft + remQuart - (i - 1)])
			end
			print()

			if remainder % 2 == 1 then
				print("index: " .. fromHalf)
				groups[fromHalf] = changeGroup
				print("value: " .. groups[fromHalf])
			end
			print()

			for i = 1, remHalf do
				print("i: " .. i)
				print("index: " .. posRight - remQuart + (i - 1))
				groups[posRight - remQuart + (i - 1)] = changeGroup
				print("value: " .. groups[posRight - remQuart + (i - 1)])
			end
			print()
		end

		if remNegative then
			print("if: true")
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
	for row = 1, fromHalf do
		rowT = config[to][from][row]

		for i = 1, groups[row] do
			rowT[start + (i - 1)] = 1
		end
		start = start + (groups[row] - 1)
	end

	start = to
	for row = from, fromHalf + 1, -1 do
		rowT = config[to][from][row]

		for i = 1, groups[row] do
			rowT[start - (i - 1)] = 1
		end
		start = start - (groups[row] - 1)
	end

	local s = ""
	for row = 1, from do
		for col = 1, to do
			s = s .. config[to][from][row][col]
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

    local rowT
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
			if (not fromEven) or (not remEven and fromEven) then
				remainder = remainder - 1
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

				if remHalfDown == fromHalfDown then
					for i, ones in pairs(groups) do
						if i ~= fromHalfUp or not remEven then
							groups[i] = changeGroup
						end
					end
				else
					for i = 1, remHalfDown do
						groups[fromQuartLeft + remQuartUp - (i - 1)] = changeGroup
					end

					if not remEven then
						groups[fromHalfUp] = changeGroup
					end

					for i = 1, remHalfDown do
						groups[fromQuartRight - remQuartUp + (i - 1)] = changeGroup
					end
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
				rowT = config[to][from][row]

				for i = 1, groups[row] do
                    rowT[start + (i - 1)] = 1
                end
				start = start + (groups[row] - 1)
			end

			start = to
			for row = from, fromHalfUp + 1, -1 do
				rowT = config[to][from][row]

				for i = 1, groups[row] do
                    rowT[start - (i - 1)] = 1
                end
				start = start - (groups[row] - 1)
			end
			

            -- for row = 1, from do
            --     for i = 1, groups[row] do
            --         config[to][from][row][i] = 1
            --     end
            -- end
        end
    end

    printC(5, 20)
end

-- [x][x-1]: 2 per row, 1 row down
-- [x][x/2]: 2 per row, 2 row down
-- [e][e-2]: 2 per row, 1 row down, middle 2 row down
-- [o][o-2]: 2 per row, 1 row down, middle 3 per row

return TestScene