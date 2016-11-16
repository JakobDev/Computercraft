function listAllFiles(target)
if target == nil then
  target = "/"
end
local stack = {target}
local files = {}
while #stack > 0 do
    local dir = stack[1]
    table.remove(stack, 1)
    local t = fs.list(dir)
    for i = 1, #t do
        local path
        if dir:find("/") == dir:len() then
          path = dir..t[i]
        else
          path = dir.."/"..t[i]
        end
        if fs.isDir(path) then
            table.insert(stack, 1, path)
        else
            files[#files + 1] = path
        end
    end
end
return files
end

function splitString(str,split)
return str:match("([^"..split.."]+)"..split.."([^"..split.."]+)")
end
