path_prefix = ".."
sep = package.path:find("\\") and "\\" or "/"
package.path = package.path .. ";" .. path_prefix .. sep .. "arg-handler" .. sep .. "?.lua;" .. path_prefix .. sep .. "sorting" .. sep .. "?.lua"

lfs = require("lfs")
require("shell-sort")
require("arg-handler")

options = {
	directory = "d"
}
options = process_args(arg, options)

if options['help-text'] then
	print(options['help-text'])
	os.exit()
end

for j = 1, 6 do
	local letter = options[1] .. string.char(96+j)
	local source = letter .. 1 .. sep
	local target = letter .. 2 .. sep

	local command = ""
	if options['directory'] then
		command = (path_prefix .. sep .. "overlap-copy.lua -d " .. target)
	else
		command = (path_prefix .. sep .. "overlap-copy.lua " .. source .. " " .. target)
	end
	print(command)
	os.execute(command)

	print()

	local i = 0
	local file_list = {}
	for file in lfs.dir(target) do
		local filepath = target .. sep .. file
		if lfs.attributes(filepath).mode ~= "directory" then
			file_list[i] = filepath
			i = i + 1
		end
	end
	sort(file_list)

	for i, entry in pairs(file_list) do
		local readfile = io.open(entry, "r")
		print(i, readfile:read("*a"), entry)
		readfile:close()
	end

	print("\n-----------------------------------------\n")
end
