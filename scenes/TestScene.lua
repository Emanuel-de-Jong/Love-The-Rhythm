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
            s = s .. ("[%02d][%02d] "):format(i, j)
            for x = 1, j do
                for y = 1, i do
                    s = s .. config[i][j][x][y]
                end
                s = s .. "\n\t "
            end
            s = s .. "\n"
        end
    end
    print(s)
end

TestScene.load = function()
	local average
	local groups
	local remainder
	local changeGroup
	local remHalf
	local remQuart
	local posLeft
	local posRight
	local fromHalf

	local shift
    local rowT
    local start

    for to = 5, 10 do
        config[to] = {}

        for from = 4, to - 1 do
            config[to][from] = {}

			groups = {}

			average = round(to / from)

			remainder = to - (average * from)

			if remainder % 2 == 1 and from % 2 == 0 then
				remainder = remainder + 1
			end

			average = average + 1

			for i = 1, from do
				groups[i] = average
			end

			if remainder ~= 0 then
				if remainder > 0 then
					changeGroup = average + 1
				else
					changeGroup = average - 1
				end

				remainder = math.abs(remainder)
				remHalf = math.floor(remainder / 2)
				remQuart = math.floor(remainder / 4)
				posLeft = math.ceil(from / 4)
				posRight = from - posLeft + 1

				-- print("from: " .. from)
				-- print("remainder: " .. remainder)
				-- print("remHalf: " .. remHalf)
				-- print("remQuart: " .. remQuart)
				-- print("posLeft: " .. posLeft)
				-- print("posRight: " .. posRight)
				-- print()

				-- print("for loop 1")
				for i = 1, remHalf do
					-- print("   " .. posLeft - remQuart + (i - 1))
					groups[posLeft - remQuart + (i - 1)] = changeGroup
				end

				-- print("if statement")
				if remainder % 2 == 1 then
					-- print("   " .. math.ceil(#groups/2))
					groups[math.ceil(#groups/2)] = changeGroup
				end

				-- print("for loop 2")
				for i = 1, remHalf do
					-- print("  " .. posRight + remQuart - (i - 1))
					groups[posRight + remQuart - (i - 1)] = changeGroup
				end

				-- print()
			end

			-- for index, value in ipairs(groups) do
			-- 	print(("%02d = %d"):format(index, value))
			-- end

			-- print(("-"):rep(34))


			for row = 1, from do
                config[to][from][row] = {}
                rowT = config[to][from][row]

                for col = 1, to do
                    rowT[col] = 0
                end
			end

			
			fromHalf = math.ceil(from / 2)

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
			

            -- shift = round(to / from)

            -- for row = 1, from do
            --     config[to][from][row] = {}
            --     rowT = config[to][from][row]

            --     for col = 1, to do
            --         rowT[col] = 0
            --     end

            --     start = (row * shift) - shift
            --     for i = 1, groups[row] do
            --         if rowT[start + i] then
            --             rowT[start + i] = 1
            --         end
            --     end
            -- end
        end
    end

    printC(5, 10)
end

-- [x][x-1]: 2 per row, 1 row down
-- [x][x/2]: 2 per row, 2 row down
-- [e][e-2]: 2 per row, 1 row down, middle 2 row down
-- [o][o-2]: 2 per row, 1 row down, middle 3 per row

return TestScene