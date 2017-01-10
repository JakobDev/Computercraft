--Made by Wilma456
print("Starting Mynaptic Please Wait ...")

os.loadAPI("wilmaapi")

if term.isColor() == false or pocket then
  print("This Programm only run on a Advanced Computer or a Advaced Turtle")
  return 2
end

if wilmaapi == nil then
  term.setTextColor(colors.red)
  print("Error whith loading wilmaapi")
  return 3
end

local packinfo = wilmaapi.readPackmanRepo()
--print("If Mynaptic does not start and you see this errot, try to delete /etc/mynaptic")
function getPrint(text)
packlist.writeLine(text)
rcou = rcou + 1
end

local screenw,screenh = term.getSize()

--Start Help
local helpta = {}

helpta[1] = {}
helpta[1]["titel"] = "Navigate"
helpta[1]["con"] = [[Use the mousewhell or the arrwo keys to scroll. You can mark packages by leftclicking it.

Exit Mynaptic by clicking to "X" in to right up corner
To use the search, just write your text

Warning: The search is a little bit buggy]]

helpta[2] = {}
helpta[2]["titel"] = "Install Software"
helpta[2]["con"] = [[The white software are not installed. Click on it to mark it to install.

If you have choose your software, just click "Apply"
"]]

helpta[3] = {}
helpta[3]["titel"] = "Remove Software"
helpta[3]["con"] = [[The red software are installed. Click on it to mark it to remove.

If you have choose your software, just click "Apply"
"]]

helpta[4] = {}
helpta[4]["titel"] = "Get more information"
helpta[4]["con"] = "If you want more information about a package, just rightclick it"

helpta[5] = {}
helpta[5]["titel"] = "Use History"
helpta[5]["con"] = [[In the default config, Mynaptic write all changes to the file /var/history]]

helpta[6] = {}
helpta[6]["titel"] = "Personalisierte Mynaptic"
helpta[6]["con"] = [[You can change the Config with the "config" Menu or by editing /etc/mynaptic

Mynaptic checks every run, if the config correct.

If you get any config errors by runing Mynaptic (maybe after update) and don't want to fix it, just delete /etc/mynaptic. If the config file not exists, Mynaptic will create them by running]]

helpta[7] = {}
helpta[7]["titel"] = "Report bugs/Feedback"
helpta[7]["con"] = [[You can report bugs or left feedback at this sites:

http://www.computercraft.info/forums2/index.php?/topic/27327-mynaptic-a-gui-for-packman/

https://github.com/Wilma456/Computercraft/issues]]

helpta[8] = {}
helpta[8]["titel"] = "Use Mynaptic in your OS"
helpta[8]["con"] = [[If you use packman in your OS, you may want to incluse Mynaptic. You have my permission to do this. If you want to optimize Mynaptic for your OS, just write Wilma456 at the CC Forum a PM.]]

helpta[9] = {}
helpta[9]["titel"] = "About"
helpta[9]["con"] = "This is Mynaptic Version 3.0 made by Wilma456"
--End Help

function ioread()
 return "N"
end

local function nichts()
end

function shellresolve(ag)
shell.resolveProgram(ag)
end

local function setLineColor(text)
term.write( text .. string.rep( ' ', term.getSize() - #text ) )
print()
--local lccou = string.len(text)
--write(text)
--local looplc = true
--while looplc == true do
 --write(" ")
 -- lccou = lccou + 1
 -- if lccou == screenw then
  -- looplc = nil
  -- lccou = nil
 --end
--end
--print("")
end

local function drawLine(te)
term.setBackgroundColor(colors[config["notinstaledColour"]])
if statuscheck[te] == "instaled" then
  term.setBackgroundColor(colors[config["instaledColour"]])
elseif statuscheck[te] == "install" then
  term.setBackgroundColor(colors[config["installColour"]])
elseif statuscheck[te] == "remove" then
  term.setBackgroundColor(colors[config["removeColour"]])
end
ins,teb,ver = te:match("([^ ]+) ([^ ]+) ([^ ]+)")
if config["showRepository"] == "false" then
  repo,teb = wilmaapi.splitString(teb,"/")
end
if searchch == true then
  if string.find(te,search,1) == nil then
    --Problems with if not
  else
    if config["showVersion"] == "true" then
      setLineColor(teb.." "..ver)
    else
      setLineColor(teb)
    end
    checkta[checkcou] = te
    checkcou = checkcou + 1
  end
else
  if config["showVersion"] == "true" then
    setLineColor(teb.." "..ver)
  else
    setLineColor(teb)
  end
  checkta[checkcou] = te
  checkcou = checkcou + 1
end
end

local function drawMenu()
term.setTextColor(colors[config["textColour"]])
term.setBackgroundColor(colors[config["backgroundColour"]])
term.clear()
term.setCursorPos(1,1)
checkcou = 1
local loop = true
local lpos = 0
while loop == true do
if lpos == 0 then
  term.setBackgroundColor(colors[config["menuColour"]])
  setLineColor("Apply Fetch Update Config Help")
  --for 0,screenw,1 do
    --write(" ")
  --end
  term.setCursorPos(screenw,1)
  term.setBackgroundColor(colors[config["closeColour"]])
  print("X")
else
  drawLine(textta[tpos+lpos])
end
  lpos = lpos + 1
  if lpos == screenh-1 then
    loop = nil
    lpos = nil
  end
end
term.setCursorPos(1,screenh)
term.setBackgroundColor(colors[config["backgroundColour"]])
write("Search: "..search)
end

function doChanges()
term.setBackgroundColor(colors.white)
term.clear()
term.setCursorPos(1,1)
installta = {}
removeta = {}
print("These Packages will be installed:")
for _,text in ipairs(install["list"]) do
  if install["check"][text] == true then
    ins,pack = wilmaapi.splitString(text," ")
    table.insert(installta,pack)
    print(pack)
  end
end
print("These Packages will be removed:")
for _,text in ipairs(remove["list"]) do
  if remove["check"][text] == true then
    ins,pack = text:match("([^ ]+) ([^ ]+)")
    table.insert(removeta,pack)
    print(pack)
  end
end
term.setCursorPos(1,screenh)
--term.setTextColor(colors.yellow)
write("Cancel")
term.setCursorPos(screenw-1,screenh)
write("OK")
ev,mouse,x,y = os.pullEvent("mouse_click")
if y == screenh then 
  if x < 7 then
    term.setBackgroundColor(colors.black)
    term.clear()
    term.setCursorPos(1,1)
  elseif x == screenw then
    term.clear()
    term.setCursorPos(1,1)
    if config["writeHistory"] == "true" then
      history = fs.open(config["historyPath"],"a")
    end
    sandta = {io={write=nichts,read=ioread},shell = shell}
    for _,pack in ipairs(installta) do
      print("Install "..pack)
      os.run(sandta,config["packmanPath"],"force","install",pack)
      if config["writeHistory"] == "true" then
        history.writeLine("Installed "..pack)
      end
      term.setBackgroundColor(colors.white)
      term.setTextColor(colors.black)
    end
    for _, pack in ipairs(removeta) do
      print("Remove "..pack)
      os.run(sandta,config["packmanPath"],"force","remove",pack)
      term.setBackgroundColor(colors.white)
      term.setTextColor(colors.black)
      if config["writeHistory"] == "true" then
        history.writeLine("Removed "..pack)
      end
    end
    if config["writeHistory"] == "true" then
      history.close()
    end
    term.setBackgroundColor(colors.black)
    term.clear()
    term.setCursorPos(1,1)
  end
end
end

local function printcol(text)
term.setTextColor(colors.black)
term.setBackgroundColor(colors.white)
print(text)
end

local function reload()
term.setBackgroundColor(colors.white)
term.clear()
term.setCursorPos(1,1)
reta = {shell=shell,io={write=printcol}}
os.run(reta,config["packmanPath"],"fetch")
term.setBackgroundColor(colors.black)
term.setTextColor(colors.white)
term.clear()
term.setCursorPos(1,1)
end

local function updatemenu()
term.setTextColor(colors.white)
term.clear()
term.setCursorPos(1,1)
print("This packages will be updated:")
for _,ucon in ipairs(updateta) do
print(ucon)
end
term.setCursorPos(1,screenh)
write("Cancel")
term.setCursorPos(screenw-1,screenh)
write("OK")
local loop = true
while loop do
ev,me,x,y = os.pullEvent("mouse_click")
if y == screenh then
  if x < 7 then
    term.setBackgroundColor(colors.black)
    term.setTextColor(colors.white)
    term.clear()
    term.setCursorPos(1,1)
    loop = nil
  elseif x > screenw - 2 then
    local runsa = {}
    term.clear()
    term.setCursorPos(1,1)
    runsa.shell = shell
    runsa.io = {write = nichts}
    for _,una in ipairs(updateta) do
      print("Updateting "..una)
      os.run(runsa,config["packmanPath"],"force","update",una)
    end
    print("Done!")
    loop = nil
    term.setBackgroundColor(colors.black)
    term.setTextColor(colors.white)
    term.clear()
    term.setCursorPos(1,1)
  end
end
end
end

local function getPackInfo(ypos)
term.setBackgroundColor(colors.white)
term.clear()
term.setCursorPos(1,1)
local updatetext = "No"
local installtest = "No"
if string.byte(textta[tpos+ypos],1) == 85 then --U
  updatetext = "Yes"
  installtest = "Yes"
elseif string.byte(textta[tpos+ypos],1) == 73 then
  installtest = "Yes"
end
local getname = textta[tpos+ypos]:sub(3,-1)
getname = wilmaapi.splitString(getname," ")
print("Name: "..getname)
print("Installed: "..installtest)
print("Update aviable: "..updatetext)
if not(type(packinfo[getname]["target"]) == "string") then
  print("Target: /usr/bin")
else
  print("Target: "..packinfo[getname]["target"])
end
print("Filename: "..packinfo[getname]["filename"])
print("Size: "..packinfo[getname]["size"])
print("Version: "..packinfo[getname]["version"])
print("Category: "..packinfo[getname]["category"])
write("Dependencies: ")
for _,depname in ipairs(packinfo[getname]["dependencies"]) do
write(depname.." ")
end
print()
print()
print("Press any Key to continue")
os.pullEvent("key_up")
drawMenu()
end

local function configNormal(entry)
term.clear()
term.setCursorPos(1,1)
print("Please enter new entry")
print()
print("Old: "..config[entry])
print()
write("New Entry:")
config[entry] = read()
configScreen()
end

local function configColor(entry)
term.clear()
term.setCursorPos(1,1)
print("Please select a Colour")
print()
print("Old: "..config[entry])
print()
local colorta = {}
for ind in pairs(colors) do
  if type(colors[ind]) == "number" then
    term.setBackgroundColor(colors[ind])
    write(" ")
    table.insert(colorta,ind)
  end
end
while true do
ev,me,x,y = os.pullEvent("mouse_click")
if y == 5 then
  if type(colorta[x]) == "string" then
    config[entry] = colorta[x]
    break
  end
end
end
configScreen()
end

local function configBool(entry)
term.clear()
term.setCursorPos(1,1)
print("Please choice new entry")
print()
print("Old: "..config[entry])
print()
term.setTextColor(colors.green)
write("true ")
term.setTextColor(colors.red)
write("false")
term.setTextColor(colors.black)
while true do
local ev,me,x,y = os.pullEvent("mouse_click")
if y == 5 then
  if x < 5 then
    config[entry] = "true"
    break
  elseif x > 5 and x < 11 then
    config[entry] = "false"
    break
  end   
end
end
configScreen()
end

function configScreen()
term.setBackgroundColor(colors.white)
term.clear()
term.setCursorPos(1,1)
for _,conname in ipairs(configed) do
  print(conname.name)
end
term.setCursorPos(1,screenh)
write("OK")
configloop = true
while configloop == true do
local ev,me,x,y = os.pullEvent("mouse_click")
if y == screenh then
  configloop = nil
  break
elseif type(configed[y]) == "table" then
  if configed[y]["contype"] == "col" then
    configColor(configed[y]["name"])
  elseif configed[y]["contype"] == "bool" then
    configBool(configed[y]["name"])
  else
    configNormal(configed[y]["name"])
  end
end
end
--write config
local writecon = io.open("/etc/mynaptic","w")
for ind,con in pairs(config) do
  writecon:write(ind.." "..con.."\n")
end
writecon:close()
--loop = nil
--term.setBackgroundColor(colors.black)
--term.setTextColor(colors.white)
--term.clear()
drawMenu()
end

local function helpList()
term.setBackgroundColor(colors.white)
term.clear()
term.setCursorPos(1,1)
for _,helpna in ipairs(helpta) do
  print(helpna["titel"])
end
term.setCursorPos(1,screenh)
write("OK")
end

local function showHelp(num)
term.clear()
term.setCursorPos(1,1)
print(helpta[num]["con"])
print()
print("Press any key to continue")
end

local function helpMenu()
helpList()
while true do
local ev,me,x,y = os.pullEvent("mouse_click")
if y == screenh then
  drawMenu()
  break
elseif type(helpta[y]) == "table" then
  showHelp(y)
  os.pullEvent("key_up")
  helpList()
end
end
end

local function testConfig(name,contype)
if not (type(config[name]) == "string") then
print("There is no config entry for "..name) 
configstatus = false
elseif contype == "bool" then
  if not (config[name] == "true" or config[name] == "false") then
  print("The config entry for "..name.." is not true/false")
  configstatus = false
  end 
elseif contype == "col" then
  if not (type(colors[config[name]]) == "number") then
    print("There is no existing Colour in the config entry for "..name)
    configstatus = false
  end
end
local tmpta = {}
tmpta.contype = contype
tmpta.name = name
tmpta.con = config[name]
table.insert(configed,tmpta)
end

local function deleteVars()
textta = nil
statuscheck = nil
remove = nil
install = nil
checkta = nil
config = nil
search = nil
searchch = nil
configstatus = nil
configed = nil
configloop = nil
configScreen = nil
end

textta = {}
statuscheck = {}
remove = {}
install = {}
checkta = {}
config = {}
configed = {}
install["list"] = {}
install["check"] = {}
remove["list"] = {}
remove["check"] = {}
searchch = false
search = ""
configstatus = true
updateta = {}

--Read Config
if fs.exists("/etc/mynaptic") == true then
confile = fs.open("/etc/mynaptic","r")
local loop = true
while loop == true do
  text = confile.readLine()
  if text == nil then
    loop = nil
  else
    head,cont = wilmaapi.splitString(text," ")
    if type(head) == "string" then
      config[head] = cont
    end
  end
end
else
confile = fs.open("/etc/mynaptic","w")
confile.writeLine("showVersion false")
confile.writeLine("showRepository true")
confile.writeLine("writeHistory true")
confile.writeLine("sortAlphabetically false")
confile.writeLine("showWelcomeScreen false")
confile.writeLine("historyPath /var/history")
confile.writeLine("packmanPath /usr/bin/packman")
confile.writeLine("textColour black")
confile.writeLine("backgroundColour gray")
confile.writeLine("menuColour blue")
confile.writeLine("closeColour red")
confile.writeLine("notinstaledColour white")
confile.writeLine("instaledColour green")
confile.writeLine("installColour orange")
confile.writeLine("removeColour red")
confile.close()
config["showVersion"] = "false"
config["showRepository"] = "true"
config["writeHistory"] = "true"
config["sortAlphabetically"] = "false"
config["showWelcomeScreen"] = "true"
config["historyPath"] = "/var/history"
config["packmanPath"] = "/usr/bin/packman"
config["backgroundColour"] = "gray"
config["menuColour"] = "blue"
config["closeColour"] = "red"
config["notinstaledColour"] = "white"
config["instaledColour"] = "green"
config["installColour"] = "orange"
config["removeColour"] = "red"
config["textColour"] = "black"
end

term.setTextColor(colors.red)
testConfig("showVersion","bool") 
testConfig("showRepository","bool")
testConfig("sortAlphabetically","bool")
testConfig("showWelcomeScreen","bool")
testConfig("historyPath")
testConfig("packmanPath")
testConfig("backgroundColour","col")
testConfig("menuColour","col")
testConfig("closeColour","col")
testConfig("notinstaledColour","col")
testConfig("instaledColour","col")
testConfig("installColour","col")
testConfig("removeColour","col")
testConfig("textColour","col")
term.setTextColor(colors.white)


if configstatus == false then
print("There are problems with your config. Please read the Errors. If you haven't change the config, you can delete it by run delete /etc/mynaptic and the the config will be rubuild by the next start")
deleteVars()
return 4
end

if fs.exists(config["packmanPath"]) == false then
  term.setTextColor(colors.red)
  print("Can't found Packman. If packman are installed, please change the Path in /etc/mynaptic")
  return 5
end

sandio = {write = getPrint}
sandsh = {resolveProgram = shellresolve}
sandta = {io = sandio,shell = sandsh}
--sandta = {print = getPrint,io = {write = getPrint}}
--sandta...] = "test"
--file = fs.open("/log","w")
rcou = 1
packlist = fs.open("/tmp/packlistsy.tmp","w")
os.run(sandta,config["packmanPath"],"search")
--print(rcou)
packlist.close()
packread = fs.open("/tmp/packlistsy.tmp","r")
packread.readLine()
packread.readLine()

local loop = true
local packcou = 1
while loop == true do
  textta[packcou] = packread.readLine()
  packread.readLine()
  --if string.byte(textta[packcou],1) == 73 then
   -- statuscheck[textta[packcou]] = "instaled"
  --end
  packcou = packcou + 1
  if packcou+1 == rcou then
    loop = nil
    --packcou = nil
  end
  --if string.byte(textta[packcou],1) == 73 then
   -- statuscheck[textta[packcou]] = "instaled"
 -- end
  --packcou = packcou + 1
end
packread.close()
fs.delete("/tmp/packlistsy.tmp")

for _,str in ipairs(textta) do
  if string.byte(str,1) == 73 then
    statuscheck[str] = "instaled"
  end
end

if config["sortAlphabetically"] == "true" then
  table.sort(textta)
end

--Get the updates
local function getUpdatePrint(text)
updatetmp.writeLine(text)
end

local function lookUpdates()
local updatesa = {}
updatesa.shell = shell
updatesa.io = {write = getUpdatePrint,read = ioread}
updatetmp = fs.open("/tmp/update.tmp","w")
os.run(updatesa,config["packmanPath"],"update")
updatetmp.close()
updatere = fs.open("/tmp/update.tmp","r")
updatere.readLine()
updatere.readLine()
local updatelist = updatere.readLine()
updatere.close()
fs.delete("/tmp/update.tmp")
if updatelist:find("Nothing") == 1 then
  return
end
updatelist = updatelist:sub(41,-1)
local returnstr = ""
for i = 1,#updatelist do
local c = updatelist:sub(i,i)
if c == " " then
  table.insert(updateta,returnstr)
  returnstr = ""
else
 returnstr = returnstr..c
end
end
--table.insert(updateta,returnstr)
end

lookUpdates()

--Welcome Screen
if config["showWelcomeScreen"] == "true" then
term.setBackgroundColor(colors.white)
term.setTextColor(colors.black)
term.clear()
term.setCursorPos(1,1)
print("Welcome to Mynaptic!")
print()
print("This Programm is a GUI for Packman, the awesome package manager from lyqyd. It will help you to manage your packages. To get startet, just click \"Help\" at the menu bar.")
print()
print("Press any key to continue")
os.pullEvent("key_up")
os.pullEvent("key_up")
end
--os.pullEvent("key_up")
tpos = 1
drawMenu()
--statuscheck = {}
local function mainMenu()
local mainloop = true
while mainloop == true do
  ev,me,x,y = os.pullEvent()
  if ev == "mouse_scroll" then
    if me == 1 then
     if not(tpos+screenh == packcou) then
      tpos = tpos + 1
      drawMenu()
     end
    elseif me == -1 then
       if not(tpos == 1) then
         tpos = tpos - 1
         drawMenu()
       end
    end
  elseif ev == "mouse_click" then
  --Leftclick
  if me == 1 then
  if y == 1 then
    if x > 0 and x < 6 then
      mainloop = nil
      doChanges()
    elseif x > 6 and x < 12 then
      mainloop = nil
      reload()
    elseif x > 12 and x < 19 then
      mainloop = nil
      updatemenu()
    elseif x > 19 and x < 26 then
      configScreen()
    elseif x > 26 and x < 31 then
      helpMenu()
    elseif x == screenw then
      mainloop = nil
      term.setBackgroundColor(colors.black)
      term.setTextColor(colors.white)
      term.clear()
      term.setCursorPos(1,1)
    end
  else
    clickpos = y-1
    local strte = checkta[clickpos]
    if statuscheck[strte] == "instaled" then
      statuscheck[strte] = "remove"
      table.insert(remove["list"],strte)
      remove["check"][strte] = true
    elseif statuscheck[strte] == "remove" then
      statuscheck[strte] = "instaled"
      remove["check"][strte] = false
    elseif statuscheck[strte] == "install" then
      statuscheck[strte] = "notinstaled"
      install["check"][strte] = false
    else
      statuscheck[strte] = "install"
      table.insert(install["list"],strte)
      install["check"][strte] = true
    end
    drawMenu()
  end
  elseif me == 2 then
    if not(y==1) then
      if not(y==screenh) then
        getPackInfo(y-1)
      end
    end
  end
  elseif ev == "char" then
    searchch = true
    search = search..me
    drawMenu()
  elseif ev == "key_up" then
    if me == keys.backspace then
      search = string.sub(search,1,-2)
      drawMenu()
    elseif me == keys.down then
      if not(tpos+screenh == packcou) then
      tpos = tpos + 1
      drawMenu()
     end
    end
    elseif me == keys.up then
     if not(tpos == 1) then
         tpos = tpos - 1
         drawMenu()
       end
    --end
  end
end
end
mainMenu()

deleteVars()

return 0
--Thanks for using this Programm and reading the
--source code
