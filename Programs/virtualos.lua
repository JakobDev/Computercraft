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
local bReeboot = false
local nVirtualID = math.random(1,1000)

if not fs.exists(sBiosPath) then
    printError("Bios not found")
    return
end

if not fs.isDir(sRomPath) then
    printError("Rom not found")
    return
end

if not fs.isDir(sRootPath) then
    printError("Rootfolder not found")
    return
end

local tFs = {}
for k,v in pairs(fs) do
    tFs[k] = v
end
local function getRealPath(sPath)
    if sPath:find("rom") == 1 or sPath:find("/rom") == 1 or sPath:find("\\rom") == 1 then
        local sPath = fs.combine(sPath,"")
        sPath = sPath:sub(4)
        sPath = fs.combine(sRomPath,sPath)
        return sPath
    end
    local sNewPath = fs.combine(sRootPath,sPath)
    return sNewPath
end

function tFs.list(sPath)
    local sPath = getRealPath(sPath)
    local tList = fs.list(sPath)
    if sPath == sRootPath then
        table.insert(tList,"rom")
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
local tTimer
tOs.startTimer = os.startTimer
tOs.shutdown = function() os.queueEvent("VirtualOS_shutdown:"..nVirtualID) end
tOs.reboot = function() bReeboot = true os.queueEvent("VirtualOS_shutdown:"..nVirtualID) end
tOs.clock = function() return os.clock()-nStarttime end
tOs.getComputerID = function() return tonumber(ops.id) or 0 end
tOs.getComputerLabel = function() return sLabel end
tOs.setComputerLabel = function(label) sLabel = label end
tOs.queueEvent = os.queueEvent
tOs.cancelTimer = os.cancelTimer
function tOs.time(source)
    if ops.notime then
        return 7
    else
        return os.time(source)
    end
end
function tOs.day(source)
    if ops.noday then
        return 1
    else
        return os.day(source)
    end
end
tOs.epoch = os.epoch or function() return tOs.day() * 86400000 + (tOs.time() * 3600000) end

local tEnv = {}
tEnv.ipairs = ipairs
tEnv.type = type
tEnv.rawget = rawget
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
tEnv.peripheral = peripheral
tEnv.table = table
tEnv.math = math
tEnv.bit = bit
tEnv.rs = rs
tEnv.redstone = redstone
tEnv.fs = tFs
tEnv.term = tTerm
tEnv.os = tOs
tEnv.coroutine = coroutine
tEnv.string = string
tEnv.turtle = turtle
tEnv.pocket = pocket
if not ops.nohttp then
    tEnv.http = http
end
tEnv._HOST = ops.host or "VirtualOS 2.0"
tEnv._CC_VERSION = ops.ccversion
tEnv._MC_VERSION = ops.mcversion
tEnv._VERSION = _VERSION
tEnv._G = tEnv

local fn,err = loadfile(sBiosPath)
setfenv(fn,tEnv)

local function shutdownLoop()
    os.pullEvent("VirtualOS_shutdown:"..nVirtualID)
end

if multishell then
    multishell.setTitle(multishell.getCurrent(),ops.title or "CraftOS")
end

term.setTextColor(colors.white)
term.setBackgroundColor(colors.black)
term.clear()
term.setCursorPos(1,1)

while true do     
    parallel.waitForAny(fn,shutdownLoop)
    if bReeboot == true then
        bReeboot = false
        term.setTextColor(colors.white)
        term.setBackgroundColor(color.black)
        term.clear()
        term.setCursorPos(1,1)
    else
        break
    end
end
