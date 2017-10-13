local sDir = "/var/virtualos-manager"
local sSaveFile = "drivelist.lua"
local sVirtualPath
local bSelect = false
local tList = {}
local nSelect
local w,h = term.getSize()
local sVersion = "3.0"
local tEmptyMenu = {}
local tSelectMenu = {}

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
    for k,v in ipairs(tSelectMenu) do
        term.write(v.text.." ")
    end
else
    for k,v in ipairs(tEmptyMenu) do
        term.write(v.text.." ")
    end
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
local sExtra = " \"--title="..tList[nSelect]["title"].."\" --id="..tList[nSelect]["id"]
if tonumber(tList[nSelect]["version"]) <= 1.5 then
    sExtra = sExtra.." --oldnative"
end
if tList[nSelect]["version"] == "1.2" then
    sExtra = sExtra.." --diskapi"
end
if tList[nSelect]["http"] == false then
    sExtra = sExtra.." --nohttp"
end
if tList[nSelect]["sharefolder"] == true then
    sExtra = sExtra.." --sharePath="..tList[nSelect]["sharepath"].." --shareName="..tList[nSelect]["sharename"]
end
if tList[nSelect]["time"] == false then
    sExtra = sExtra.." --notime"
end
if tList[nSelect]["day"] == false then
    sExtra = sExtra.." --noday"
end
if tList[nSelect]["setlabel"] == true then
    sExtra = sExtra.." --label="..tList[nSelect]["label"]
end
if tList[nSelect]["allowper"] == false then
    sExtra = sExtra.." --noper"
end
if tList[nSelect]["epoch"] == false then
    sExtra = sExtra.." --noepoch"
end
if tList[nSelect]["diskmount"] then
    sExtra = sExtra.." --diskmount"
end
if tList[nSelect]["turtleapi"] == false then
    sExtra = sExtra.." --noturtle"
end
if tList[nSelect]["pocketapi"] == false then
    sExtra = sExtra.." --nopocket"
end
if tList[nSelect]["commandapi"] == false then
    sExtra = sExtra.." --nocomand"
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
tmpta.http = true
tmpta.sharefolder = false
tmpta.sharepath = "/"
tmpta.sharename = "share"
tmpta.time = true
tmpta.day = true
tmpta.setlabel = false
tmpta.label = name
tmpta.id = "0"
tmpta.title = "CraftOS "..ver
tmpta.allowper = true
tmpta.epoch = true
tmpta.diskmount = false
tmpta.turtleapi = true
tmpta.pocketapi = true
tmpta.commandapi = true
table.insert(tList,tmpta)
local file = fs.open(fs.combine(sDir,sSaveFile),"w")
file.write(textutils.serialize(tList))
file.close()
redrawMenu()
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

local function run()
    term.clear()
    term.setCursorPos(1,1)
    if shell.run(getCommand()) == false then
        print("Press any Key to Continue")
        os.pullEvent("key")
    end
    redrawMenu()
end

local function delete()
    fs.delete(fs.combine(sDir,"/drive/"..tList[nSelect]["name"]))
    table.remove(tList,nSelect)
    bSelect = false
    local file = fs.open(fs.combine(sDir,sSaveFile),"w")
    file.write(textutils.serialize(tList))
    file.close()
    redrawMenu()
end

local function writeBoolean(bBool)
    if bBool == true then
        term.blit("true","5555","0000")
    else
        term.blit("false","eeeee","00000")
    end
end

local function edit()
    local tObj = tList[nSelect]
    local tOptions = {}
    tOptions[1] = {"boolean","Enable Http: ","http"}
    tOptions[2] = {"boolean","Enable Shared Folder: ","sharefolder"}
    tOptions[3] = {"text","Shared Folder Path: ","sharepath"}
    tOptions[4] = {"text","Shared Folder Name: ","sharename"}
    tOptions[5] = {"boolean","Enable os.time(): ","time"}
    tOptions[6] = {"boolean","Enable os.day(): ","day"}
    tOptions[7] = {"boolean","Set Computer Label: ","setlabel"}
    tOptions[8] = {"text","Computer Label: ","label"}
    tOptions[9] = {"number","Computer ID: ","id"}
    tOptions[10] = {"text","Multishell Title: ","title"}
    tOptions[11] = {"boolean","Allow Peripherals: ","allowper"}
    tOptions[12] = {"boolean","Enable os.epoch(): ","epoch"}
    tOptions[13] = {"boolean","Give acces to Diskdata: ","diskmount"}
    tOptions[14] = {"boolean","Enable Turtle API ","turtleapi"}
    tOptions[15] = {"boolean","Enable Pocket API ","pocketapi"}
    tOptions[16] = {"boolean","Enable Commands API ","commandapi"}
    while true do
        term.setBackgroundColor(colors.white)
        term.setTextColor(colors.black)
        term.clear()
        term.setBackgroundColor(colors.blue)
        term.setCursorPos(1,h)
        term.clearLine()
        term.write("OK")
        term.setBackgroundColor(colors.white)
        for k,v in ipairs(tOptions) do
            term.setCursorPos(1,k)
            if v[1] == "boolean" then
                term.write(v[2])
                writeBoolean(tObj[v[3]])
            elseif v[1] == "text" or v[1] == "number" then
                term.write(v[2]..tObj[v[3]])
            end
        end
        local ev,me,x,y = os.pullEvent()
        if ev == "mouse_click" then
            if type(tOptions[y]) == "table" then
                if tOptions[y][1] == "boolean" then
                    tObj[tOptions[y][3]] = not(tObj[tOptions[y][3]])
                elseif tOptions[y][1] == "text" then
                    term.setCursorPos(#tOptions[y][2]+1,y)
                    tObj[tOptions[y][3]] = read(nil,nil,nil,tObj[tOptions[y][3]])
                elseif tOptions[y][1] == "number" then
                    term.setCursorPos(#tOptions[y][2]+1,y)
                    local tmp = read(nil,nil,nil,tObj[tOptions[y][3]])
                    if tonumber(tmp) == nil then
                        showText("You can only insert Numbers here")
                    else
                        tObj[tOptions[y][3]] = tmp
                    end
                end
            elseif y == h then
                break
            end
        end
    end
    local file = fs.open(fs.combine(sDir,sSaveFile),"w")
    file.write(textutils.serialize(tList))
    file.close()
    redrawMenu()
end

local function copy()
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
    local tmpta = {}
    for k,v in pairs(tList[nSelect]) do
        tmpta[k] = v
    end
    tmpta.name = name
    table.insert(tList,tmpta)
    fs.copy(fs.combine(sDir,"/drive/"..tList[nSelect]["name"]),fs.combine(sDir,"/drive/"..name))
    redrawMenu()
end

if fs.exists(fs.combine(sDir,sSaveFile)) then
    local file = fs.open(fs.combine(sDir,sSaveFile),"r")
    tList = textutils.unserialise(file.readAll())
    file.close()
else
    tList = {}
end

local function backwardsBoolean(bRe,bDe)
    if bRe == nil then
        return bDe
    else
        return bRe
    end
end

--Backwards Compatibylity
for k,v in ipairs(tList) do
    v.http = backwardsBoolean(v.http,true)
    v.sharefolder = backwardsBoolean(v.sharefolder,false)
    v.sharepath = v.sharepath or "/"
    v.sharename = v.sharename or "share"
    v.time = backwardsBoolean(v.time,true)
    v.day = backwardsBoolean(v.day,true)
    v.setlabel = backwardsBoolean(v.setlabel,false)
    v.label = v.label or v.name
    v.id = v.id or "0"
    v.title = v.title or "CraftOS "..v.version
    v.allowper = backwardsBoolean(v.allowper,true)
    v.epoch = backwardsBoolean(v.epoch,true)
    v.diskmount = backwardsBoolean(v.diskmount,false)
    v.turtleapi = backwardsBoolean(v.turtleapi,true)
    v.pocketapi = backwardsBoolean(v.pocketapi,true)
    v.commandapi = backwardsBoolean(v.commandapi,true)
end

tEmptyMenu[1] = {text="New",func=newMachine}
tEmptyMenu[2] = {text="About",func=about}

tSelectMenu[1] = {text="Run",func=run}
tSelectMenu[2] = {text="Delete",func=delete}
tSelectMenu[3] = {text="Edit",func=edit}
tSelectMenu[4] = {text="Copy",func=copy}
tSelectMenu[5] = {text="New",func=newMachine}
tSelectMenu[6] = {text="Link",func=newLink}
tSelectMenu[7] = {text="About",func=about}

redrawMenu()

while true do
    local ev,me,x,y = os.pullEvent()
    if ev == "mouse_click" then
        if y == 1 then
            if bSelect == false then
                local nMenupos = 0
                for key,menuitem in ipairs(tEmptyMenu) do
                    if x > nMenupos and x < menuitem.text:len()+nMenupos+1 then
                        menuitem.func()
                        break 
                    else
                    nMenupos = nMenupos+menuitem.text:len()+1
                    end
                end
                if x == w then
                    break
                end
            elseif bSelect == true then
                local nMenupos = 0
                for key,menuitem in ipairs(tSelectMenu) do
                    if x > nMenupos and x < menuitem.text:len()+nMenupos+1 then
                        menuitem.func()
                        break 
                    else
                    nMenupos = nMenupos+menuitem.text:len()+1
                    end
                end
                if x == w then
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
