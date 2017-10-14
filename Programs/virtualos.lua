local function parseArgs(params)
local args = {}
local options = {}
for key,data in ipairs(params) do
if type(data) == "string" then
  if data:find("--") == 1 then
    data = data:sub(3,-1)
    local head,body = data:match("([^=]+)=([^=]+)")
    if body ~= nil then
      options[head] = body
    else
      options[data] = true
    end
 elseif data:find("-") == 1 then
    data = data:sub(2,-1)
    for i=1,#data do
      options[data:sub(i,i)] = true
    end
  else
    table.insert(args,data)
  end
end
end
return args,options
end

local function tablecopy(tInput)
local tCopy = {}
for k,v in pairs(tInput) do
    tCopy[k] = v
end
return tCopy
end

local argst,ops = parseArgs({...})

if ops.biosPath == nil then
    printError("Missed Argument --biosPath=Path")
    return
end
if ops.romPath == nil then
    printError("Missed Argument --romPath=Path")
    return
end
if ops.rootPath == nil then
    printError("Missed Argument --rootPath=Path")
    return
end

local sBiosPath = fs.combine(ops.biosPath,"")
local sRomPath = fs.combine(ops.romPath,"")
local sRootPath = fs.combine(ops.rootPath,"")
local bShutdown = false
local bReeboot = false
local sVirtualID = tostring(math.random(1,1000))
local sShareName = ops.shareName or "share"
local sSharePath
if ops.sharePath ~= nil then
    sSharePath = fs.combine(ops.sharePath,"")
end
local tDisk = {}

local function addDisk()
    tDisk = {}
    for n,sName in pairs( peripheral.getNames() ) do
        if disk.isPresent(sName) and disk.hasData(sName) then
            table.insert( tDisk, disk.getMountPath(sName) )
        end
    end
end

if ops.diskmount then
    addDisk()
end

local tFs = {}
for k,v in pairs(fs) do
    tFs[k] = v
end
local function getRealPath(sPath)
    sPath = fs.combine(sPath,"")
    if sPath:find("rom") == 1  then
        sPath = sPath:sub(4)
        sPath = fs.combine(sRomPath,sPath)
        return sPath
    elseif sPath:find(sShareName) == 1 and ops.sharePath then
        sPath = sPath:sub(#sShareName+1)
        return fs.combine(sSharePath,sPath)
    end
    for k,v in ipairs(tDisk) do
        if sPath:find(v) == 1 then
            sPath = sPath:sub(#v+1)
            return fs.combine(v,sPath)
        end
    end
    local sNewPath = fs.combine(sRootPath,sPath)
    return sNewPath
end

function tFs.list(sPath)
    local sPath = getRealPath(sPath)
    local tList = fs.list(sPath)
    if sPath == sRootPath then
        table.insert(tList,"rom")
        if ops.sharePath then
            table.insert(tList,sShareName)
        end
        for k,v in ipairs(tDisk) do
            table.insert(tList,v)
        end
    end
    table.sort(tList)
    return tList
end

function tFs.open(sPath,sMode)
    local sPath = getRealPath(sPath)
    return fs.open(sPath,sMode)
end

function tFs.exists(sPath)
    local sPath = getRealPath(sPath)
    return fs.exists(sPath)
end

function tFs.isDir(sPath)
    local sPath = getRealPath(sPath)
    return fs.isDir(sPath)
end

function tFs.delete(sPath)
    local sPath = getRealPath(sPath)
    return fs.delete(sPath)
end

function tFs.move(sPath,sTo)
    local sPath = getRealPath(sPath)
    local sTo = getRealPath(sTo)
    return fs.move(sPath,sTo)
end

function tFs.copy(sPath,sTo)
    local sPath = getRealPath(sPath)
    local sTo = getRealPath(sTo)
    return fs.copy(sPath,sTo)
end

function tFs.find(sPath)
    local sPath = getRealPath(sPath)
    local tResult = fs.find(sPath)
    for k,v in ipairs(tResult) do
        tResult[k] = v:sub(#sRootPath+2)
    end
    return tResult
end

function tFs.getSize(sPath)
    local sPath = getRealPath(sPath)
    return fs.getSize(sPath)
end

--For Pre 1.8 User
local tPalette = {
	[1] = {240, 240, 240},
	[2] = {242, 178, 51},
	[4] = {229, 127, 216},
	[8] = {153, 178, 242},
	[16] = {222, 222, 108},
	[32] = {127, 204, 25},
	[64] = {242, 178, 204},
	[128] = {76, 76, 76},
	[256] = {153, 153, 153},
	[512] = {76, 153, 178},
	[1024] = {178, 102, 229},
	[2048] = {51, 102, 204},
	[4096] = {127, 102, 76},
	[8192] = {87, 166, 78},
	[16384] = {204, 76, 76},
	[32768] = {25, 25, 25},
}
local tTerm = {}
for k,v in pairs(term.current()) do
    tTerm[k] = v
end
tTerm.setPaletteColor = tTerm.setPaletteColor or function(col,a,b,c) tPalette[col][1] = a*255 tPalette[col][2] = b*255 tPalette[col][3] = c*255 end
tTerm.setPaletteColour = tTerm.setPaletteColour or function(col,a,b,c) tPalette[col][1] = a*255 tPalette[col][2] = b*255 tPalette[col][3] = c*255 end
tTerm.getPaletteColor = tTerm.getPaletteColor or function(color) return tPalette[color][1]/255,tPalette[color][3]/255,tPalette[color][3]/255 end
tTerm.getPaletteColour = tTerm.getPaletteColour or function(color) return tPalette[color][1]/255,tPalette[color][3]/255,tPalette[color][3]/255 end
if ops.oldnative then
    tTerm.native = tTerm
else
    tTerm.native = function() return tTerm end
end

local nStarttime = os.clock()
local tOs = {}
local sLabel = ops.label
local tTimer = {}
local tTimerID = {}
local nTimerCount = 0
local tAlarm = {}
local tAlarmID = {}
local nAlarmCount = 0
function tOs.startTimer(nTime)
    local nID = os.startTimer(nTime) 
    tTimer[nID] = true 
    tTimerID[nTimerCount] = nID 
    nTimerCount = nTimerCount + 1
    return nTimerCount - 1
end
function tOs.setAlarm(nTime)
    local nID = os.setAlarm(nTime) 
    tAlarm[nID] = true 
    tAlarmID[nAlarmCount] = nID 
    nAlarmCount = nAlarmCount + 1
    return nAlarmCount - 1
end
tOs.shutdown = function() bShutdown = true end
tOs.reboot = function() bReeboot = true bShutdown = true end
tOs.clock = function() return os.clock()-nStarttime end
tOs.getComputerID = function() return math.floor(tonumber(ops.id)) or 0 end
tOs.getComputerLabel = function() return sLabel end
tOs.setComputerLabel = function(label) sLabel = label end
tOs.queueEvent = function(...) os.queueEvent("VirtualOS_"..sVirtualID,...) end
function tOs.cancelTimer(nID)
    for i=0, #tTimerID do
        if tTimerID[i] == nID then
            nID = i
        end
    end
    return os.cancelTimer(nID)
end
function tOs.cancelAlarm(nID)
    for i=0, #tAlarmID do
        if tAlarmID[i] == nID then
            nID = i
        end
    end
    return os.cancelAlarm(nID)
end
if ops.notime then
    tOs.time = function() return 7 end
else
    tOs.time = os.time
end
if ops.noday then
    tOs.day = function() return 1 end
else
    tOs.day = os.day
end
if ops.noepoch then
    tOs.epoch = function() return 111600000 end
else
    tOs.epoch = os.epoch or function() return tOs.day() * 86400000 + (tOs.time() * 3600000) end
end

local tHttp = {}
tUrl = {}
function tHttp.request(...)
    os.queueEvent("Hallo")
    local tArgu = {...}
    tUrl[tArgu[1]] = true
    return http.request(...)
end
function tHttp.checkURL(sUrl)
    tUrl[sUrl] = true
    local ok,err = http.checkURL(sUrl)
    os.queueEvent("http_check",sUrl,ok,err)
    return http.checkURL(sUrl)
end

local tPer = {}
if ops.noper then
    function tPer.isPresent() return false end
    function tPer.call() error("No peripheral attached",2) end
    function tPer.getType() return nil end
    function tPer.getMethods() return nil end
else
    tPer.isPresent = peripheral.isPresent
    tPer.call = peripheral.call
    tPer.getType = peripheral.getType
    tPer.getMethods = peripheral.getMethods
end

local tEnv = {}
tEnv.ipairs = ipairs
tEnv.type = type
tEnv.rawget = rawget
tEnv.rawset = rawset
tEnv.rawequal = rawequal
tEnv.setmetatable = setmetatable
tEnv.getmetatable = getmetatable
tEnv.loadstring = loadstring
tEnv.setfenv = setfenv
tEnv.pairs = pairs
tEnv.rawset = rawset
tEnv.getfenv = getfenv
tEnv.pcall = pcall
tEnv.xpcall = xpcall
tEnv.tostring = tostring
tEnv.tonumber = tonumber
tEnv.unpack = unpack
tEnv.load = load
tEnv.select = select
tEnv.next = next
tEnv.error = error
tEnv.assert = assert
tEnv.dofile = dofile
tEnv.loadstring = loadstring
tEnv.loadfile = loadfile
tEnv.peripheral = tPer
tEnv.table = tablecopy(table)
tEnv.math = tablecopy(math)
tEnv.bit = tablecopy(bit)
tEnv.rs = tablecopy(rs)
tEnv.redstone = tablecopy(redstone)
tEnv.fs = tFs
tEnv.term = tTerm
tEnv.os = tOs
tEnv.coroutine = tablecopy(coroutine)
tEnv.string = tablecopy(string)
if turtle and not(ops.noturtle) then
    tEnv.turtle = tablecopy(turtle)
end
if pocket and not(ops.nopocket) then
    tEnv.pocket = tablecopy(pocket)
end
if commands and not(ops.nocomand) then
    tEnv.commands = tablecopy(commands)
end
if not ops.nohttp then
    tEnv.http = tHttp
end
if ops.diskapi then
    tEnv.disk = tablecopy(disk)
end
tEnv._HOST = ops.host or "VirtualOS 4.1"
tEnv._CC_VERSION = ops.ccversion
tEnv._MC_VERSION = ops.mcversion
tEnv._VERSION = _VERSION
tEnv._CC_DEFAULT_SETTINGS = ops.settings or ""
tEnv._G = tEnv

local file = fs.open(sBiosPath,"r")
if not file then
    error("bios not found",0)
end
local fn,err = load(file.readAll(),"@bios.lua")
file.close()
setfenv(fn,tEnv)

if multishell and ops.title ~= true then
    multishell.setTitle(multishell.getCurrent(),ops.title or "CraftOS")
end

term.setTextColor(colors.white)
term.setBackgroundColor(colors.black)
term.clear()
term.setCursorPos(1,1)
term.setCursorBlink(false)

local tWhitelist = {key=true,key_up=true,char=true,mouse_click=true,mouse_scroll=true,mouse_drag=true,mouse_up=true,paste=true,monitor_touch=true,
terminate=true,term_resize=true,modem_message=true,turtle_inventory=true,redstone=true,task_complete=true}
local tHttpEvent = {http_success=true,http_failure=true,http_check=true}
if not ops.noper then
    tWhitelist.peripheral = true
    tWhitelist.peripheral_detach = true
end

local function start()
local cor = coroutine.create(fn)
local ok,sFilter = coroutine.resume(cor)
while true do
    local tEventData = table.pack( os.pullEventRaw() )
    if tWhitelist[tEventData[1]] == true and (tEventData[1] == sFilter or sFilter == nil) then
        ok,sFilter = coroutine.resume(cor,table.unpack(tEventData))
    elseif tHttpEvent[tEventData[1]] == true and (tEventData[1] == sFilter or sFilter == nil) and tUrl[tEventData[2]] == true then
        tUrl[tEventData[2]] = nil
        ok,sFilter = coroutine.resume(cor,table.unpack(tEventData))
    elseif tEventData[1] == "timer" and (tEventData[1] == sFilter or sFilter == nil) and tTimer[tEventData[2]] == true then
        tTimer[tEventData[2]] = nil
        for i=0, #tTimerID do
            if tTimerID[i] == tEventData[2] then
                tEventData[2] = i
            end
        end
        ok,sFilter = coroutine.resume(cor,table.unpack(tEventData))
    elseif tEventData[1] == "alarm" and (tEventData[1] == sFilter or sFilter == nil) and tAlarm[tEventData[2]] == true then
        tAlarm[tEventData[2]] = nil
        for i=0, #tAlarmID do
            if tAlarmID[i] == tEventData[2] then
                tEventData[2] = i
            end
        end
        ok,sFilter = coroutine.resume(cor,table.unpack(tEventData))
    elseif (tEventData[1] == "disk" or tEventData[1] == "disk_eject") and (tEventData[2] == sFilter or sFilter == nil) and ops.diskmount then
        addDisk()
        ok,sFilter = coroutine.resume(cor,table.unpack(tEventData))
    elseif (tEventData[1] == "VirtualOS_"..sVirtualID or tEventData[1] == "VirtualOS_Event") and (tEventData[2] == sFilter or sFilter == nil) then
        table.remove(tEventData,1)
        ok,sFilter = coroutine.resume(cor,table.unpack(tEventData))
    end
    if bShutdown == true then
        break
    end
end
end

while true do
    start()
    if not(ops.noclear) or bReeboot then
        term.setTextColor(colors.white)
        term.setBackgroundColor(colors.black)
        term.clear()
        term.setCursorPos(1,1)
        term.setCursorBlink(false)
    end
    if not bReeboot then
        break
    else
        tTimer = {}
        tTimerID = {}
        nTimerCount = 0
        tAlarm = {}
        tAlarmID = {}
        nAlarmCount = 0
        bShutdown = false
        bReeboot = false
    end
end
