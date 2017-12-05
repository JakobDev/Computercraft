--Made by Wilma456
print("Starting Mynaptic Please Wait ...")

os.loadAPI("/usr/apis/wilmaapi")
os.loadAPI("/usr/apis/clipboard")
if fs.exists("/usr/apis/backpack") then
  os.loadAPI("/usr/apis/backpack")
elseif fs.exists("/usr/apis/minepackapi") then
  os.loadAPI("/usr/apis/minepackapi")
else
  printError("Could not find Backpack/minepackapi")
  return 1
end

if term.isColor() == false then
  printError("This Programm only run on a Advanced Computer/Turtle/Pocket")
  return 2
end

--[[
term.setBackgroundColor(colors.blue)
term.clear()
local logo={
{16384,16384,00000,00000,00000,16384,16384,00000,16384,00000,00000,00000,16384,00000,16384,00000,00000,16384,00000,00000,00000,00000,16384,00000,00000,00000,00000,16384,16384,16384,00000,16384,16384,16384,00000,16384,00000,16384,16384,16384,},
{16384,00000,16384,00000,16384,00000,16384,00000,00000,16384,00000,16384,00000,00000,16384,16384,00000,16384,00000,00000,00000,16384,00000,16384,00000,00000,00000,16384,00000,16384,00000,00000,16384,00000,00000,16384,00000,16384,},
{16384,00000,00000,16384,00000,00000,16384,00000,00000,00000,16384,00000,00000,00000,16384,00000,16384,16384,00000,00000,16384,16384,16384,16384,16384,00000,00000,16384,16384,16384,00000,00000,16384,00000,00000,16384,00000,16384,},
{16384,00000,00000,00000,00000,00000,16384,00000,00000,00000,16384,00000,00000,00000,16384,00000,00000,16384,00000,16384,00000,00000,00000,00000,00000,16384,00000,16384,00000,00000,00000,00000,16384,00000,00000,16384,00000,16384,16384,16384,},
}
local logoPocket={
{16384,16384,00000,00000,00000,16384,16384,},
{16384,00000,16384,00000,16384,00000,16384,},
{16384,00000,00000,16384,00000,00000,16384,},
{16384,00000,00000,00000,00000,00000,16384,},
}
if pocket then
  paintutils.drawImage(logoPocket,5,5)
else
  paintutils.drawImage(logo,5,5)
end
--]]

if wilmaapi == nil then
  printError("Error whith loading wilmaapi")
  return 3
end

if clipboard == nil then
  printError("Error whith loading clipboard API")
  return 3
end

mynaptic = {}

mynaptic.version = "11.0"

--Get Options for Commandline
mynaptic.ops = {}
for k,v in ipairs({...}) do
    local head,body = wilmaapi.splitString(v,"=")
    mynaptic.ops[head] = body
end

mynaptic.shellmode = false

if minepackapi then
    mynaptic.packapi = minepackapi
elseif backpack then
    mynaptic.packapi = backpack
end

function getPrint(text)
packlist.writeLine(text)
rcou = rcou + 1
end

local screenw,screenh = term.getSize()
mynaptic.screenw = screenw
mynaptic.screenh = screenh

--Write lang
lang = {}
lang.keyContinue = "Press any Key to continue"
lang.search = "Search:"
lang.shell = "Shell:"
lang.noCommand = "Command not found"
lang.packNotFound = "Package not found"
lang.cancel = "Cancel"
lang.ok = "OK"
lang.apply = "Apply"
lang.fetch = "Fetch"
lang.update = "Update"
lang.config = "Config"
lang.menu = "Menu"
lang.help = "Help"
lang.yes = "Yes"
lang.no = "No"
lang.name = "Name:"
lang.installed = "Installed:"
lang.updateAviable = "Update aviable:"
lang.filename = "Filename:"
lang.target = "Target:"
lang.typ = "Type:"
lang.url = "URL:"
lang.size = "Size:"
lang.version = "Version:"
lang.category = "Category:"
lang.dependencies = "Dependencies:"
lang.description = "Description:"
lang.none = "None"
lang.installPack = "These Packages will be installed:"
lang.removePack = "These Packages will be removed:"
lang.updatePack = "These Packages will be updated:"
lang.install = "Install "
lang.remove = "Remove "
lang.youEdit = "You Edit:"
lang.old = "Old:"
lang.default = "Default:"
lang.needRestart = "Needs Restart"
lang.selectColour = "Please select a Colour"
lang.newEntry = "New Entry:"
lang.newEntryText = "Please enter new Entry"
lang.boolEntry = "Please choose new Entry"
lang.keyEntry = "Please choose a new Key"
lang.back = "Back"
lang.reset = "Reset"
lang.resetConfig = "Your config has been reseted to the default values"
lang.history = "History"
lang.clear = "Clear"
lang.exitText = "Thank you for using Mynaptic!"
lang.configerror = "There are Errors in the your Config. You now had to set some Entrys new"
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
tmpta.titel = "What is Apply"
tmpta.con = 'With "Apply" you can install all Packages that you have marked to install and remove all Packages that you have marked to remove.'
table.insert(helpta,tmpta)

tmpta = {}
tmpta.titel = "What is Fetch"
tmpta.con = 'The List with all Packages is saved on your Computer. Whith "Fetch" you can update this list. You need to restart Mynaptic to see the changes.'
table.insert(helpta,tmpta)

tmpta = {}
tmpta.titel = "Update your Programs"
tmpta.con = 'With "Update" you can Update your Programs. Mynaptic will see, what Programs can be updated.'

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

The Helpmenu doesn't works full on a turle and on a Pocket Computer. Other things work.

Other Devices are not supported]]
table.insert(helpta,tmpta)

tmpta = {}
tmpta["titel"] = "Using Plugins"
tmpta["con"] = [[With Plugins you can modify Mynaptic e.g another language or another package system

Simple place Plugins in the pluginFoler (default /usr/share/mynaptic/plugins) and be sure, thet loadPlugins is true
]]
table.insert(helpta,tmpta)

tmpta = {}
tmpta.titel = "Commandline Arguments"
tmpta.con = [[You can set the config of Mynaptic with the Commandline. e.g "Mynaptic showVersion=true textColour=red" will start Mynaptic and set showVersion to true and textColour to red.

You can also set the Path to the Config File with configPath=Path]]
table.insert(helpta,tmpta)

tmpta = {}
tmpta.titel = "Develop Plugins"
tmpta.con = "To install the developer Documentation install the Package mynaptic-plugindev and view the help with 'ghv Mynaptic'"
table.insert(helpta,tmpta)

tmpta = {}
tmpta.titel = "Add your Program"
tmpta.con = "To add your Program to Packman/Mynaptic visit https://github.com/lyqyd/cc-packman and follow the instructions"
tmpta.url = {{"Click here, to visit the GitHub Page of Packman","https://github.com/lyqyd/cc-packman"}}
table.insert(helpta,tmpta)

tmpta = {}
tmpta["titel"] = "Report Bugs/Feedback"
tmpta["con"] = [[You can report bugs or left feedback at this sites:

http://www.computercraft.info/forums2/index.php?/topic/27327-mynaptic-a-gui-for-packman/

https://github.com/Wilma456/Computercraft/issues]]
tmpta.url = {{"Click here to visit the Thread in the CC Forum","http://www.computercraft.info/forums2/index.php?/topic/27327-mynaptic-a-gui-for-packman/"},{"Click here to visit the GitHub Issue Tracker","https://github.com/Wilma456/Computercraft/issues"}}
table.insert(helpta,tmpta)

tmpta = {}
tmpta["titel"] = "Use Mynaptic in your OS"
tmpta["con"] = [[If you use packman in your OS, you may want to incluse Mynaptic. You have my permission to do this. If you want to optimize Mynaptic for your OS, just write Wilma456 at the CC Forum a PM.]]

table.insert(helpta,tmpta)

tmpta = {}
tmpta.titel = "License"
tmpta.con = 'Mynaptic is licesed under the BSD 2-clause "Simplified" License. For more information look at https://github.com/Wilma456/Computercraft/blob/master/LICENSE'
tmpta.url = {{"Click here to see the License","https://github.com/Wilma456/Computercraft/blob/master/LICENSE"}}
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
  tpos = packcou - screenh + 2
  mynaptic.drawMenu()
end

function shellcom.apply()
  mynaptic.doChanges()
end

function shellcom.fetch()
  mynaptic.reload()
end

function shellcom.history()
  mynaptic.history()
end

function shellcom.about()
  mynaptic.setShellText("Mynaptic Version "..mynaptic.version.." made by Wilma456")  
end

function shellcom.menu()
  mynaptic.showMenulist()
end

function shellcom.langedit()
  mynaptic.langScreen()
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
term.setCursorBlink(false)
term.setCursorPos(1,screenh)
term.clearLine()
write(text)
end

function mynaptic.showTextWindow(sText)
  term.setTextColor(colors[config.menuTextColour])
  while true do
    term.setBackgroundColor(colors[config.menuBackgroundColour])
    term.clear()
    term.setCursorPos(1,1)
    print(sText)
    term.setCursorPos(1,mynaptic.screenh)
    term.setBackgroundColor(colors[config.bottomBarColour])
    term.clearLine()
    term.write(lang.ok)
    local ev,me,x,y = os.pullEvent()
    if ev == "mouse_click" and y == mynaptic.screenh then
      return
    elseif ev == "term_resize" then
      mynaptic.screenw, mynaptic.screenh = term.getSize()
    end
  end
end

function mynaptic.setLineColor(text,arrow)
if type(text) == "string" then
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
term.setBackgroundColor(colors[config["notinstalledColour"]])
if statuscheck[te] == "instaled" then
  term.setBackgroundColor(colors[config["installedColour"]])
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
term.clearLine()
if config.closeButtonRight == "true" then
    term.setBackgroundColor(colors[config["closeColour"]])
    term.write("X")
    term.setBackgroundColor(colors[config["menubarColour"]])
end
local menutext = ""
for key,menuitem in ipairs(mynaptic.menubar) do
    menutext = menutext..menuitem.text.." "
end
term.write(menutext)
if config.closeButtonRight == "false" then
    term.setCursorPos(mynaptic.screenw,1)
    term.setBackgroundColor(colors[config["closeColour"]])
    term.write("X")
end
print()
if tpos ~= 0 and config.showScrollArrows == "true" then
   mynaptic.drawLine(textta[tpos+1],"\30")
else
    mynaptic.drawLine(textta[tpos+1]," ")
end
for i=3,mynaptic.screenh-2 do
    mynaptic.drawLine(textta[tpos+i-1]," ")
end
if tpos+mynaptic.screenh-2 ~= #textta and config.showScrollArrows == "true" then
   mynaptic.drawLine(textta[tpos+mynaptic.screenh-2],"\31")
else
    mynaptic.drawLine(textta[tpos+mynaptic.screenh-2]," ")
end
term.setCursorPos(1,mynaptic.screenh)
term.setBackgroundColor(colors[config["searchColour"]])
term.clearLine()
term.setCursorPos(1,mynaptic.screenh)
if mynaptic.shellmode == true then
  write(lang.shell..shelltext)
else
  write(lang.search..search)
end
if config.showCursorBlink == "true" then
    term.setCursorBlink(true)
end
end

helpta["egg"] = {}

function mynaptic.doChanges()
local packlist = {}
local installta = {}
table.insert(packlist,lang.installPack)
for k,v in pairs(install.check) do
  local tmpstr = k:sub(3):match("([^ ]+) ([^ ]+)")
  table.insert(packlist,tmpstr)
  table.insert(installta,tmpstr)
end
local removeta = {}
table.insert(packlist,lang.removePack)
for k,v in pairs(remove.check) do
  local tmpstr = k:sub(3):match("([^ ]+) ([^ ]+)")
  table.insert(packlist,tmpstr)
  table.insert(removeta,tmpstr)
end
local scrollpos = 0
while true do
  term.setBackgroundColor(colors[config.menuBackgroundColour])
  term.setTextColor(colors[config.menuTextColour])
  term.clear()
  term.setCursorPos(1,1)
  for i=1,mynaptic.screenh-1 do
    if type(packlist[i+scrollpos]) == "string" then
      print(packlist[i+scrollpos])
    end
  end
  if scrollpos ~= 0 and config.showScrollArrows == "true" then
    term.setCursorPos(mynaptic.screenw,1)
    term.write("\30")
  end
  if #packlist ~= scrollpos+mynaptic.screenh-1 and config.showScrollArrows == "true" and #packlist > mynaptic.screenh-1 then
    term.setCursorPos(mynaptic.screenw,mynaptic.screenh-1)
    term.write("\31")
  end
  term.setBackgroundColor(colors[config.bottomBarColour])
  term.setCursorPos(1,mynaptic.screenh)
  term.clearLine()
  term.write(lang.cancel)
  term.setCursorPos(mynaptic.screenw-#lang.ok+1,mynaptic.screenh)
  term.write(lang.ok)
  local ev,me,x,y = os.pullEvent()
  if ev == "mouse_scroll" then
    if me == -1 and scrollpos ~= 0 then
      scrollpos = scrollpos - 1
    elseif me == 1 and #packlist ~= scrollpos+mynaptic.screenh-1 and #packlist > mynaptic.screenh-1 then
      scrollpos = scrollpos + 1
    end
  elseif ev == "key" then
    if me == confid.scrollDownKey and scrollpos ~= 0 then
      scrollpos = scrollpos - 1
    elseif me == config.scrollUpKey and #packlist ~= scrollpos+mynaptic.screenh-1 and #packlist > mynaptic.screenh-1 then
      scrollpos = scrollpos + 1
    end
  elseif ev == "term_resize" then
    mynaptic.screenw,mynaptic.screenh = term.getCursorPos()
  elseif ev == "mouse_click" then
    if y == mynaptic.screenh then
      if x < #lang.cancel+1 then
        mynaptic.drawMenu()
        return
      elseif x > mynaptic.screenw-#lang.ok then
        break
      end
    end
  end
end
io.output(mynaptic.iomute)
term.setBackgroundColor(colors[config.menuBackgroundColour])
term.clear()
term.setCursorPos(1,1)
local hisfile = fs.open(config.historyPath,"a")
for k,v in ipairs(installta) do
  term.setTextColor(colors[config.textColour])
  term.setBackgroundColor(colors[config.menuBackgroundColour])
  print(lang.install..v)
  for packname,_ in pairs(mynaptic.packapi.findDependencies(v)) do
    mynaptic.packapi.list[packname]:install(getfenv())
  end
  --shell.run(config.packmanPath.." auto install "..v)
  if config.writeHistory == "true" and not minepackapi then
    hisfile.writeLine("Installed "..v)
  end
  statuscheck["A "..v.." "..mynaptic.packapi.list[v]["version"]] = "instaled"
end
install.check = {}
install.list = {}
for k,v in ipairs(removeta) do
  term.setTextColor(colors[config.textColour])
  term.setBackgroundColor(colors[config.menuBackgroundColour])
  print(lang.remove..v)
  mynaptic.packapi.list[v]:remove(getfenv())
  if config.writeHistory == "true" and not minepackapi then
    hisfile.writeLine("Removed "..v)
  end
  statuscheck["I "..v.." "..mynaptic.packapi.list[v]["version"]] = "notinstaled"
end
hisfile.close()
remove.check = {}
remove.list = {}
mynaptic.drawMenu()
end

helpta["egg"]["con"] = "You found a EasterEgg!"

function mynaptic.printcol(text)
term.setTextColor(colors.black)
term.setBackgroundColor(colors.white)
print(text)
end

function mynaptic.reload()
term.setBackgroundColor(colors.black)
term.setTextColor(colors.white)
term.clear()
term.setCursorPos(1,1)
io.output(mynaptic.iodefault)
shell.run(config.packmanPath.." fetch")
term.setBackgroundColor(colors.black)
term.setTextColor(colors.white)
term.clear()
term.setCursorPos(1,1)
mynaptic.drawMenu()
end

function mynaptic.updatemenu()
term.setBackgroundColor(colors[config.menuBackgroundColour])
term.setTextColor(colors[config.menuTextColour])
term.clear()
term.setCursorPos(1,1)
io.output(mynaptic.iodefault)
if config.fetchUpdate == "true" and minepackapi then
  shell.run(config.packmanPath.." fetch update")
elseif config.fetchUpdate == "true" then
  shell.run(config.packmanPath.." auto fetch update")
elseif minepackapi then
  shell.run(config.packmanPath.." update")
else
  shell.run(config.packmanPath.." auto update")
end
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
local running = true
local tEnv = {
    ["exit"] = function()
        running = false
    end,
}
setmetatable( tEnv, { __index = _ENV } )
print("Call exit() to exit")
while true do
if not running then
  break
end
write(">")
local re = read(nil,debughis)
  table.insert(debughis,re)
  local ok,err = pcall(load(re,"Debugmenu","t",tEnv))
  if not ok then
    printError(err)
  end
end
mynaptic.drawMenu()
end

function mynaptic.getPackInfo(ypos)
term.setCursorBlink(false)
term.setBackgroundColor(colors.white)
term.clear()
term.setCursorPos(1,1)
local getname = textta[tpos+ypos]:sub(3,-1)
getname = wilmaapi.splitString(getname," ")
if mynaptic.packapi.list[getname] == nil then
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
if mynaptic.packapi.list[getname]["download"]["type"]["type"] ~= "meta" then
    print(lang.target.." "..mynaptic.packapi.list[getname]["target"])
    print(lang.filename.." "..tostring(mynaptic.packapi.list[getname]["download"]["type"]["filename"]))
end
print(lang.typ.." "..tostring(mynaptic.packapi.list[getname]["download"]["type"]["type"]))
if mynaptic.packapi.list[getname]["download"]["type"]["type"] ~= "meta" then
    print(lang.url.." "..tostring(mynaptic.packapi.list[getname]["download"]["type"]["url"]))
    print(lang.size.." "..tostring(mynaptic.packapi.list[getname]["size"]).." Bytes")
end
print(lang.version.." "..tostring(mynaptic.packapi.list[getname]["version"]))
io.write(lang.category.. " ")
for cate,_ in pairs(mynaptic.packapi.list[getname]["category"]) do
	io.write(cate.." ")
end
io.write("\n")
local testdep = false
local getdep = mynaptic.packapi.list[getname]["dependencies"]
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
if minepackapi then
    print(lang.description.." "..mynaptic.packapi.list[getname]["description"])
end
print()
print(lang["keyContinue"])
os.pullEvent("key_up")
mynaptic.drawMenu()
end

function mynaptic.configNormal(entry,restart,default)
term.setTextColor(colors[config.menuTextColour] or colors.black)
term.setBackgroundColor(colors[config.menuBackgroundColour] or colors.white)
term.clear()
term.setCursorPos(1,1)
print(lang.newEntryText)
print()
print(lang.youEdit.." "..entry)
print()
print(lang.old.." "..config[entry])
print()
print(lang.default.." "..default)
print()
if restart == true then
    print(lang.needRestart)
    print()
end
write(lang.newEntry)
local input = read(nil,nil,nil,config[entry])
if not(input=="") then
  config[entry] = input
end
end

function mynaptic.configColor(entry,restart,default)
term.setTextColor(colors[config.menuTextColour] or colors.black)
term.setBackgroundColor(colors[config.menuBackgroundColour] or colors.white)
term.clear()
term.setCursorPos(1,1)
print(lang.selectColour)
print()
print(lang.youEdit.." "..entry)
print()
print(lang.old.." "..config[entry])
print()
print(lang.default.." "..default)
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
if y == 9 then
  if type(colorta[x]) == "string" then
    config[entry] = colorta[x]
    break
  end
end
end
end

function mynaptic.configBool(entry,restart,default)
term.setTextColor(colors[config.menuTextColour] or colors.black)
term.setBackgroundColor(colors[config.menuBackgroundColour] or colors.white)
term.clear()
term.setCursorPos(1,1)
print(lang.boolEntry)
print()
print(lang.youEdit.." "..entry)
print()
print(lang.old.." "..config[entry])
print()
print(lang.default.." "..default)
print()
term.setTextColor(colors.green)
write("true ")
term.setTextColor(colors.red)
write("false")
term.setTextColor(colors.black)
if restart == true then
    print()
    print()
    print(lang.needRestart)
end
while true do
local ev,me,x,y = os.pullEvent("mouse_click")
if y == 9 then
  if x < 5 then
    config[entry] = "true"
    break
  elseif x > 5 and x < 11 then
    config[entry] = "false"
    break
  end   
end
end
end

function mynaptic.configKey(entry,restart,default)
term.setTextColor(colors[config.menuTextColour] or colors.black)
term.setBackgroundColor(colors[config.menuBackgroundColour] or colors.white)
term.clear()
term.setCursorPos(1,1)
print(lang.keyEntry)
print()
print(lang.youEdit.." "..entry)
print()
print(lang.old.." "..config[entry])
print()
print(lang.default.." "..default)
print()
local ev,me = os.pullEvent("key")
config[entry] = keys.getName(me)
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
term.write( lang.ok )
term.setCursorPos(mynaptic.screenw-#lang.reset+1,mynaptic.screenh)
term.write(lang.reset)
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
elseif ev == "term_resize" then
  mynaptic.screenw, mynaptic.screenh = term.getSize()
elseif ev == "mouse_click" then
  if y == mynaptic.screenh then
    if x < #lang.ok+1 then
      configloop = nil
      break
    elseif x > mynaptic.screenw-#lang.reset then
      for k,v in ipairs( configed ) do
        config[v.name] = v.default
      end
      mynaptic.showTextWindow( lang.resetConfig )
    end
  elseif type(configed[configpos+y]) == "table" then
    if configed[configpos+y]["contype"] == "col" then
      mynaptic.configColor(configed[configpos+y]["name"],configed[configpos+y]["restart"],configed[configpos+y]["default"])
    elseif configed[configpos+y]["contype"] == "bool" then
      mynaptic.configBool(configed[configpos+y]["name"],configed[configpos+y]["restart"],configed[configpos+y]["default"])
    elseif configed[configpos+y]["contype"] == "key" then
      mynaptic.configKey(configed[configpos+y]["name"],configed[configpos+y]["restart"],configed[configpos+y]["default"])
    else
      mynaptic.configNormal(configed[configpos+y]["name"],configed[configpos+y]["restart"],configed[configpos+y]["default"])
    end
  end
end
end
--write config
local writecon = io.open(mynaptic.ops.configPath or "/etc/mynaptic","w")
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
for i=1,mynaptic.screenh-1 do
    if type(helpta[i+mynaptic.helpos]) == "table" then
        print(helpta[i+mynaptic.helpos]["titel"])
    end
end
if mynaptic.helpos ~= 0 and config.showScrollArrows == "true" then
    term.setCursorPos(mynaptic.screenw,1)
    term.write("\30")
end
if mynaptic.helpos+mynaptic.screenh-1 < #helpta and config.showScrollArrows == "true" then
    term.setCursorPos(mynaptic.screenw,mynaptic.screenh-1)
    term.write("\31")
end
term.setCursorPos(1,screenh)
term.setBackgroundColor(colors[config.bottomBarColour])
term.clearLine()
write("OK")
term.setBackgroundColor(colors[config.menuBackgroundColour])
end

function mynaptic.showHelp(num)
if type(helpta[num]["url"]) == "table" and commands and config.helpChatURL == "true" then
    for k,v in ipairs(helpta[num]["url"]) do
        commands.execAsync('tellraw @p ["",{"text":"'..v[1]..'","color":"blue","clickEvent":{"action":"open_url","value":"'..v[2]..'"},"hoverEvent":{"action":"show_text","value":{"text":"","extra":[{"text":"'..v[2]..'"}]}}}]')
    end
end
mynaptic.showTextWindow(helpta[num]["con"])
end

function mynaptic.helpMenu()
mynaptic.helpos = 0
mynaptic.helpList()
while true do
local ev,me,x,y = os.pullEvent()
if ev == "mouse_click" then
  if y == screenh then
    mynaptic.drawMenu()
    break
  elseif type(helpta[mynaptic.helpos+y]) == "table" then
    mynaptic.showHelp(mynaptic.helpos+y)
    mynaptic.helpList()
  end
elseif ev == "mouse_scroll" then
    if me == 1 then
        if mynaptic.helpos+mynaptic.screenh-1 < #helpta then
            mynaptic.helpos = mynaptic.helpos + 1
            mynaptic.helpList()
        end
    elseif me == -1 then
        if mynaptic.helpos ~= 0 then
            mynaptic.helpos = mynaptic.helpos - 1
            mynaptic.helpList()
        end
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
term.setBackgroundColor(colors[config.menuBackgroundColour])
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
      if config.showHistoryColours == "true" then
        if hiscon[hispos+i]:find("Installed") == 1 then
          term.setTextColour( colors[config.historyInstalledColour] )
        elseif hiscon[hispos+i]:find("Removed") == 1 then
          term.setTextColour( colors[config.historyRemovedColour] )
        else
          term.setTextColour( colors[config.menuTextColour] )
        end
      end
      print(hiscon[hispos+i])
    end
  end
  term.setTextColour( colors[config.menuTextColour] )
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
  term.write(lang.clear)
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

function mynaptic.showMenulist()
term.setBackgroundColor(colors[config.menuBackgroundColour])
term.setTextColour(colors[config.menuTextColour])
term.clear()
term.setCursorPos(1,1)
for _,v in pairs(mynaptic.menulist) do
  print(v.text)
end
term.setCursorPos(1,mynaptic.screenh)
term.setBackgroundColor(colors[config.menubarColour])
term.clearLine()
term.setCursorPos(1,mynaptic.screenh)
term.write(lang.back)
while true do
local ev,me,x,y = os.pullEvent()
  if ev == "mouse_click" then
    if y == mynaptic.screenh then
      break
    elseif type(mynaptic.menulist[y]) == "table" then
      mynaptic.menulist[y]["func"]()
      break
    end
  end
end
mynaptic.drawMenu()
end

function mynaptic.editLang(key)
term.clear()
term.setCursorPos(1,1)
print(lang.newEntryText)
print()
print(lang.youEdit.." "..key)
print()
print(lang.old.." "..lang[key])
print()
write(lang.newEntry)
local input = read(nil,nil,nil,lang[key])
if not(input=="") then
  lang[key] = input
end
end

function mynaptic.langScreen()
local langpos = 0
--Langloop
local langta = {}
for key,value in pairs(lang) do
  table.insert(langta,key)
end
while true do
term.setBackgroundColor(colors[config.menuBackgroundColour])
term.setTextColor(colors[config.menuTextColour])
term.clear()
term.setCursorPos(1,1)
for i=1,mynaptic.screenh-1 do
  if type(langta[i+langpos]) == "string" then
    print(langta[i+langpos])
  end
end
term.setCursorPos(1,mynaptic.screenh)
term.setBackgroundColor(colors[config.bottomBarColour])
term.clearLine()
write("OK")
term.setBackgroundColor(colors[config.menuBackgroundColour])
if config.showScrollArrows == "true" then
  if langpos ~= 0 then
    term.setCursorPos(mynaptic.screenw,1)
    term.write("\30")
  end
  if #langta ~= langpos+mynaptic.screenh-1 then
    term.setCursorPos(mynaptic.screenw,mynaptic.screenh-1)
    term.write("\31")
  end
end
local ev,me,x,y = os.pullEvent()
if ev == "mouse_scroll" or ev == "key" then
  if me == 1 or me == keys[config.scrollDownKey] then
    if #langta ~= langpos+mynaptic.screenh-1 then
      langpos = langpos + 1
    end
  elseif me == -1 or me == keys[config.scrollUpKey] then
    if langpos ~= 0 then
      langpos = langpos - 1
    end
  end
elseif ev == "mouse_click" then
  if y == mynaptic.screenh then
    configloop = nil
    break
  elseif type(langta[langpos+y]) == "string" then
    mynaptic.editLang(langta[langpos+y])
  end
end
end
mynaptic.drawMenu()
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

function mynaptic.testConfig(name,contype,default,restart)
if not(type(config[name]) == "string") then
    config[name] = default
    configstatus = false
elseif contype == "bool" then
  if not(config[name] == "true" or config[name] == "false") then
    table.insert(mynaptic.wrongconfig,mynaptic.configcou+1)
  end 
elseif contype == "col" then
  if not(type(colors[config[name]]) == "number") then
    table.insert(mynaptic.wrongconfig,mynaptic.configcou+1)
  end
elseif contype == "key" then
  if type(keys[config[name]]) ~= "number" then
    table.insert(mynaptic.wrongconfig,mynaptic.configcou+1)
  end
end
local tmpta = {}
tmpta.contype = contype
tmpta.name = name
tmpta.con = config[name]
tmpta.restart = restart
tmpta.default = default
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
install.pack = {}
remove["list"] = {}
remove["check"] = {}
remove.pack = {}
searchch = false
search = ""
shelltext = ""
configstatus = true
updateta = {}
mynaptic.configcou = 0
mynaptic.wrongconfig = {}

--Read Config
if fs.exists(mynaptic.ops.configPath or "/etc/mynaptic") then
    local confile = io.open(mynaptic.ops.configPath or "/etc/mynaptic","r")
    for sLinecon in confile:lines() do
        if sLinecon:find("#") ~= 1 then
            local head,cont = wilmaapi.splitString(sLinecon," ")
            config[head] = cont
        end
    end
else
    configstatus = false
end

--Set Config from Commandline Arguments
for k,v in pairs(config) do
    if mynaptic.ops[k] ~= nil then
        config[k] = mynaptic.ops[k]
    end
end

term.setTextColor(colors.red)
mynaptic.testConfig("showVersion","bool","false") 
mynaptic.testConfig("showRepository","bool","true")
mynaptic.testConfig("sortAlphabetically","bool","false",true)
mynaptic.testConfig("loadPlugins","bool","true",true)
mynaptic.testConfig("showExitText","bool","true")
mynaptic.testConfig("showScrollArrows","bool","true")
mynaptic.testConfig("closeButtonRight","bool","false")
mynaptic.testConfig("showCursorBlink","bool","true")
mynaptic.testConfig("pluginPath",nil,"/usr/share/mynaptic/plugins",true)
mynaptic.testConfig("helpChatURL","bool","true")
mynaptic.testConfig("fetchUpdate","bool","false")
mynaptic.testConfig("forcePocketMode","bool","false",true)
mynaptic.testConfig("showHistoryColours","bool","true")
if minepackapi then
    mynaptic.testConfig("writeHistory","bool","false")
    mynaptic.testConfig("historyPath",nil,fs.combine(minepackapi.config.minepackDirectory,"log.txt"))
    mynaptic.testConfig("packmanPath",nil,"/usr/bin/minepack.lua")
else
    mynaptic.testConfig("writeHistory","bool","true")
    mynaptic.testConfig("historyPath",nil,"/var/MynapticHistory.txt")
    mynaptic.testConfig("packmanPath",nil,"/usr/bin/packman")
end
mynaptic.testConfig("multishellTitle",nil,"Mynaptic",true)
mynaptic.testConfig("backgroundColour","col","gray")
mynaptic.testConfig("menubarColour","col","blue")
mynaptic.testConfig("closeColour","col","red")
mynaptic.testConfig("notinstalledColour","col","white")
mynaptic.testConfig("installedColour","col","green")
mynaptic.testConfig("installColour","col","orange")
mynaptic.testConfig("removeColour","col","red")
mynaptic.testConfig("textColour","col","black")
mynaptic.testConfig("searchColour","col","brown")
mynaptic.testConfig("bottomBarColour","col","blue")
mynaptic.testConfig("menuBackgroundColour","col","white")
mynaptic.testConfig("menuTextColour","col","black")
mynaptic.testConfig("historyInstalledColour","col","green")
mynaptic.testConfig("historyRemovedColour","col","red")
mynaptic.testConfig("scrollUpKey","key","up")
mynaptic.testConfig("scrollDownKey","key","down")
mynaptic.testConfig("deleteKey","key","backspace")
mynaptic.testConfig("debugKey","key","rightAlt")
mynaptic.testConfig("shellSwitchKey","key","leftCtrl")
mynaptic.testConfig("completeKey","key","tab")
mynaptic.testConfig("shellRunKey","key","enter")
mynaptic.testConfig("deleteAllKey","key","delete")
term.setTextColor(colors.white)

if #mynaptic.wrongconfig ~= 0 then
    term.setBackgroundColor(colors.white)
    term.setTextColor(colors.black)
    term.clear()
    term.setCursorPos(1,1)
    print(lang.configerror)
    print()
    print(lang.keyContinue)
    os.pullEvent("key")
    configstatus = false
    for k,v in ipairs(mynaptic.wrongconfig) do
        if configed[v]["contype"] == "col" then
            mynaptic.configColor(configed[v]["name"],configed[v]["restart"],configed[v]["default"])
        elseif configed[v]["contype"] == "bool" then
            mynaptic.configBool(configed[v]["name"],configed[v]["restart"],configed[v]["default"])
        elseif configed[v]["contype"] == "key" then
            mynaptic.configKey(configed[v]["name"],configed[v]["restart"],configed[v]["default"])
        else
            mynaptic.configNormal(configed[v]["name"],configed[v]["restart"],configed[v]["default"])
        end
    end
end

--[[
if fs.exists(config["packmanPath"]) == false then
  term.setTextColor(colors.red)
  printError("Can't found Packman. If packman are installed, please change the Path in /etc/mynaptic")
  return 5
end
--]]

if not configstatus then
    local file = fs.open(mynaptic.ops.configPath or "/etc/mynaptic","w")
    for k,v in pairs(config) do
        file.writeLine(k.." "..v)
    end
    file.close()
end

if multishell then
    multishell.setTitle(multishell.getCurrent(),config.multishellTitle)
end

--Add Menuitems
mynaptic.menubar = {}
if pocket or config.forcePocketMode == "true" then
  table.insert(mynaptic.menubar,{text = lang.menu,func = function() mynaptic.showMenulist() end})
else
  table.insert(mynaptic.menubar,{text = lang.apply,func = function() mynaptic.doChanges() end})
  table.insert(mynaptic.menubar,{text = lang.fetch,func = function() mynaptic.reload() end})
  table.insert(mynaptic.menubar,{text = lang.update,func = function() mynaptic.updatemenu() end})
  table.insert(mynaptic.menubar,{text = lang.config,func = function() mynaptic.configScreen() end})
  table.insert(mynaptic.menubar,{text = lang.help,func = function() mynaptic.helpMenu() end})
  table.insert(mynaptic.menubar,{text = lang.history,func = function() mynaptic.history() end})
end
mynaptic.menulist = {}
table.insert(mynaptic.menulist,{text = lang.apply,func = function() mynaptic.doChanges() end})
table.insert(mynaptic.menulist,{text = lang.fetch,func = function() mynaptic.reload() end})
table.insert(mynaptic.menulist,{text = lang.update,func = function() mynaptic.updatemenu() end})
table.insert(mynaptic.menulist,{text = lang.config,func = function() mynaptic.configScreen() end})
table.insert(mynaptic.menulist,{text = lang.help,func = function() mynaptic.helpMenu() end})
table.insert(mynaptic.menulist,{text = lang.history,func = function() mynaptic.history() end})

textta = {}
packcou = 0
mynaptic.iodefault = io.output()
mynaptic.iomute = {write = function() end}
io.output(mynaptic.iomute)
--shell.run(config.packmanPath.." install")
mynaptic.packapi.load()
for name,con in pairs(mynaptic.packapi.list) do
  if type(con.version) == "string" then
    if type(mynaptic.packapi.installed[name]) == "table" then
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

tpos = 0

function mynaptic.mainMenu()
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
      if config.closeButtonRight == "true" then
        coustr = 1
      end
      for cou,con in ipairs(mynaptic.menubar) do
        local tmpta = con
        if mynaptic.dragx > coustr then
          if mynaptic.dragx < con.text:len()+coustr+1 then
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
        if tpos+mynaptic.screenh-2 ~= #textta then
          tpos = tpos + 1
          mynaptic.drawMenu()
        end
    elseif me == -1 then
       if tpos ~= 0 then
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
      if clipboard.getTextLine() ~= "" then
        searchch = true
        search = search..clipboard.getTextLine()
        mynaptic.writeSearch()
        tpos = 0
        mynaptic.drawMenu()
      end
    end
  --Leftclick
  elseif me == 1 then
  if y == 1 then
    if (x == mynaptic.screenw and config.closeButtonRight == "false") or (x == 1 and config.closeButtonRight == "true") then
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
    if config.closeButtonRight == "true" then
        menupos = 1
    end
    for key,menuitem in ipairs(mynaptic.menubar) do
      if x > menupos and x < menuitem.text:len()+menupos+1 then
        term.setCursorBlink(false)
        menuitem.func()
        break 
      else
        menupos = menupos+menuitem.text:len()+1
      end
    end
  elseif y == mynaptic.screenh then
    if mynaptic.shellmode == true and shelltext ~= "" then
      shelltext = ""
      mynaptic.drawMenu()
    elseif mynaptic.shellmode == false and search ~= "" then
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
      remove["check"][strte] = nil
    elseif statuscheck[strte] == "install" then
      statuscheck[strte] = "notinstaled"
      install["check"][strte] = nil
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
      if config.closeButtonRight == "true" then
        coustr = 1
      end
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
  elseif ev == "term_resize" then
    mynaptic.screenw,mynaptic.screenh = term.getSize()
    mynaptic.drawMenu()
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
      if tpos+mynaptic.screenh-2 ~= #textta then
        tpos = tpos + 1
        mynaptic.drawMenu()
      end
    elseif me == keys[config.scrollUpKey] then
       if tpos ~= 0 then
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
    elseif me == keys[config.deleteAllKey] then
      if mynaptic.shellmode == true and shelltext ~= "" then
        shelltext = ""
        mynaptic.drawMenu()
      elseif mynaptic.shellmode == false and search ~= "" then
        search = ""
        searchch = false
        mynaptic.writeSearch()
        tpos = 0
        mynaptic.drawMenu()
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

--Load Plugins
local plugintest
if config["loadPlugins"] == "true" then
  if fs.isDir(config.pluginPath) == true then
    local pluginlist = fs.list(config.pluginPath)
    for _,plugname in ipairs(pluginlist) do
      if shell.run(config.pluginPath.."/"..plugname) == false then
        plugintest = false
      end
      --shell.run(config.pluginPath.."/"..plugname)
    end
  end
end

if plugintest == false then
  print(lang.keyContinue)
  os.pullEvent("key")
end

mynaptic.drawMenu()
mynaptic.mainMenu()
io.output(mynaptic.iodefault)
mynaptic.deleteVars()

return 0
--Thanks for using this Programm and reading the
--source code
