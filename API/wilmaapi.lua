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
local a,b = str:match("([^"..split.."]+)"..split.."([^"..split.."]+)")
local len = a:len()+split:len()+1
local b = str:sub(len,-1)
return a,b
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

function getStringTabel(str,split)
local returnta = {}
local returnstr = ""
for i = 1, #str do
local c = str:sub(i,i)
if c == split then
  table.insert(returnta,returnstr)
  returnstr = ""
else
  returnstr = returnstr..c
end
end

if not(returnstr=="") then
  table.insert(returnta,returnstr)
end

return returnta
end

function downloadFile(url,path)
print(path)
local filecon = http.get(url)
local writefi = io.open(path,"w")
writefi:write(filecon.readAll())
filecon.close()
writefi:close()
print("Pafad"..path)
end

function readPackmanRepo()
local repodir = fs.list("/etc/repositories")
local packagelist = {}
for _,reponame in ipairs(repodir) do
local repofile = io.open("/etc/repositories/"..reponame,"r")
local packname = ""
for linecon in repofile:lines() do
local nospace = linecon:gsub(" ","")
if nospace:find("name=") == 1 then
  packagelist[reponame.."/"..packname] = packagelist[packname]
  packname = nospace:sub(6,-1)
  packagelist[packname] = {}
elseif packname == "" then
elseif nospace:find("type=") then
  _,packagelist[packname]["type"] = wilmaapi.splitString(nospace,"=")
elseif nospace:find("url=") then
 _,packagelist[packname]["url"] = wilmaapi.splitString(nospace,"=")
elseif nospace:find("filename=") then
  local _,name = wilmaapi.splitString(nospace,"=")
  _,packagelist[packname]["filename"] = wilmaapi.splitString(nospace,"=")
elseif nospace:find("size=") then
  _,packagelist[packname]["size"] = wilmaapi.splitString(nospace,"=")
elseif nospace:find("target=") then
  _,packagelist[packname]["target"] = wilmaapi.splitString(nospace,"=")
elseif nospace:find("version=") then
  _,packagelist[packname]["version"] = wilmaapi.splitString(nospace,"=")
elseif nospace:find("category=") then
  _,packagelist[packname]["category"] = wilmaapi.splitString(nospace,"=")
elseif nospace:find("dependencies=") then
  local _,dep = wilmaapi.splitString(linecon,"=")
  dep = dep:sub(2,-1)
  packagelist[packname]["dependencies"] = wilmaapi.getStringTabel(dep," ")
end
end
packagelist[reponame.."/"..packname] = packagelist[packname]
repofile:close()
end
return packagelist
end

function version()
  return 3.1
end
