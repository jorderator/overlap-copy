#!/usr/bin/lua

---- Initialising:
-- Import libraries and prepare constants
sep = package.path:find("\\") and "\\" or "/"
package.path = package.path .. ";." .. sep .. "arg-handler" .. sep .. "?.lua;." .. sep .. "sorting" .. sep .. "?.lua"

lfs = require("lfs") -- 'luafilesystem' module, from luarocks
require("shell-sort")
require("arg-handler")
zero_amount = 6
count_start = 0
command = "mv -n \""
help_file = "help-text.txt"

-- Specify and process commandline options
options = {
	help = "h",
	verbose = "v", -- to implement
	quiet = "q",
	directory = "d",
	force = "f", -- to implement
	test = "t"
}
options = process_args(arg, options, help_file)

-- Print help message
if options["help"] or options["help-text"] then
	print(options["help-text"])
	os.exit()
end

-- Read arguments and initialise list
source_directory = options[1]
target_directory = (options["directory"] and options[1] or options[2])
file_list = {}

-- Function for taking an entry in the sorted list, and producing
--  a source and target argument to be used with the desired command
function pathify(number, name)
	local number = tostring(number+1)

	local source = source_directory .. (source_directory:sub(-1) == sep and "" or sep) .. name

	local target = target_directory .. (target_directory:sub(-1) == sep and "" or sep)
	target = target .. ((name:sub(1,1) == "." and "." or "") .. string.rep("0", zero_amount - number:len()) .. number .. name:sub(-4))

	return source, target
end



---- Preparing:
-- Get directory iterators for reading in file names
--source_iter, source = lfs.dir(source_directory)
--target_iter, target = lfs.dir(target_directory)

-- Read source file names in to list
i = 0
for file in lfs.dir(source_directory) do
	if lfs.attributes(source_directory..sep..file).mode ~= "directory" then
		file_list[i] = file
		i = i + 1
	end
end

-- Sort list of file names
sort(file_list)

if not options["directory"] then
	-- Read target file names in to list
	local target_list = {}
	i = 0
	for file in lfs.dir(target_directory) do
		if lfs.attributes(target_directory .. sep .. file).mode ~= "directory" and (file:match("0*%d+%.%a+") and #file:sub(1,-5) == zero_amount) then
			target_list[i] = file
			i = i + 1
		end
	end

	if #target_list ~= 0 then
		sort(target_list)
		count_start = tonumber(target_list[#target_list]:sub(1,-5))
	end
end



---- Executing:
-- Iterate through sorted list of file names, executing the desired
--  command on each pair of source name and new numerical name
for k, v in pairs(file_list) do
	source, target = pathify(k + count_start, v)
	if source ~= target then
		if not options["quiet"] then print("  " .. source  .. " --> " .. target) end
		if not options["test"] then os.execute(command .. source .. "\" \"" .. target .. "\"") end
	end
end

--print("time: " .. time_taken)
