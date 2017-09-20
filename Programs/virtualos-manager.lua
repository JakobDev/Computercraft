local sDir = "/var/virtualos-manager"
local sSaveFile = "drivelist.lua"
local sVirtualPath
local bSelect = false
local tList = {}
local nSelect
local w,h = term.getSize()
local sVersion = "2.0"

if fs.exists(fs.combine(fs.getDir(shell.getRunningProgram()),"virtualos.lua")) then
    sVirtualPath = "/"..fs.combine(fs.getDir(shell.getRunningProgram()),"virtualos.lua")
elseif fs.exists("/usr/bin/virtualos.lua") then
    sVirtualPath = "/usr/bin/virtualos.lua"
else
    error("Can't find VirtualOS",0)
end

local function showText(sText)
w,h = term.getSize()
term.setBackgroundColor(colors.white)
term.clear()
term.setTextColor(colors.black)
term.setCursorPos(1,1)
print(sText)
term.setBackgroundColor(colors.blue)
term.setCursorPos(1,h)
term.clearLine()
term.write("OK")
while true do
    local ev,me,x,y = os.pullEvent("mouse_click")
    if y == h then
        return
    end
end
end

local function redrawMenu()
w,h = term.getSize()
term.setBackgroundColor(colors.white)
term.clear()
term.setBackgroundColor(colors.blue)
term.setCursorPos(1,1)
term.clearLine()
term.setTextColor(colors.black)
if bSelect then
    term.write("Run Delete New Link About")
else
    term.write("New About")
end
term.setCursorPos(w,1)
term.blit("X","f","e")
term.setBackgroundColor(colors.white)
for i=2,h do
    if type(tList[i-1]) == "table" then
        term.setCursorPos(1,i)
        if i-1 == nSelect then
            term.setBackgroundColor(colors.yellow)
            term.clearLine()
            term.write(tList[i-1]["name"])
            term.setBackgroundColor(colors.white)
        else
            term.write(tList[i-1]["name"])
        end
    end
end
end

local function getCommand()
local sRomPath
if os.version():sub(9) == tList[nSelect]["version"] then
    sRomPath = "/rom"
else
    sRomPath = fs.combine(sDir,"rom/"..tList[nSelect]["version"])
end
local sExtra = " \"--title=CraftOS "..tList[nSelect]["version"].."\""
if tonumber(tList[nSelect]["version"]) <= 1.5 then
    sExtra = sExtra.." --oldnative"
end
if tList[nSelect]["version"] == "1.2" then
    sExtra = sExtra.." --diskapi"
end
return sVirtualPath.." --biosPath="..fs.combine(sDir,"bios/"..tList[nSelect]["version"])..".lua --romPath="..sRomPath.." --rootPath="..fs.combine(sDir,"drive/"..tList[nSelect]["name"])..sExtra
end

local function downloadFile(sURL,sPath)
local handle = http.get(sURL)
if not handle then
    return false
end
local file = fs.open(sPath,"w")
file.write(handle.readAll())
file.close()
handle.close()
return true
end

local function getVersion()
local tVersion = {"1.0","1.1","1.2","1.3","1.4","1.5","1.6","1.7","1.8"}
term.setBackgroundColor(colors.white)
term.clear()
term.setBackgroundColor(colors.blue)
term.setCursorPos(1,1)
term.clearLine()
term.setTextColor(colors.black)
term.write("Please choose CraftOS Version:")
term.setBackgroundColor(colors.white)
for k,v in ipairs(tVersion) do
    term.setCursorPos(1,k+1)
    term.write("CraftOS "..v)
end
while true do
    local ev,me,x,y = os.pullEvent("mouse_click")
    if type(tVersion[y-1]) == "string" then
        return tVersion[y-1]
    end
end
end

local function getBios(sVersion)
local tBios = {}
tBios["1.0"] = "https://raw.githubusercontent.com/Wilma456/ComputercraftRom/1.0/bios.lua"
tBios["1.1"] = "https://raw.githubusercontent.com/Wilma456/ComputercraftRom/1.1/bios.lua"
tBios["1.2"] = "https://raw.githubusercontent.com/Wilma456/ComputercraftRom/1.2/bios.lua"
tBios["1.3"] = "https://raw.githubusercontent.com/Wilma456/ComputercraftRom/1.3/bios.lua"
tBios["1.4"] = "https://raw.githubusercontent.com/Wilma456/ComputercraftRom/1.4/bios.lua"
tBios["1.5"] = "https://raw.githubusercontent.com/alekso56/ComputercraftLua/1.5/bios.lua"
tBios["1.6"] = "https://raw.githubusercontent.com/alekso56/ComputercraftLua/1.65/bios.lua"
tBios["1.7"] = "https://raw.githubusercontent.com/alekso56/ComputercraftLua/1.79/bios.lua"
tBios["1.8"] = "https://raw.githubusercontent.com/dan200/ComputerCraft/master/src/main/resources/assets/computercraft/lua/bios.lua"
local sFile = fs.combine(sDir,"bios")
sFile = fs.combine(sFile,sVersion..".lua")
if not fs.exists(sFile) then
    downloadFile(tBios[sVersion],sFile)
end
end

local function getRom(sVersion)
local sPath = fs.combine(sDir,"rom/"..sVersion)
if os.version():sub(9) == sVersion or fs.exists(sPath) then
    return
end
term.clear()
term.setCursorPos(1,1)
print("Download /rom")
local handle = http.get("https://raw.githubusercontent.com/Wilma456/Computercraft/master/romlist.lua")
local tList = load(handle.readAll())()
handle.close()
for k,v in pairs(tList[sVersion]) do
    print("Download "..k)
    if downloadFile(v,fs.combine(sPath,k)) == false then
        printError("Falied to download "..k)
    end
end
end

local function newMachine()
term.clear()
term.setCursorPos(1,1)
term.setBackgroundColor(colors.blue)
term.clearLine()
term.write("Please choose a name:")
term.setBackgroundColor(colors.white)
term.setCursorPos(1,2)
local name = read()
if name == "" then
    showText("The Name can't be empty")
    redrawMenu()
    return
elseif name:find(" ") ~= nil then
    showText("No spaces allowed")
    redrawMenu()
    return
end
for k,v in ipairs(tList) do
    if v.name == name then
        showText("This Name does already exists")
        redrawMenu()
        return
    end
end
local ver = getVersion()
getBios(ver)
getRom(ver)
fs.makeDir(fs.combine(sDir,"drive/"..name))
local tmpta = {}
tmpta.name = name
tmpta.version = ver
table.insert(tList,tmpta)
local file = fs.open(fs.combine(sDir,sSaveFile),"w")
file.write(textutils.serialize(tList))
file.close()
end

local function newLink()
term.setBackgroundColor(colors.white)
term.clear()
term.setCursorPos(1,1)
term.setBackgroundColor(colors.blue)
term.clearLine()
term.write("Please enter Path:")
term.setBackgroundColor(colors.white)
term.setCursorPos(1,2)
local path = read()
if fs.exists(path) then
    term.clear()
    term.setCursorPos(1,1)
    term.write("File exists. Overwrite? (Y/N)")
    while true do
        local ev,me = os.pullEvent("key")
        if me == keys.y then
            break
        elseif me == keys.n then
            redrawMenu()
            return
        end
    end
end
local file = fs.open(path,"w")
file.write('shell.run("'..getCommand():gsub('"','\\"')..'")')
file.close()
redrawMenu()
end

local function about()
showText("VirtualOS-Manager Version "..sVersion..[[ made by Wilma456

This is a GUI for VirtualOS, which allows you to run CraftOS in a virtual Machine.

VirtualOS and VirtualOS-Manager are both licensed under the BSD 2-clause "Simplified" License]])
redrawMenu()
end

if fs.exists(fs.combine(sDir,sSaveFile)) then
    local file = fs.open(fs.combine(sDir,sSaveFile),"r")
    tList = textutils.unserialise(file.readAll())
    file.close()
else
    tList = {}
end
redrawMenu()

while true do
    local ev,me,x,y = os.pullEvent()
    if ev == "mouse_click" then
        if y == 1 then
            if bSelect == false then
                if x < 4 then
                    newMachine()
                    redrawMenu()
                elseif x > 4 and x < 10 then
                    about()
                elseif x == w then
                    break
                end
            elseif bSelect == true then
                if x < 4 then
                    term.clear()
                    term.setCursorPos(1,1)
                    if shell.run(getCommand()) == false then
                        print("Press any Key to Continue")
                        os.pullEvent("key")
                    end
                    redrawMenu()
                elseif x > 4 and x < 11 then
                    fs.delete(fs.combine(sDir,"/drive/"..tList[nSelect]["name"]))
                    table.remove(tList,nSelect)
                    bSelect = false
                    local file = fs.open(fs.combine(sDir,sSaveFile),"w")
                    file.write(textutils.serialize(tList))
                    file.close()
                    redrawMenu()
                elseif x > 11 and x < 15 then
                    newMachine()
                    redrawMenu()
                elseif x > 15 and x < 20 then
                    newLink()
                elseif x > 20 and x < 26 then
                    about()
                elseif x == w then
                    break
                end
            end
        elseif type(tList[y-1]) == "table" then
            nSelect = y - 1
            bSelect = true
            redrawMenu()
        end
    end
end
term.setBackgroundColor(colors.black)
term.setCursorPos(1,1)
term.clear()
