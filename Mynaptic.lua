--Made by Wilma456
print("Starting Mynaptic Please Wait ...")

os.loadAPI("/usr/apis/wilmaapi")

if term.isColor() == false or pocket then
  print("This Programm only run on a Advanced Computer or a Advaced Turtle")
  return 2
end

if wilmaapi == nil then
  term.setTextColor(colors.red)
  print("Error whith loading /usr/apis/wilmaapi")
  return 3
end

--print("If Mynaptic does not start and you see this errot, try to delete /etc/mynaptic")
function getPrint(text)
packlist.writeLine(text)
rcou = rcou + 1
end

local screenw,screenh = term.getSize()

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
  setLineColor("Apply Fetch Update")
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
end

textta = {}
statuscheck = {}
remove = {}
install = {}
checkta = {}
config = {}
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
config["packmanPath"] = config["packmanPath"]
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
print("This Programm is a GUI for Packman. Scroll with the mousewhell or the arrow keys. Software that you have installed are green. Select it the mark it to remove.Select sofware that you don't have installed to mark it to install. Click \"Apply\" to do all changes, that you have marked")
print()
print("If you want to change the config, edit /etc/mynaptic")
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
