local fortuneta = {}
local fortunecou = 0
local function readFile(path)
local readfi = fs.open("/usr/share/fortune/"..path,"r")
local tmpta = {}
local loop = true
while loop == true do
local linecon = readfi.readLine()
if linecon == nil then
  loop = nil
else
  if linecon == "%" then
    table.insert(fortuneta,tmpta)
    tmpta = {}
    fortunecou = fortunecou + 1
  else
    table.insert(tmpta,linecon)
  end
end
end
end

local Filelist = fs.list("/usr/share/fortune")

for _,file in ipairs(Filelist) do
if fs.isDir("/usr/share/fortune/"..file) == false then
readFile(file)
end
end

local random = math.random(1,fortunecou)
for _,text in ipairs(fortuneta[random]) do
print(text)
end
