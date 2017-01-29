if wsh then
  print("wsh is already running")
  return
end

if term.isColour() == false then
  print("This programm run not on a normal computer")
  return
end

os.loadAPI("/usr/apis/wilmaapi")
os.loadAPI("clipboard")

if wilmaapi == nil then
  print("Can't found wilmaapi. If you have it unistalled, run \"packman install wilmaapi\" to reinstall it")
  return
end

if clipboard == nil then
  print("Can't found Clipboard API. If you have it unistalled, run \"packman install clipboard\" to reinstall it")
  return
end

local condef = {}
table.insert(condef,"#Enable or Disable autocompletion")
table.insert(condef,"enableAutocomplete true")
table.insert(condef,"#If it true, wsh remember the Commands that you have used")
table.insert(condef,"saveHistory true")
table.insert(condef,"#If it true, you can scroll with the mousewhell")
table.insert(condef,"enableScroll true")
table.insert(condef,"#Enable or Disable Vars")
table.insert(condef,"#Note: Enableing vars my make your Shell slower")
table.insert(condef,"enableVars true")
table.insert(condef,"#Use the Shebang if exists")
table.insert(condef,"enableShebang true")
table.insert(condef,"#Make a copy of the file without Shebang and run this")
table.insert(condef,"#This may be useful if the shebang causes a error")
table.insert(condef,"removeShebang true")
table.insert(condef,"#Enable selecting text")
table.insert(condef,"enableTextSelect true")
table.insert(condef,"#This function give the text at the start of each Line")
table.insert(condef,"#You can use shell Vars.")
table.insert(condef,"#Note: You can't use the shell API")
table.insert(condef,'startLine return "$PWD+>"')
table.insert(condef,"#This function is called when a command is not found")
table.insert(condef,"#Note: You can't use the shell API")
table.insert(condef,'commandNotFound print("Command not found")')
table.insert(condef,"#Select your Keys")
table.insert(condef,"runKey enter")
table.insert(condef,"deleteKey backspace")
table.insert(condef,"completeKey tab")
table.insert(condef,"historyUpKey up")
table.insert(condef,"historyDownKey down")
table.insert(condef,"copyKey rightAlt")
table.insert(condef,"exitCommand exit")
table.insert(condef,"historyCommand history")
table.insert(condef,"aboutCommand about")
table.insert(condef,"#Set a Var")
table.insert(condef,"varsetCommand varset")
table.insert(condef,"#Delete a Var")
table.insert(condef,"vardelCommand unset")
table.insert(condef,"#Print all Vars")
table.insert(condef,"varlistCommand printenv")
table.insert(condef,"#Run this Shellscript with start of wsh")
table.insert(condef,"startupScript /wshrc")

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
testConfig("enableVars","bool")
testConfig("enableShebang","bool")
testConfig("removeShebang","bool")
testConfig("enableTextSelect","bool")
testConfig("startLine")
testConfig("commandNotFound")
testConfig("runKey","key")
testConfig("deleteKey","key")
testConfig("completeKey","key")
testConfig("historyUpKey","key")
testConfig("historyDownKey","key")
testConfig("copyKey","key")
testConfig("exitCommand")
testConfig("historyCommand")
testConfig("aboutCommand")
testConfig("varsetCommand")
testConfig("vardelCommand")
testConfig("varlistCommand")
testConfig("startupScript")
term.setTextColor(colors.white)

if configstatus == false then
  return 2
end

shell.setAlias(config.exitCommand,config.exitCommand.. " is a built-in command of wsh")
shell.setAlias(config.historyCommand,config.historyCommand.. " is a built-in command of wsh")
shell.setAlias(config.aboutCommand,config.aboutCommand.. " is a built-in command of wsh")
shell.setAlias(config.varsetCommand,"Function of wsh")
shell.setAlias(config.vardelCommand,"Function of wsh")
shell.setAlias(config.varlistCommand,"Function of wsh")

wsh = {}
local runstr = ""
local comp
local comptest = false
local oldstr
local compcou
local history = {}
local hiscou = 1
local histempcou = 1
local w,h = term.getSize()
wsh.line = 1
wsh.mark = {}
wsh.version = 2.2
wsh.output = true
wsh.varta = {}
wsh.linewrite = false
wsh.markx = {}
wsh.marky = {}
wsh.cliplines = 1
wsh.clipstart = term.getSize()
wsh.clipend = 1

wsh.varta.PWD = function() return "/"..shell.dir() end
wsh.varta.TIME = os.time
wsh.varta.DAY = os.day
wsh.varta.PATH = shell.path
wsh.varta.ID = os.getComputerID()
wsh.varta.LABEL = os.getComputerLabel()

oldterm = term
termcon = {}
termline = 1
oldwrite = write
oldprint = print
oldread = read

if config.enableScroll == "true" then

function wsh.compileString()
local tmpta = {}
tmpta.text = ""
tmpta.colour = ""
tmpta.background = ""
for _,con in ipairs(termcon[termline]) do
  tmpta.text = tmpta.text..con.text
  tmpta.colour = tmpta.colour..string.format("%x", math.floor(math.log(con.colour) / math.log(2)))
  tmpta.background = tmpta.background..string.format("%x", math.floor(math.log(con.background) / math.log(2)))
end
termcon[termline] = tmpta
end

function write(text)
local posx = term.getCursorPos()
oldwrite(text)
if termcon[termline] == nil then
  termcon[termline] = {}
end
for i =1,#text do
local c = text:sub(i,i)
if c == "\n" then
  wsh.compileString()
  termline = termline + 1
  posx = 1
  termcon[termline] = {}
else
  termcon[termline][posx] = {}
  termcon[termline][posx]["text"] = c
  termcon[termline][posx]["colour"] = term.getTextColour()
  termcon[termline][posx]["background"] = term.getBackgroundColour()
  posx = posx + 1
end
end
end

function print(prtext)
if prtext == nil then
  oldprint()
  termline = termline + 1
else
  write(prtext.."\n")
end
end

function read(a,b,c)
local posx = term.getCursorPos()
local re = oldread(a,b,c)
--local posx = term.getCursorPos()
if termcon[termline] == nil then
  termcon[termline] = {}
end
for i = 1,#re do
local c = re:sub(i,i)
termcon[termline][posx] = {}
termcon[termline][posx]["text"] = c
termcon[termline][posx]["colour"] = term.getTextColour()
termcon[termline][posx]["background"] = term.getBackgroundColour()
posx = posx + 1
end
termline = termline + 1
return re
end

function io.write(writext)
write(writext)
end

--[[
function term.clear()
oldterm.clear()
termcon = {}
termline = 1
end

function term.clearLine()
oldterm.clearLine()
termcon[termline] = {}
end
--]]
end

function wsh.getVars(str)
local returnstr = ""
local varstr = ""
local varmode = false
for i = 1,#str do
local c = str:sub(i,i)
if varmode == true then
  if c == " " or c == "+" then
    if type(wsh.varta[varstr]) =="function" then
      returnstr = returnstr..wsh.varta[varstr]()
    else
      returnstr = returnstr..tostring(wsh.varta[varstr])
    end
    if c == " " then
      returnstr = returnstr.." "
    end
    varstr = ""
    varmode = false
  else
    varstr = varstr..c
  end
else
  if c == "$" then
    varmode = true
  else
    returnstr = returnstr..c
  end
end
end
if varmode == true then
  if type(wsh.varta[varstr]) == "function" then
    returnstr = returnstr..wsh.varta[varstr]().." "
  else
    returnstr = returnstr..tostring(wsh.varta[varstr])
  end
end
return returnstr
end

local function writeLine()
if wsh.linewrite == true then
local tmpfu = config["startLine"]
tmpfu = wsh.getVars(tmpfu)
write(load(tmpfu)()..runstr)
end
end

local function redrawLine()
local x,y = term.getCursorPos()
term.clearLine()
term.setCursorPos(1,y)
writeLine()
end

function wsh.checkString()
wsh.comtmp,wsh.wrpath = runstr:match("([^ >> ]+) >> ([^ >> ]+)")
if wsh.comtmp == nil then
  return
else
  runstr = wsh.comtmp
  wsh.output = false
  termconba = termcon
  termlineba = termline
  termcon = {}
  termline = 1
  wsh.posx = 1
end
end

function wsh.afterRun()
if wsh.wrpath == nil then
  return
end
local writefi = io.open(wsh.wrpath,"w")
for _,linecon in ipairs(termcon) do
  --for _,char in ipairs(linecon) do
    if not(linecon==nil) then
      writefi:write(linecon.text)
      oldprint("Output:"..linecon.text)
    end
  --end
  --oldprint("line")
  writefi:write("\n")
end
writefi:close()
termcon = termconba
termline = termlineba
end

function wsh.execute()
comptest = false
    oldrunstr = runstr
    if config.enableVars == "true" then
      runstr = wsh.getVars(runstr)
    end
    if config.saveHistory == "true" then
      history[hiscou] = oldrunstr
      hiscou = hiscou + 1
      histempcou = hiscou
    end
    if runstr == config.exitCommand then
      print()
      term = oldterm
      write = oldwrite
      print = oldprint
      read = oldread
      wsh = nil
      termcon = nil
      termline = nil
      exit = true
      return
    elseif runstr == config.historyCommand then
      for _,text in ipairs(history) do
        print(text)
      end
      runstr = ""
      writeLine()
    elseif runstr == config.aboutCommand then
      print()
      print("This is wsh Version "..wsh.version.." made by Wilma456")
      runstr = ""
      writeLine()
    elseif runstr:find(config.varsetCommand) == 1 then
      runstr = runstr:sub(config.varsetCommand:len()+2,-1)
      print()
      local varname,varcon = wilmaapi.splitString(runstr,"=")
      if varname == nil or varcon == nil then
        print("Usage: "..config.varsetCommand.. " <Varname>=<Varcon>")
      else
        wsh.varta[varname] = varcon
      end
      runstr = ""
      writeLine()
    elseif runstr:find(config.vardelCommand) == 1 then
      runstr = runstr:sub(config.vardelCommand:len()+2,-1)
      wsh.varta[runstr] = nil
      runstr = ""
      print()
      writeLine()
    elseif runstr == config.varlistCommand then
      print()
      for ind,_ in pairs(wsh.varta) do
        print(ind)
      end
      runstr = ""
      writeLine()
    else
      --wsh.checkString()
      term.setCursorBlink(false)
      print()
      local runargs
      local pro,arg = wilmaapi.splitString(runstr," ")
      if pro == nil then
        runargs = ""
        pro = runstr
      else
        runargs = runstr:sub(pro:len()+1,-1)
      end
      local runpath = shell.resolveProgram(pro)
      if runpath == nil then
        if not(runstr=="") then
          load(config["commandNotFound"])()
        end
      else
        runpath = "/"..runpath
        if config.enableShebang == "true" then
          local sheread = fs.open(runpath,"r")
          local exestr = sheread.readLine()
          sheread:close()
          if exestr:find("#!") == 1 then
            if config.removeShebang == "true" then
              local readfi = io.open(runpath,"r")
              local writefi = fs.open("/tmp/wshrun","w")
              local check = true
              for linecon in readfi:lines() do
                if check == true then
                  check = nil
                else
                  writefi.writeLine(linecon)
                end
              end
              writefi.close()
              readfi:close()
              exestr = exestr:sub(3,-1).." /tmp/wshrun"
            else
              exestr = exestr:sub(3,-1).." "..runpath
            end
          else
            exestr = runpath
          end
          shell.run(exestr..runargs)
        else
          shell.run(runpath..runargs)
        end
        if fs.exists("/tmp/wshrun") == true then
          fs.delete("/tmp/wshrun")
        end
      end
      runstr = ""
      --wsh.afterRun()
      wsh.output = true
      writeLine()
    end
    wsh.line = termline
end

function wsh.redrawScreen()
oldterm.clear()
oldterm.setCursorPos(1,1)
local w,h = oldterm.getSize()
for i=1,h,1 do
  if type(termcon[i+wsh.line-1]) == "table" then
    local workta = termcon[i+wsh.line-1]
    if type(workta.text) == "string" then
	  local colstr = workta.background
      if type(wsh.mark[i-1]) == "table" then
        for _,pos in ipairs(wsh.mark[i-1]) do
          if not (pos > workta.text:len()) then
          colstr = colstr:sub(1, pos-1) .."8".. colstr:sub(pos+1)
          end
        end
      end
      term.blit(workta.text,workta.colour,colstr)
      oldprint()
    else 
    for cou,con in ipairs(termcon[i+wsh.line-1]) do
      --term.setBackgroundColor(con["background"])
      if not(con.colour==nil) then
        term.setTextColour(con["colour"])
      end
        --if wsh.marky[i] == true then
       -- if wsh.markx[cou] == true then
        --  term.setBackgroundColor(colors.gray)
       -- end
      --end
      if not(con["text"]==nil) then
        oldwrite(con["text"])
      end
    end
    oldprint()
  end
  end
end
redrawLine()
end

if fs.exists(config.startupScript) == true then
local scriptre = io.open(config.startupScript,"r")
for linecon in scriptre:lines() do
if not(linecon:find("#")==1) then
  runstr = linecon
  wsh.execute()
end
end
scriptre:close()
end

wsh.linewrite = true

writeLine()
--local runstr = ""
while true do
term.setTextColor(colors.white)
local ev,me,x,y = os.pullEvent()
term.setCursorBlink(true)
if ev == "mouse_scroll" then
  if config.enableScroll == "true" then
  wsh.mark = {}
  wsh.markx = {}
  wsh.marky = {}
  wsh.clipstart = term.getSize()
  wsh.cliplines = 1
  wsh.clipend = 1
  if me == 1 then
    wsh.line = wsh.line + 1
    wsh.redrawScreen()
  elseif me == -1 then
    wsh.line = wsh.line - 1
    wsh.redrawScreen()
  end
  end
elseif ev == "char" then
  runstr = runstr..me
  write(me)
  comptest = false
elseif ev == "key_up" then
  if me == keys[config.runKey] then
   	wsh.execute()
    if exit == true then
      exit = nil
      break
    end
  --[[
  elseif me == keys[config.deleteKey] then
    comptest = false
    runstr = runstr:sub(1,-2)
    local x,y = term.getCursorPos()
    term.clearLine()
    term.setCursorPos(1,y)
    writeLine()
  ]]--
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
      if type(comp) == "table" then
      if comp[1] then
        oldstr = runstr
        runstr = runstr..comp[1]
        compcou = 1
        comptest = true
        redrawLine()
      end
      end
   end
   end
  elseif me == keys[config.copyKey] then
    local clipstr = ""
    local newline = false
    --local w,h = term.getSize()
    for i=1,wsh.cliplines do
      if type(termcon[i+wsh.line]["text"]) == "string" then
        for k=1,#termcon[i+wsh.line]["text"] do
          if wsh.marky[i] == true then
            if wsh.markx[i][k] == true then
              clipstr = clipstr..termcon[i+wsh.line]["text"]:sub(k,k)
              newline = true
            else
              if not(k<wsh.clipstart) then
                if not(k>wsh.clipend) then
                  clipstr = clipstr.." "
                end
              end
            end
          end
        end
        if newline == true then
          clipstr = clipstr.."\n"
        end
      end
    end
    clipboard.setText(clipstr)
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
elseif ev == "mouse_click" then
  if me == 3 then
    comptest = false
    runstr = runstr..clipboard.getTextLine()
    write(clipboard.getTextLine())
  end
elseif ev == "key" then
   if me == keys[config.deleteKey] then
    comptest = false
    runstr = runstr:sub(1,-2)
    local x,y = term.getCursorPos()
    term.clearLine()
    term.setCursorPos(1,y)
    writeLine()
   end
elseif ev == "mouse_drag" then
  if config.enableTextSelect == "true" then
  if not(type(wsh.mark[y]) == "table") then
    wsh.mark[y] = {}
  end
  if not(type(wsh.markx[y]) == "table") then
    wsh.markx[y] = {}
  end
  table.insert(wsh.mark[y],x)
  wsh.markx[y][x] = true
  wsh.marky[y] = true
  if y > wsh.cliplines then
    wsh.cliplines = y
  end
  if x < wsh.clipstart then
    wsh.clipstart = x
  end
  if x > wsh.clipend then
    wsh.clipend = x
  end
  wsh.redrawScreen()
  end
end
end
