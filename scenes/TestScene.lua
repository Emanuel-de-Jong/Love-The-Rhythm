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
        for j = 1, i - 1 do
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
	local groups = {}
	local remainder
	local remOdd = false
	local fromOdd = false
	local changeGroup
	local remHalf
	local remQuart
	local pos

	local to = 15
	local from = 9

	average = round(to / from)

	for i = 1, from do
		groups[i] = average
	end

	remainder = to - (average * from)

	if remainder % 2 == 1 then
		remOdd = true
	end

	if from % 2 == 1 then
		fromOdd = true
	end

	if remOdd and not fromOdd then
		remainder = remainder + 1
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
		pos = math.ceil(from / 4)

		print("average: " .. average)
		print("remainder: " .. remainder)
		print("remOdd: " .. tostring(remOdd))
		print("fromOdd: " .. tostring(fromOdd))
		print("changeGroup: " .. changeGroup)
		print("remHalf: " .. remHalf)
		print("remQuart: " .. remQuart)
		print("pos: " .. pos)
		print("-------------------")

		for i = 1, remainder do
			print("i: " .. i)
			if i == remainder and fromOdd and remOdd then
				print("if: 1")
				print("index: " .. math.ceil(#groups/2))
				groups[math.ceil(#groups/2)] = changeGroup
			elseif i <= remHalf then
				print("if: 2")
				print("index: " .. pos - remQuart + (i - 1))
				groups[pos - remQuart + (i - 1)] = changeGroup
			else
				print("if: 3")
				print("index: " .. (pos * 3) + remQuart - (i - 1 - remHalf))
				groups[(pos * 3) + remQuart - (i - 1 - remHalf)] = changeGroup
			end
			print("-------------------")
		end
	end

	printD(groups)
end

-- TestScene.loada = function()
-- 	local groups
-- 	local average
-- 	local remainder
-- 	local pos
-- 	local shift

--     local rowT
--     local start

--     for to = 2, 20 do
--         config[to] = {}

--         for from = 1, to - 1 do
--             config[to][from] = {}

-- 			groups = {}
-- 			average = round(to / from)
-- 			remainder = to - (average * to)

-- 			for i = 1, from do
-- 				groups[i] = average
-- 			end

-- 			if remainder % 2 and not from % 2 then
-- 				remainder = remainder + 1
-- 			end

-- 			remainder = math.abs(remainder)

-- 			pos = round(from / remainder)
-- 			for i = 1, remainder do
-- 				groups[pos * i] = average + 1
-- 			end



--             shift = round(to / from)

--             for row = 1, from do
--                 config[to][from][row] = {}
--                 rowT = config[to][from][row]

--                 for col = 1, to do
--                     config[to][from][row][col] = 0
--                 end

--                 start = (row * shift) - (shift - 1)
--                 for i = 1, from do

--                     if rowT[i] then
--                         rowT[i] = 1
--                     end
--                 end
--             end
--         end
--     end

--     printC(10, 10)
-- end

-- [x][x-1]: 2 per row, 1 row down
-- [x][x/2]: 2 per row, 2 row down
-- [e][e-2]: 2 per row, 1 row down, middle 2 row down
-- [o][o-2]: 2 per row, 1 row down, middle 3 per row

return TestScene