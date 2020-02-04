target = arg[1]

os.execute("mv " .. target .. "/000041.txt " .. target .. "/0000410.txt")
os.execute("mv " .. target .. "/000042.txt " .. target .. "/0000429.txt")

numbers = {11, 12, 13, 18, 19, 20, 21, 22, 28}
for i, number in ipairs(numbers) do
	os.execute("echo -n \"" .. string.char(96+i) .. "\" > " .. target .. "/00004" .. number .. ".txt")
end
