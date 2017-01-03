os.loadAPI("/usr/apis/wilmaapi")

local condef = {}
table.insert(condef,"enableAutocomplete true")
table.insert(condef,"saveHistory true")
table.insert(condef,"enableScroll true")
table.insert(condef,'startLine return "$PATH>"')
table.insert(condef,'commandNotFound write("")')
table.insert(condef,"runKey enter")
table.insert(condef,"deleteKey backspace")
table.insert(condef,"completeKey tab")
table.insert(condef,"historyUpKey up")
table.insert(condef,"historyDownKey down")
table.insert(condef,"exitCommand exit")
table.insert(condef,"historyCommand history")

local config = wilmaapi.loadConfig("/etc/wsh",condef)
local configstatus = true

local function testConfig(name,contype)
if not (type(config[name]) == "string") then
print("There is no config entry for "..name) 
configstatus = false
elseif contype == "bool" then
  if not (config[name] == "true" or config[name] == "false") then
  print("The config entry for "..name.." is not true/false")
  configstatus = false
  end 
elseif contype == "key" then
  if not (type(keys[config[name]]) == "number") then
    print(name.." is no Key")
    configstatus = false
  end
end
end

term.setTextColor(colors.red)
testConfig("enableAutocomplete","bool")
testConfig("saveHistory","bool")
testConfig("enableScroll","bool")
testConfig("startLine")
testConfig("commandNotFound")
testConfig("runKey","key")
testConfig("deleteKey","key")
testConfig("completeKey","key")
testConfig("historyUpKey","key")
testConfig("historyDownKey","key")
testConfig("exitCommand")
testConfig("historyCommand")
term.setTextColor(colors.white)

if configstatus == false then
  return 2
end

local runstr = ""
local comp
local comptest = false
local oldstr
local compcou
local history = {}
local hiscou = 1
local histempcou = 1
local w,h = term.getSize()

local function writeLine()
local tmpfu = config["startLine"]
tmpfu = tmpfu:gsub("$PATH","/"..shell.dir())
write(load(tmpfu)()..runstr)
end

local function redrawLine()
local x,y = term.getCursorPos()
term.clearLine()
term.setCursorPos(1,y)
writeLine()
end

writeLine()
--local runstr = ""
while true do
term.setTextColor(colors.white)
local ev,me = os.pullEvent()
term.setCursorBlink(true)
if ev == "mouse_scroll" then
  if config.enableScroll == "true" then
  local x,y = term.getCursorPos()
  if me == 1 then
    term.clearLine()
    term.scroll(-1)
    if not(y==h) then
      term.setCursorPos(1,y+1)
    else
      term.setCursorPos(1,h)
    end
    writeLine()
  elseif me == -1 then
    term.clearLine()
    term.scroll(1)
    if not(y==1) then
      term.setCursorPos(1,y-1)
    else
      term.setCursorPos(1,1)
    end
    writeLine()
  end
  end
elseif ev == "char" then
  runstr = runstr..me
  write(me)
  comptest = false
elseif ev == "key_up" then
  if me == keys[config.runKey] then
    comptest = false
    if config.saveHistory == "true" then
      history[hiscou] = runstr
      hiscou = hiscou + 1
      histempcou = hiscou
    end
    if runstr == config.exitCommand then
      print()
      break
    elseif runstr == config.historyCommand then
      for _,text in ipairs(history) do
        print(text)
      end
      runstr = ""
      writeLine()
    else
      print()
      if not(shell.run(runstr)==true) then
        load(config["commandNotFound"])()
      end
      runstr = ""
      writeLine()
    end
  elseif me == keys[config.deleteKey] then
    comptest = false
    runstr = runstr:sub(1,-2)
    local x,y = term.getCursorPos()
    term.clearLine()
    term.setCursorPos(1,y)
    writeLine()
  elseif me == keys[config.completeKey] then
    if config["enableAutocomplete"] == "true" then
    if comptest == true then
      compcou = compcou + 1
      if not(comp[compcou]==nil) then
        runstr = oldstr..comp[compcou]
      else
        runstr = oldstr..comp[1]
        compcou = 1
      end
      redrawLine()
    else
      comp = shell.complete(runstr)
      if not(comp==nil) then
        oldstr = runstr
        runstr = runstr..comp[1]
        compcou = 1
        comptest = true
        redrawLine()
      end
   end
   end
  elseif me == keys[config.historyUpKey] then
    comptest = false
    if not(histempcou==1) then
      histempcou = histempcou - 1
      runstr = history[histempcou]
      redrawLine()
    end
  elseif me == keys[config.historyDownKey] then
    comptest = false
    if not(histempcou==hiscou-1) then
      histempcou = histempcou + 1
      runstr = history[histempcou]
      redrawLine()
    end
  end
elseif ev == "paste" then
  comptest = false
  runstr = runstr..me
  write(me)
end
end
