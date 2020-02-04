path_prefix = ".."
sep = package.path:find("\\") and "\\" or "/"
package.path = package.path .. ";" .. path_prefix .. sep .. "arg-handler" .. sep .. "?.lua;" .. path_prefix .. sep .. "sorting" .. sep .. "?.lua"

lfs = require("lfs")
require("shell-sort")
math.randomseed(os.time())
math.random()
math.random()

for j = 1, 6 do
	letter = arg[1] .. string.char(96+j)
	target = letter .. 1
	lfs.mkdir(target)
	lfs.mkdir(letter .. 2)

	for i = 1, 25 do
		local amount = math.random(3,10)
		local name = ""
		for k = 1, amount do
			local set = math.random(1,3)

			if set == 1 then name = name .. string.char(math.random(65, 90))
			elseif set == 2 then name = name .. string.char(math.random(97, 122))
			else name = name .. string.char(math.random(48, 57))
			end
		end

		io.open(target .. sep .. name .. ".txt", "w"):close()
	end

	file_list = {}
	i = 0
	for file in lfs.dir(target) do
		if lfs.attributes(target..sep..file).mode ~= "directory" then
			file_list[i] = file
			i = i + 1
		end
	end

	sort(file_list)

	for i, name in pairs(file_list) do
		local file = io.open(target..sep..name, "w+")
		file:write(i)
		file:close()
	end
end

--numbers: 65-90  lower case: 97-122  upper case:48-57
