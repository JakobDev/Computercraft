--Made by Wilma456

if term.isColor() == false then
  print("This Programm only run on a Advanced Computer")
  return
end

--print("If Mynaptic does not start and you see this errot, try to delete /etc/mynaptic")
function getPrint(text)
packlist.writeLine(text)
rcou = rcou + 1
end

local function ioread()
  return "Y"
end

local function nichts()
end

function shellresolve(ag)
shell.resolveProgram(ag)
end

function setLineColor(text)
local lccou = string.len(text)
write(text)
local looplc = true
while looplc == true do
  write(" ")
  lccou = lccou + 1
  if lccou == 51 then
    looplc = nil
    lccou = nil
  end
end
print("")
end

function drawLine(te)
term.setBackgroundColor(colors[config["notinstaledColour"]])
term.setTextColor(colors.black)
if statuscheck[te] == "instaled" then
  term.setBackgroundColor(colors[config["instaledColour"]])
elseif statuscheck[te] == "install" then
  term.setBackgroundColor(colors[config["installColour"]])
elseif statuscheck[te] == "remove" then
  term.setBackgroundColor(colors[config["removeColour"]])
end
ins,teb,ver = te:match("([^ ]+) ([^ ]+) ([^ ]+)")
if config["showRepository"] == "false" then
  repo,teb = teb:match("([^/]+)/([^/]+)")
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

function drawMenu()
term.setBackgroundColor(colors[config["backgroundColour"]])
term.clear()
term.setCursorPos(1,1)
checkcou = 1
local loop = true
local lpos = 0
while loop == true do
if lpos == 0 then
  term.setBackgroundColor(colors[config["menuColour"]])
  write("Apply                                             ")
  term.setBackgroundColor(colors[config["closeColour"]])
  print("X")
else
  drawLine(textta[tpos+lpos])
end
  lpos = lpos + 1
  if lpos == 18 then
    loop = nil
    lpos = nil
  end
end
term.setCursorPos(1,19)
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
    ins,pack = text:match("([^ ]+) ([^ ]+)")
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
term.setCursorPos(1,19)
--term.setTextColor(colors.yellow)
write("Cancel                                           OK")
ev,mouse,x,y = os.pullEvent("mouse_click")
if y == 19 then 
  if x < 7 then
    term.setBackgroundColor(colors.black)
    term.clear()
    term.setCursorPos(1,1)
  elseif x == 51 then
    term.clear()
    term.setCursorPos(1,1)
    if config["writeHistory"] == "true" then
      history = fs.open(config["historyPath"],"a")
    end
    sandta = {io={write=nichts,read=ioread},shell = shell}
    for _,pack in ipairs(installta) do
      print("Install "..pack)
      os.run(sandta,"/usr/bin/packman","install",pack)
      if config["writeHistory"] == "true" then
        history.writeLine("Installed "..pack)
      end
      term.setBackgroundColor(colors.white)
      term.setTextColor(colors.black)
    end
    for _, pack in ipairs(removeta) do
      print("Remove "..pack)
      os.run(sandta,"/usr/bin/packman","remove",pack)
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

function printcol(text)
term.setTextColor(colors.black)
term.setBackgroundColor(colors.white)
print(text)
end

function reload()
term.setBackgroundColor(colors.white)
term.clear()
term.setCursorPos(1,1)
reta = {shell=shell,io={write=printcol}}
os.run(reta,"/usr/bin/packman","fetch")
mainMenu()
end

function testConfig(name,contype)
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

--Read Config
if fs.exists("/etc/mynaptic") == true then
confile = fs.open("/etc/mynaptic","r")
local loop = true
while loop == true do
  text = confile.readLine()
  if text == nil then
    loop = nil
  else
    head,cont = text:match("([^ ]+) ([^ ]+)")
    if typecheck(head) == "string" then
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
confile.writeLine("historyPath /var/history")
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
config["historyPath"] = "/var/history"
config["backgroundColour"] = "gray"
config["menuColour"] = "blue"
config["closeColour"] = "red"
confile["notinstaledColour"] = "white"
config["instaledColour"] = "green"
config["installColour"] = "orange"
config["removeColour"] = "red"
end

testConfig("showVersion","bool") 
testConfig("showRepository","bool")
testConfig("sortAlphabetically","bool")
testConfig("historyPath")
testConfig("backgroundColour","col")
testConfig("menuColour","col")
testConfig("closeColour","col")
testConfig("notinstaledColour","col")
testConfig("instaledColour","col")
testConfig("installColour","col")
testConfig("removeColour","col")


if configstatus == false then
print("There are problems with your config. Please read the Errors. If you haven't change the config, you can delete it by run delete /etc/mynaptic and the the config will be rubuild by the next start")
return
end

sandio = {write = getPrint}
sandsh = {resolveProgram = shellresolve}
sandta = {io = sandio,shell = sandsh}
--sandta = {print = getPrint,io = {write = getPrint}}
--sandta...] = "test"
--file = fs.open("/log","w")
rcou = 1
packlist = fs.open("/tmp/packlistsy","w")
os.run(sandta,"/usr/bin/packman","search")
--print(rcou)
packlist.close()
packread = fs.open("/tmp/packlistsy","r")
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
fs.delete("/tmp/packlistsy")

for _,str in ipairs(textta) do
  if string.byte(str,1) == 73 then
    statuscheck[str] = "instaled"
  end
end

if config["sortAlphabetically"] == "true" then
  table.sort(textta)
end

tpos = 1
drawMenu()
--statuscheck = {}
local function mainMenu()
local mainloop = true
while mainloop == true do
  ev,me,x,y = os.pullEvent()
  if ev == "mouse_scroll" then
    if me == 1 then
     if tpos+19 == packcou then
     --Problems with if not
     else
      tpos = tpos + 1
      drawMenu()
     end
    elseif me == -1 then
       if tpos == 1 then
         --Problems with if not
       else
         tpos = tpos - 1
         drawMenu()
       end
    end
  elseif ev == "mouse_click" then
  if y == 1 then
    if x > 0 and x < 6 then
      mainloop = nil
      doChanges()
    elseif x > 6 and x < 13 then
      mainloop = nil
      reload()
    elseif x == 51 then
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
    end
  end
end
end
mainMenu()
--Thanks for using this Programm and reading the
--source code
