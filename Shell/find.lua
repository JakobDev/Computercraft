local Args = ...

local files = { }
local stack = { "" }
while #stack > 0 do
    local dir = stack[1]
    table.remove(stack, 1)
    local t = fs.list(dir)
    for i = 1, #t do
        local path = dir.."/"..t[i]
        if fs.isDir(path) then
            table.insert(stack, 1, path)
        else
            files[#files + 1] = path
        end
    end
end

for _,filename in ipairs(files) do
if Args == nil then
  print(filename)
else
  if string.find(filename,Args) == nil then
  --nothing
  else
    print(filename)
  end
end
end
