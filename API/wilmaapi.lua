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

function loadConfig(path,default)
local returnta = {}
if fs.exists(path) == false then
  local writecon = io.open(path,"w")
  for _,text in ipairs(default) do
    writecon:write(text.."\n")
  end
  writecon:close()
end
local confile = io.open(path,"r")
for linecon in confile:lines() do
  if not(linecon:find("#")==1) then
    local ind,con = splitString(linecon," ")
    con = linecon:sub(ind:len()+2,-1)
    returnta[ind] = con
  end
end
confile:close()
return returnta
end
