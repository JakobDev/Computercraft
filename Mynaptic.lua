--Made by Wilma456
print("Starting Mynaptic Please Wait ...")

os.loadAPI("/usr/apis/wilmaapi")
os.loadAPI("/usr/apis/clipboard")
--os.loadAPI("package")

if term.isColor() == false or pocket then
  print("This Programm only run on a Advanced Computer or a Advaced Turtle")
  return 2
end

if wilmaapi == nil then
  term.setTextColor(colors.red)
  print("Error whith loading wilmaapi")
  return 3
end

if clipboard == nil then
  term.setTextColor(colors.red)
  print("Error whith loading clipboard API")
  return 3
end

mynaptic = {}

mynaptic.version = 6.1

mynaptic.shellmode = false

local packinfo = wilmaapi.readPackmanRepo()
--print("If Mynaptic does not start and you see this errot, try to delete /etc/mynaptic")
function getPrint(text)
packlist.writeLine(text)
rcou = rcou + 1
end

local screenw,screenh = term.getSize()
mynaptic.screenw = screenw
mynaptic.screenh = screenh

--Write lang
lang = {}
lang["keyContinue"] = "Press any Key to continue"
lang["search"] = "Search:"
lang.shell = "Shell:"
lang.noCommand = "Command not found"
lang.packNotFound = "Package not found"
lang.cancel = "Cancel"
lang.ok = "OK"
lang.apply = "Apply"
lang.fetch = "Fetch"
lang.update = "Update"
lang.config = "Config"
lang.help = "Help"
lang.yes = "Yes"
lang.no = "No"
lang.name = "Name:"
lang.installed = "Installed:"
lang.updateAviable = "Update aviable:"
lang.filename = "Filename:"
lang.target = "Target:"
lang.size = "Size:"
lang.version = "Version:"
lang.category = "Category:"
lang.dependencies = "Dependencies:"
lang.none = "None"
lang.installPack = "These Packages will be installed:"
lang.removePack = "These Packages will be removed:"
lang.updatePack = "These Packages will be updated:"
lang.youEdit = "You Edit:"
lang.old = "Old:"
lang.selectColour = "Please select a Colour"
lang.newEntry = "New Entry:"
lang.newEntryText = "Please enter new Entry"
lang.boolEntry = "Please choose new Entry"
lang.keyEntry = "Please choose a new Key"
lang.back = "Back"
lang.history = "History"
lang.clear = "Clear"
lang.exitText = "Thank you for using Mynaptic!"
--Start Help
local tmpta = {}

helpta = {}

tmpta.titel = "What is Packman and Mynaptic"
tmpta.con = [[Packman is a package manager like apt made by Lyqyd. It allows you to easy install,remove and update programs.

Mynaptic is a GUI for Packman made by Wilma456]]

table.insert(helpta,tmpta)
 
tmpta = {}
tmpta["titel"] = "Navigate"
tmpta["con"] = [[Use the mousewhell or the arrow keys to scroll. You can mark packages by leftclicking it.

Exit Mynaptic by clicking to "X" in to right up corner
To use the search, just write your text

You can scroll in many menus.
]]

table.insert(helpta,tmpta)

tmpta = {}
tmpta["titel"] = "Install Software"
tmpta["con"] = [[The white software are not installed. Click on it to mark it to install.

If you have choose your software, just click "Apply"
]]

table.insert(helpta,tmpta)

tmpta = {}
tmpta["titel"] = "Remove Software"
tmpta["con"] = [[The red software are installed. Click on it to mark it to remove.

If you have choose your software, just click "Apply"
]]

table.insert(helpta,tmpta)

tmpta = {}
tmpta["titel"] = "Get more Information"
tmpta["con"] = "If you want more information about a package, just rightclick it"

table.insert(helpta,tmpta)

tmpta = {}
tmpta["titel"] = "Use History"
tmpta["con"] = [[In the default config, Mynaptic write all changes to the file /var/MynapticHistory.txt. To view the content of the file, use the Historymenu.]]

table.insert(helpta,tmpta)

tmpta = {}
tmpta.titel = "Use Clipboard"
tmpta.con = [[You can use the system clipboard by pressing Ctrl+V

You can use the clipboard from the clipboard API by pressing the mousewhell
]]

table.insert(helpta,tmpta)

tmpta = {}
tmpta["titel"] = "Personalisierte Mynaptic"
tmpta["con"] = [[You can change the Config with the "config" Menu or by editing /etc/mynaptic

Mynaptic checks every run, if the config correct.

If you get any config errors by runing Mynaptic (maybe after update) and don't want to fix it, just delete /etc/mynaptic. If the config file not exists, Mynaptic will create them by running

Lines in /etc/mynaptic who are started with # are ignored.
]]

table.insert(helpta,tmpta)

tmpta = {}
tmpta.titel = "Move Items in the Menubar"
tmpta.con = "You can move Items in the Menubar by drag and drop them with the right Mousebutton. The Position is not saved, so it get lost with closing Mynaptic."
table.insert(helpta,tmpta)

tmpta = {}
tmpta["titel"] = "On what Devices run Mynaptic"
tmpta["con"] = [[Mynaptic fully supports Advanced Computers

On Turtles you haave only the main function. You don't have acces to the config or help menu

Other Devices are not supported]]

table.insert(helpta,tmpta)

tmpta = {}
tmpta["titel"] = "Using Plugins"
tmpta["con"] = [[With Plugins you can modify Mynaptic e.g another language or another package system

Simple place Plugins in the pluginFoler (default /usr/share/mynaptic/plugins) and be sure, thet loadPlugins is true
]]

table.insert(helpta,tmpta)

tmpta = {}
tmpta.titel = "Add your Program"
tmpta.con = "To add your Program to Packman/Mynaptic visit https://github.com/lyqyd/cc-packman and follow the instructions"
table.insert(helpta,tmpta)

tmpta = {}
tmpta["titel"] = "Report Bugs/Feedback"
tmpta["con"] = [[You can report bugs or left feedback at this sites:

http://www.computercraft.info/forums2/index.php?/topic/27327-mynaptic-a-gui-for-packman/

https://github.com/Wilma456/Computercraft/issues]]

table.insert(helpta,tmpta)

tmpta = {}
tmpta["titel"] = "Use Mynaptic in your OS"
tmpta["con"] = [[If you use packman in your OS, you may want to incluse Mynaptic. You have my permission to do this. If you want to optimize Mynaptic for your OS, just write Wilma456 at the CC Forum a PM.]]

table.insert(helpta,tmpta)

tmpta = {}
tmpta.titel = "License"
tmpta.con = 'Mynaptic is licesed under the BSD 2-clause "Simplified" License. For more information look at https://github.com/Wilma456/Computercraft/blob/master/LICENSE'
table.insert(helpta,tmpta)

tmpta = {}
tmpta["titel"] = "About"
tmpta["con"] = "This is Mynaptic Version "..mynaptic.version.." made by Wilma456"

table.insert(helpta,tmpta)

tmpta = nil
--End Help

--Shellcommands
shellcom = {}

function shellcom.update()
  mynaptic.updatemenu()
end

function shellcom.top()
  tpos = 0
  mynaptic.drawMenu()
end

function shellcom.debug()
  mynaptic.debugmenu()
end

function shellcom.bottom()
  tpos = packcou - screenh + 1
  mynaptic.drawMenu()
end

function shellcom.apply()
  mynaptic.doChanges()
end

function shellcom.fetch()
  mynaptic.reload()
end

function shellcom.about()
  mynaptic.setShellText("Mynaptic Version "..mynaptic.version.." made by Wilma456")  
end
--End Shellcommands

function ioread()
 return "N"
end

local function nichts()
end

function shellresolve(ag)
shell.resolveProgram(ag)
end

function mynaptic.setShellText(text)
term.setCursorPos(1,screenh)
term.clearLine()
write(text)
end

function mynaptic.setLineColor(text,arrow)
if type(text) == "string" then
--term.write( text .. string.rep( ' ', term.getSize() - #text ) )
term.clearLine()
term.write(text)
local x,y = term.getCursorPos()
term.setCursorPos(mynaptic.screenw,y)
term.write(arrow)
print()
end
end

function mynaptic.drawLine(te,arrow)
if te == nil then
  return
end
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
if config["showVersion"] == "true" then
  mynaptic.setLineColor(teb.." "..ver,arrow)
else
  mynaptic.setLineColor(teb,arrow)
end
checkta[checkcou] = te
checkcou = checkcou + 1
end

function mynaptic.drawMenu()
term.setTextColor(colors[config["textColour"]])
term.setBackgroundColor(colors[config["backgroundColour"]])
term.clear()
term.setCursorPos(1,1)
checkcou = 1
term.setBackgroundColor(colors[config["menubarColour"]])
local menutext = ""
for key,menuitem in ipairs(mynaptic.menubar) do
    menutext = menutext..menuitem.text.." "
end
mynaptic.setLineColor(menutext)
term.setCursorPos(screenw,1)
term.setBackgroundColor(colors[config["closeColour"]])
print("X")
if tpos ~= 0 and config.showScrollArrows == "true" then
   mynaptic.drawLine(textta[tpos+1],"\30")
else
    mynaptic.drawLine(textta[tpos+1]," ")
end
for i=3,mynaptic.screenh-2 do
    mynaptic.drawLine(textta[tpos+i-1]," ")
end
if tpos+screenh ~= packcou+1 and config.showScrollArrows == "true" then
   mynaptic.drawLine(textta[tpos+mynaptic.screenh-2],"\31")
else
    mynaptic.drawLine(textta[tpos+mynaptic.screenh-2]," ")
end
term.setCursorPos(1,screenh)
term.setBackgroundColor(colors[config["searchColour"]])
term.write(string.rep( ' ', term.getSize()))
term.setCursorPos(1,screenh)
if mynaptic.shellmode == true then
  write(lang.shell..shelltext)
else
  write(lang.search..search)
end
end

helpta["egg"] = {}

function mynaptic.doChanges()
term.setBackgroundColor(colors[config.menuBackgroundColour])
term.setTextColor(colors[config.menuTextColour])
term.clear()
term.setCursorPos(1,1)
installta = {}
removeta = {}
print(lang.installPack)
for _,text in ipairs(install["list"]) do
  if install["check"][text] == true then
    ins,pack = wilmaapi.splitString(text," ")
    table.insert(installta,pack)
    print(pack)
  end
end
print(lang.removePack)
for _,text in ipairs(remove["list"]) do
  if remove["check"][text] == true then
    ins,pack = text:match("([^ ]+) ([^ ]+)")
    table.insert(removeta,pack)
    print(pack)
  end
end
term.setBackgroundColor(colors[config.bottomBarColour])
term.setCursorPos(1,mynaptic.screenh)
term.clearLine()
write(lang.cancel)
term.setCursorPos(mynaptic.screenw-1,mynaptic.screenh)
write(lang.ok)
term.setBackgroundColor(colors[config.menuBackgroundColour])
ev,mouse,x,y = os.pullEvent("mouse_click")
if y == screenh then 
  if x < 7 then
    mynaptic.drawMenu()
  elseif x == screenw then
    term.clear()
    term.setCursorPos(1,1)
    if config["writeHistory"] == "true" then
      history = fs.open(config["historyPath"],"a")
    end
    sandta = {io={write=nichts,read=ioread},shell = shell}
    for _,pack in ipairs(installta) do
      print("Install "..pack)
      shell.run(config["packmanPath"].." auto install "..pack)
	  statuscheck["A "..pack.." "..package.list[pack]["version"]] = "instaled"
      if config["writeHistory"] == "true" then
        history.writeLine("Installed "..pack)
      end
      term.setBackgroundColor(colors.white)
      term.setTextColor(colors.black)
    end
    for _, pack in ipairs(removeta) do
      print("Remove "..pack)
      shell.run(config["packmanPath"].. " auto remove "..pack) 
      statuscheck["I "..pack.." "..package.list[pack]["version"]] = "notinstaled"
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
    mynaptic.drawMenu()
  end
end
install = {}
install.list = {}
install.check = {}
remove = {}
remove.list = {}
remove.check = {}
end

helpta["egg"]["con"] = "You found a EasterEgg!"

function mynaptic.printcol(text)
term.setTextColor(colors.black)
term.setBackgroundColor(colors.white)
print(text)
end

function mynaptic.reload()
term.setBackgroundColor(colors.white)
term.clear()
term.setCursorPos(1,1)
reta = {shell=shell,io={write=printcol}}
shell.run(config.packmanPath.." fetch")
term.setBackgroundColor(colors.black)
term.setTextColor(colors.white)
term.clear()
term.setCursorPos(1,1)
mynaptic.drawMenu()
end

function mynaptic.updatemenu()
term.setBackgroundColor(colors.white)
term.setTextColor(colors.black)
term.clear()
term.setCursorPos(1,1)
shell.run(config.packmanPath.." auto update")
print()
print(lang.keyContinue)
os.pullEvent("key")
mynaptic.drawMenu()
end

function mynaptic.debugmenu()
term.setBackgroundColor(colors.white)
term.clear()
term.setCursorPos(1,1)
local debughis = {}
print("Call exit() to exit")
while true do
write(">")
local re = read(nil,debughis)
if re == "exit()" then
  break
else
  table.insert(debughis,re)
  load(re,nil,nil,_ENV)()
end
end
mynaptic.drawMenu()
end

function mynaptic.getPackInfo(ypos)
term.setBackgroundColor(colors.white)
term.clear()
term.setCursorPos(1,1)
local getname = textta[tpos+ypos]:sub(3,-1)
getname = wilmaapi.splitString(getname," ")
if package.list[getname] == nil then
  print("Error while getting Information")
  print()
  print(lang["keyContinue"])
  os.pullEvent("key_up")
  mynaptic.drawMenu()
  return
end
local updatetext = lang.no
local installtest = lang.no
if string.byte(textta[tpos+ypos],1) == 85 then --U
  updatetext = lang.yes
  installtest = lang.yes
elseif string.byte(textta[tpos+ypos],1) == 73 then
  installtest = lang.yes
end
local getname = textta[tpos+ypos]:sub(3,-1)
getname = wilmaapi.splitString(getname," ")
print(lang.name.." "..tostring(getname))
print(lang.installed.." "..tostring(installtest))
print(lang.target.." "..package.list[getname]["target"])
print(lang.filename.." "..tostring(package.list[getname]["download"]["type"]["filename"]))
print(lang.size.." "..tostring(package.list[getname]["size"]).." Bytes")
print(lang.version.." "..tostring(package.list[getname]["version"]))
io.write(lang.category.. " ")
for cate,_ in pairs(package.list[getname]["category"]) do
	io.write(cate.." ")
end
io.write("\n")
local testdep = false
local getdep = package.list[getname]["dependencies"]
getdep[getname] = nil
io.write(lang.dependencies.." ")
for dep,_ in pairs(getdep) do
  io.write(dep.." ")
  testdep = true
end
if testdep == false then
  io.write(lang.none)
end
io.write("\n")
print()
print(lang["keyContinue"])
os.pullEvent("key_up")
mynaptic.drawMenu()
end

function mynaptic.configNormal(entry)
term.clear()
term.setCursorPos(1,1)
print(lang.newEntryText)
print()
print(lang.youEdit.." "..entry)
print()
print(lang.old.." "..config[entry])
print()
write(lang.newEntry)
local input = read()
if not(input=="") then
  config[entry] = input
end
--mynaptic.configScreen()
end

function mynaptic.configColor(entry)
term.clear()
term.setCursorPos(1,1)
print(lang.selectColour)
print()
print(lang.youEdit.." "..entry)
print()
print(lang.old.." "..config[entry])
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
if y == 7 then
  if type(colorta[x]) == "string" then
    config[entry] = colorta[x]
    break
  end
end
end
--mynaptic.configScreen()
end

function mynaptic.configBool(entry)
term.clear()
term.setCursorPos(1,1)
print(lang.boolEntry)
print()
print(lang.youEdit.." "..entry)
print()
print(lang.old.." "..config[entry])
print()
term.setTextColor(colors.green)
write("true ")
term.setTextColor(colors.red)
write("false")
term.setTextColor(colors.black)
while true do
local ev,me,x,y = os.pullEvent("mouse_click")
if y == 7 then
  if x < 5 then
    config[entry] = "true"
    break
  elseif x > 5 and x < 11 then
    config[entry] = "false"
    break
  end   
end
end
--mynaptic.configScreen()
end

function mynaptic.configKey(entry)
term.clear()
term.setCursorPos(1,1)
print(lang.keyEntry)
print()
print(lang.youEdit.." "..entry)
print()
print(lang.old.." "..config[entry])
print()
local ev,me = os.pullEvent("key_up")
config[entry] = keys.getName(me)
--mynaptic.configScreen()
end

function mynaptic.configScreen()
local configpos = 0
--Configloop
while true do
term.setBackgroundColor(colors[config.menuBackgroundColour])
term.setTextColor(colors[config.menuTextColour])
term.clear()
term.setCursorPos(1,1)
for i=1,mynaptic.screenh-1 do
  if type(configed[i+configpos]) == "table" then
    print(configed[i+configpos]["name"])
  end
end
term.setCursorPos(1,mynaptic.screenh)
term.setBackgroundColor(colors[config.bottomBarColour])
term.clearLine()
write("OK")
term.setBackgroundColor(colors[config.menuBackgroundColour])
if config.showScrollArrows == "true" then
  if configpos ~= 0 then
    term.setCursorPos(mynaptic.screenw,1)
    term.write("\30")
  end
  if mynaptic.configcou ~= configpos+mynaptic.screenh-1 then
    term.setCursorPos(mynaptic.screenw,mynaptic.screenh-1)
    term.write("\31")
  end
end
local ev,me,x,y = os.pullEvent()
if ev == "mouse_scroll" or ev == "key" then
  if me == 1 or me == keys[config.scrollDownKey] then
    if mynaptic.configcou ~= configpos+mynaptic.screenh-1 then
      configpos = configpos + 1
    end
  elseif me == -1 or me == keys[config.scrollUpKey] then
    if configpos ~= 0 then
      configpos = configpos - 1
    end
  end
elseif ev == "mouse_click" then
  if y == mynaptic.screenh then
    configloop = nil
    break
  elseif type(configed[configpos+y]) == "table" then
    if configed[configpos+y]["contype"] == "col" then
      mynaptic.configColor(configed[configpos+y]["name"])
    elseif configed[configpos+y]["contype"] == "bool" then
      mynaptic.configBool(configed[configpos+y]["name"])
    elseif configed[configpos+y]["contype"] == "key" then
      mynaptic.configKey(configed[configpos+y]["name"])
    else
      mynaptic.configNormal(configed[configpos+y]["name"])
    end
  end
end
end
--write config
local writecon = io.open("/etc/mynaptic","w")
for ind,con in pairs(config) do
  writecon:write(ind.." "..con.."\n")
end
writecon:close()
mynaptic.drawMenu()
end

function mynaptic.helpList()
term.setBackgroundColor(colors[config.menuBackgroundColour])
term.setTextColor(colors[config.menuTextColour])
term.clear()
term.setCursorPos(1,1)
for _,helpna in ipairs(helpta) do
  print(helpna["titel"])
end
term.setCursorPos(1,screenh)
term.setBackgroundColor(colors[config.bottomBarColour])
term.clearLine()
write("OK")
term.setBackgroundColor(colors[config.menuBackgroundColour])
end

function mynaptic.showHelp(num)
term.clear()
term.setCursorPos(1,1)
print(helpta[num]["con"])
print()
print(lang["keyContinue"])
end

function mynaptic.helpMenu()
mynaptic.helpList()
while true do
local ev,me,x,y = os.pullEvent()
if ev == "mouse_click" then
  if y == screenh then
    mynaptic.drawMenu()
    break
  elseif type(helpta[y]) == "table" then
    mynaptic.showHelp(y)
    os.pullEvent("key_up")
    mynaptic.helpList()
  end
elseif ev == "key_up" then
  if me == keys.backspace then
    mynaptic.drawMenu()
    break
  elseif me == keys.e then
    mynaptic.showHelp("egg")
    os.pullEvent("key_up")
    mynaptic.helpList()
  end  
end
end
end

function mynaptic.history()
term.setTextColor(colors[config.menuTextColour])
term.setBackgroundColor(colors[config.menuTextColour])
term.clear()
term.setCursorPos(1,1)
local hiscon = {}
local hiscou = 0
if fs.exists(config.historyPath) == true then
  local readhis = io.open(config.historyPath,"r")
  for linecon in readhis:lines() do
    table.insert(hiscon,linecon)
    hiscou = hiscou + 1
  end
  readhis:close()
else
  table.insert(hiscon,"History not found")
  hiscou = 1
end
local hispos = 0
while true do
  term.clear()
  term.setCursorPos(1,1)
  for i=1,mynaptic.screenh-1 do
    if type(hiscon[hispos+i]) == "string" then
      print(hiscon[hispos+i])
    end
  end
  if hispos ~= 0 and config.showScrollArrows == "true" then
    term.setCursorPos(mynaptic.screenw,1)
    term.write("\30")
  end
  if hiscou ~= hispos+mynaptic.screenh-1 and hiscou > mynaptic.screenh and config.showScrollArrows == "true" then
    term.setCursorPos(mynaptic.screenw,mynaptic.screenh-1)
    term.write("\31")
  end
  term.setCursorPos(1,mynaptic.screenh)
  term.setBackgroundColor(colors[config.bottomBarColour])
  term.clearLine()
  write(lang.back)
  term.setCursorPos(mynaptic.screenw-#lang.clear+1,mynaptic.screenh)
  write(lang.clear)
  term.setBackgroundColor(colors[config.menuBackgroundColour])
  local ev,me,x,y = os.pullEvent()
  if ev == "mouse_scroll" or ev == "key" then
    if me == -1 or me == keys[config.scrollUpKey] then
      if hispos > 0 then
        hispos = hispos - 1
      end
    elseif me == 1 or me == keys[config.scrollDownKey] then
      if hispos+mynaptic.screenh-1 < hiscou then
        hispos = hispos + 1
      end
    end
  elseif ev == "mouse_click" then
    if y == mynaptic.screenh then
      if x < #lang.back+1 then
        mynaptic.drawMenu()
        return
      elseif x > mynaptic.screenw-#lang.clear then
        hiscou = 1
        hispos = 0
        hiscon = {"History cleared"}
        fs.delete(config.historyPath)
      end
    end
  end
end
end

function mynaptic.writeSearch()
textta = {}
packcouba = packcou
packcou = 0
for _,sete in ipairs(backupta) do
  if not(sete:find(search)==nil) then
    table.insert(textta,sete)
    packcou = packcou + 1
  end
end
end

function mynaptic.testConfig(name,contype)
if not(type(config[name]) == "string") then
print("There is no config entry for "..name) 
configstatus = false
elseif contype == "bool" then
  if not(config[name] == "true" or config[name] == "false") then
  print("The config entry for "..name.." is not true/false")
  configstatus = false
  end 
elseif contype == "col" then
  if not(type(colors[config[name]]) == "number") then
    print("There is no existing Colour in the config entry for "..name)
    configstatus = false
  end
elseif contype == "key" then
  if type(keys[config[name]]) ~= "number" then
    print("The config entry for "..name.." is not a key")
    configstatus = false
  end
end
local tmpta = {}
tmpta.contype = contype
tmpta.name = name
tmpta.con = config[name]
table.insert(configed,tmpta)
mynaptic.configcou = mynaptic.configcou + 1
end

function mynaptic.deleteVars()
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
mynaptic = nil
shelltext = nil
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
shelltext = ""
configstatus = true
updateta = {}
mynaptic.configcou = 0

--Read Config
if fs.exists("/etc/mynaptic") == true then
confile = fs.open("/etc/mynaptic","r")
local loop = true
while loop == true do
  text = confile.readLine()
  if text == nil then
    loop = nil
  elseif not(text:find("#") == 1) then
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
confile.writeLine("loadPlugins true")
confile.writeLine("showExitText true")
confile.writeLine("showScrollArrows true")
confile.writeLine("pluginPath /usr/share/mynaptic/plugins")
confile.writeLine("historyPath /var/MynapticHistory.txt")
confile.writeLine("packmanPath /usr/bin/packman")
confile.writeLine("textColour black")
confile.writeLine("backgroundColour gray")
confile.writeLine("menubarColour blue")
confile.writeLine("closeColour red")
confile.writeLine("notinstaledColour white")
confile.writeLine("instaledColour green")
confile.writeLine("installColour orange")
confile.writeLine("removeColour red")
confile.writeLine("searchColour brown")
confile.writeLine("bottomBarColour blue")
confile.writeLine("menuBackgroundColour white")
confile.writeLine("menuTextColour black")
confile.writeLine("scrollUpKey up")
confile.writeLine("scrollDownKey down")
confile.writeLine("deleteKey backspace")
confile.writeLine("debugKey rightAlt")
confile.writeLine("shellSwitchKey leftCtrl")
confile.writeLine("completeKey tab")
confile.writeLine("shellRunKey enter")
confile.close()
config["showVersion"] = "false"
config["showRepository"] = "true"
config["writeHistory"] = "true"
config["loadPlugins"] = "true"
config["sortAlphabetically"] = "false"
config["showExitText"] = "true"
config.showScrollArrows = "true"
config["pluginPath"] = "/usr/share/mynaptic/plugins"
config["historyPath"] = "/var/MynapticHistory.txt"
config["packmanPath"] = "/usr/bin/packman"
config["backgroundColour"] = "gray"
config["menubarColour"] = "blue"
config["closeColour"] = "red"
config["notinstaledColour"] = "white"
config["instaledColour"] = "green"
config["installColour"] = "orange"
config["removeColour"] = "red"
config["textColour"] = "black"
config["searchColour"] = "brown"
config["bottomBarColour"] = "blue"
config.menuBackgroundColour = "white"
config.menuTextColour = "black"
config["scrollUpKey"] = "up"
config["scrollDownKey"] = "down"
config["deleteKey"] = "backspace"
config["debugKey"] = "rightAlt"
config["shellSwitchKey"] = "leftCtrl"
config["completeKey"] = "tab"
config["shellRunKey"] = "enter"
end

term.setTextColor(colors.red)
mynaptic.testConfig("showVersion","bool") 
mynaptic.testConfig("showRepository","bool")
mynaptic.testConfig("writeHistory","bool")
mynaptic.testConfig("sortAlphabetically","bool")
mynaptic.testConfig("loadPlugins","bool")
mynaptic.testConfig("showExitText","bool")
mynaptic.testConfig("showScrollArrows","bool")
mynaptic.testConfig("pluginPath")
mynaptic.testConfig("historyPath")
mynaptic.testConfig("packmanPath")
mynaptic.testConfig("backgroundColour","col")
mynaptic.testConfig("menubarColour","col")
mynaptic.testConfig("closeColour","col")
mynaptic.testConfig("notinstaledColour","col")
mynaptic.testConfig("instaledColour","col")
mynaptic.testConfig("installColour","col")
mynaptic.testConfig("removeColour","col")
mynaptic.testConfig("textColour","col")
mynaptic.testConfig("searchColour","col")
mynaptic.testConfig("bottomBarColour","col")
mynaptic.testConfig("menuBackgroundColour","col")
mynaptic.testConfig("menuTextColour","col")
mynaptic.testConfig("scrollUpKey","key")
mynaptic.testConfig("scrollDownKey","key")
mynaptic.testConfig("deleteKey","key")
mynaptic.testConfig("debugKey","key")
mynaptic.testConfig("shellSwitchKey","key")
mynaptic.testConfig("completeKey","key")
mynaptic.testConfig("shellRunKey","key")
term.setTextColor(colors.white)


if configstatus == false then
print("There are problems with your config. Please read the Errors. If you haven't change the config, you can delete it by run 'rm /etc/mynaptic' and the the config will be rubuild by the next start")
mynaptic.deleteVars()
return 4
end

if fs.exists(config["packmanPath"]) == false then
  term.setTextColor(colors.red)
  print("Can't found Packman. If packman are installed, please change the Path in /etc/mynaptic")
  return 5
end

--Add Menuitems
mynaptic.menubar = {}
table.insert(mynaptic.menubar,{text = lang.apply,func = mynaptic.doChanges})
table.insert(mynaptic.menubar,{text = lang.fetch,func = mynaptic.reload})
table.insert(mynaptic.menubar,{text = lang.update,func = mynaptic.updatemenu})
table.insert(mynaptic.menubar,{text = lang.config,func = mynaptic.configScreen})
table.insert(mynaptic.menubar,{text = lang.help,func = mynaptic.helpMenu})
table.insert(mynaptic.menubar,{text = lang.history,func = mynaptic.history})

textta = {}
packcou = 0
shell.run(config.packmanPath.." install")
for name,con in pairs(package.list) do
  if type(con.version) == "string" then
    if type(package.installed[name]) == "table" then
      table.insert(textta,"I "..name.." "..con.version)
      statuscheck["I "..name.." "..con.version] = "instaled"
    else
      table.insert(textta,"A "..name.." "..con.version)--" "..con.version)
    end
    packcou = packcou + 1
  end
end

if config["sortAlphabetically"] == "true" then
  table.sort(textta)
end

backupta = textta

--Load Plugins
if config["loadPlugins"] == "true" then

if fs.isDir(config.pluginPath) == true then
local pluginlist = fs.list(config.pluginPath)

for _,plugname in ipairs(pluginlist) do
  shell.run(config.pluginPath.."/"..plugname)
end
end

end

tpos = 0
mynaptic.drawMenu()
--statuscheck = {}
local function mainMenu()
local mainloop = true
while mainloop == true do
  ev,me,x,y = os.pullEvent()
  if ev == "mouse_drag" then
    if me == 2 then
      mynaptic.dragx = x
      mynaptic.dragy = y
    end
  elseif mynaptic.dragmode == true then
    if type(mynaptic.dragx) == "number" then
    if y == y then
      local coustr = 0
      for cou,con in ipairs(mynaptic.menubar) do
        local tmpta = con
        if mynaptic.dragx > coustr then
          if mynaptic.dragx < con.text:len()+coustr+1 then
            --table.insert(mynaptic.menubar,cou,mynaptic.menubar[mynaptic.menuitem])
            --table.remove(mynaptic.menubar,mynaptic.menuitem)
            mynaptic.menubar[cou] = mynaptic.menubar[mynaptic.menuitem]
            mynaptic.menubar[mynaptic.menuitem] = tmpta
            mynaptic.drawMenu()
          end
        end
        coustr = con.text:len()+coustr+1
      end
     end
     mynaptic.dragmode = false
     end
  elseif ev == "mouse_scroll" then
    if me == 1 then
     if not(tpos+screenh == packcou+1) then
      if packcou > screenh-2 then
        tpos = tpos + 1
        mynaptic.drawMenu()
      end
     end
    elseif me == -1 then
       if not(tpos == 0) then
         tpos = tpos - 1
         mynaptic.drawMenu()
       end
    end
  elseif ev == "mouse_click" then
  --Mousewheel
  if me == 3 then
    if mynaptic.shellmode == true then
      shelltext = shelltext..clipboard.getTextLine()
      mynaptic.drawMenu()
    else
      searchch = true
      search = search..clipboard.getTextLine()
      mynaptic.writeSearch()
      tpos = 0
      mynaptic.drawMenu()
    end
  --Leftclick
  elseif me == 1 then
  if y == 1 then
    --[[
    if x > 0 and x < lang.apply:len()+1 then
      --mainloop = nil
      mynaptic.doChanges()
    elseif x > lang.apply:len()+1 and x < lang.apply:len()+lang.fetch:len()+2 then
      mynaptic.reload()
    elseif x > lang.apply:len()+lang.fetch:len()+2 and x < lang.apply:len()+lang.fetch:len()+lang.update:len()+3 then
      mynaptic.updatemenu()
    elseif x > lang.apply:len()+lang.fetch:len()+lang.update:len()+3 and x < lang.apply:len()+lang.fetch:len()+lang.update:len()+lang.config:len()+4 then
      mynaptic.configScreen()
    elseif x > lang.apply:len()+lang.fetch:len()+lang.update:len()+lang.config:len()+4 and x < lang.apply:len()+lang.fetch:len()+lang.update:len()+lang.config:len()+lang.help:len()+5 then
      mynaptic.helpMenu()
    --]]
    if x == mynaptic.screenw then
      mainloop = nil
      term.setBackgroundColor(colors.black)
      term.setTextColor(colors.white)
      term.clear()
      term.setCursorPos(1,1)
      if config["showExitText"] == "true" then
        print(lang.exitText)
      end
    end
    local menupos = 0
    for key,menuitem in ipairs(mynaptic.menubar) do
      if x > menupos and x < menuitem.text:len()+menupos+1 then
        menuitem.func()
        break 
      else
        menupos = menupos+menuitem.text:len()+1
      end
    end
  elseif y == mynaptic.screenh then
    if mynaptic.shellmode == true then
      shelltext = ""
      mynaptic.drawMenu()
    else
      search = ""
      searchch = false
      mynaptic.writeSearch()
      tpos = 0
      mynaptic.drawMenu()
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
    mynaptic.drawMenu()
  end
  elseif me == 2 then
    if y == 1 then
      local coustr = 0
      for cou,con in ipairs(mynaptic.menubar) do
        if x > coustr then
          if x < con.text:len()+coustr+1 then
            mynaptic.menuitem = cou
            mynaptic.dragmode = true
          end
        end
        coustr = con.text:len()+coustr+1
      end
    elseif y == screenh then
      mynaptic.completemode = false
      if mynaptic.shellmode == true then
        shelltext = ""
        mynaptic.drawMenu()
      else
        searchch = false
        search = ""
        packcou = packcouba
        textta = backupta
        mynaptic.drawMenu()
      end
    else
      mynaptic.getPackInfo(y-1)
    end
  end
  elseif ev == "char" then
    if mynaptic.shellmode == true then
	  mynaptic.completemode = false
      shelltext = shelltext..me
      mynaptic.drawMenu()
    else
      searchch = true
      search = search..me
      mynaptic.writeSearch()
      tpos = 0
      mynaptic.drawMenu()
    end
  elseif ev == "paste" then
    if mynaptic.shellmode == true then
	  mynaptic.completemode = false
      shelltext = shelltext..me
      mynaptic.drawMenu()
    else
      searchch = true
      search = search..me
      mynaptic.writeSearch()
      tpos = 0
      mynaptic.drawMenu()
    end
  elseif ev == "key" then
	if me == keys[config.scrollDownKey] then
     if not(tpos+screenh == packcou+1) then
      if packcou > screenh-2 then
        tpos = tpos + 1
        mynaptic.drawMenu()
      end
     end
    elseif me == keys[config.scrollUpKey] then
       if not(tpos == 0) then
         tpos = tpos - 1
         mynaptic.drawMenu()
       end
    end
  elseif ev == "key_up" then
    if me == keys[config.deleteKey] then
      if mynaptic.shellmode == true then
        mynaptic.completemode = false
        shelltext = shelltext:sub(1,-2)
      else
        search = string.sub(search,1,-2)
        if search:len() == 0 then
          textta = backupta
        else
          mynaptic.writeSearch()
        end
        tpos = 0
      end
      mynaptic.drawMenu()
    elseif me == keys[config.debugKey] then
      mynaptic.debugmenu()
    elseif me == keys[config.shellSwitchKey] then
      if mynaptic.shellmode == true then
        mynaptic.shellmode = false
      else
        mynaptic.shellmode = true
      end
      mynaptic.drawMenu()
    elseif me == keys[config.completeKey] then
      if mynaptic.shellmode == true then
      if mynaptic.completemode == true then
        if not(type(mynaptic.compl[mynaptic.comcou]) == "string") then
          mynaptic.comcou = 1
        end
        shelltext = mynaptic.oldshtext..mynaptic.compl[mynaptic.comcou]:sub(1,-2)
        mynaptic.comcou = mynaptic.comcou + 1
        mynaptic.drawMenu()
      else
        mynaptic.compl = textutils.complete(shelltext,shellcom)
        if type(mynaptic.compl[1]) == "string" then
          mynaptic.oldshtext = shelltext
          shelltext = shelltext..mynaptic.compl[1]:sub(1,-2)
          mynaptic.completemode = true
          mynaptic.comcou = 2
          mynaptic.drawMenu()
        end
      end
      end
    elseif me == keys[config.shellRunKey] then
      if mynaptic.shellmode == true then
        local runstr,runargs
        if shelltext:find(" ") == nil then
          runstr = shelltext
        else
          runstr,runargs = wilmaapi.splitString(shelltext," ")
        end
        shelltext = ""
        if type(shellcom[runstr]) == "function" then
          shellcom[runstr](runargs)
        else
          term.setCursorPos(1,screenh)
          term.clearLine()
          write(lang.noCommand)
        end
      end
    end
  end
end
end
mainMenu()

mynaptic.deleteVars()

return 0
--Thanks for using this Programm and reading the
--source code
