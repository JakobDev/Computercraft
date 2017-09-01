local function parseArgs(params)
local args = {}
local options = {}
for key,data in ipairs(params) do
if type(data) == "string" then
  if data:find("--",1,true) == 1 then
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
local bShutdown = true
local bReeboot = false

function parseArgs(params)
local args = {}
local options = {}
for key,data in ipairs(params) do
if type(data) == "string" then
  if data:find("--",1,true) == 1 then
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

local tTerm = {}
for k,v in pairs(term.current()) do
    tTerm[k] = v
end
function tTerm.native()
    return term.current()
end

local nStarttime = os.clock()
local tOs = {}
local sLabel
local tTimer
tOs.startTimer = os.startTimer
tOs.shutdown = function() bShutdown = false end
tOs.reboot = function() bReeboot = true bShutdown = false end
tOs.clock = function() return os.clock()-nStarttime end
tOs.getComputerID = function() return 0 end
tOs.getComputerLabel = function() return sLabel end
tOs.setComputerLabel = function(label) sLabel = label end
tOs.cancelTimer = os.cancelTimer
tOs.time = os.time
tOs.day = os.day
tOs.epoch = os.epoch

local tEnv = {}
tEnv.ipairs = ipairs
tEnv.type = type
tEnv.rawget = rawget
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
tEnv.http = http
tEnv._HOST = "VirtualOS 1.0"
tEnv._VERSION = _VERSION
tEnv._G = tEnv

local fn,err = loadfile(sBiosPath)
setfenv(fn,tEnv)

local function shutdownLoop()
    while bShutdown do
        sleep(0.1)
    end
end
   
while true do     
    parallel.waitForAny(fn,shutdownLoop)
    if bReeboot == true then
        bShutdown = true
        bReeboot = false
    else
        break
    end
end
