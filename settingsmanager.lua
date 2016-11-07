local function addSetting(set,text)
local tmpta = {}
tmpta["name"] = set
tmpta["con"] = settings.get(set)
tmpta["text"] = text
table.insert(setta,tmpta)
end

local function getBoolean(str)
if str == true then
  return "Enabled"
else
  return "Disabled"
end
end

local function drawText()
term.clear()
term.setCursorPos(1,1)
tablecou = 0
for nu,conta in ipairs(setta) do
local posx,posy = term.getCursorPos()
write(conta["text"])
term.setCursorPos(35,posy)
if cupos == nu then
write("["..getBoolean(conta["con"]).."]")
else
write(getBoolean(conta["con"]))
end
print()
tablecou = tablecou + 1
end
print()
print("Press up/down to select option")
print("Press left/right to enable/disable")
print("Press Enter to save and exit")
print("Press C to cancel")
print("Press D to restore defaults")
end

local function saveSettings()
for _,seta in ipairs(setta) do
settings.set(seta["name"],seta["con"])
end
settings.save(".settings")
end

local function setDefault()
setta[1]["con"] = true
setta[2]["con"] = true
setta[3]["con"] = true
setta[4]["con"] = true
setta[5]["con"] = true
setta[6]["con"] = false
setta[7]["con"] = true
end

os.sleep(0.2)
setta = {}
cupos = 1
addSetting("bios.use_multishell","Use Multishell")
addSetting("shell.autocomplete","Allow autocomplete in the Shell")
addSetting("shell.allow_disk_startup","Allow startup from Disk")
addSetting("shell.allow_startup","Allow atartup from Computer")
addSetting("lua.autocomplete","Allow autocomplete in lua")
addSetting("list.show_hidden","List hidden files")
addSetting("edit.autocomplete","Allow autocomplete in edit")
while true do
drawText()
local ev,key = os.pullEvent("key_up")
if key == keys.down and not (cupos == tablecou) then
  cupos = cupos + 1
elseif key == keys.up and cupos > 1 then
  cupos = cupos - 1
elseif key == keys.left or key == keys.right then
  if setta[cupos]["con"] == true then
    setta[cupos]["con"] = false
  else
    setta[cupos]["con"] = true
  end
elseif key == keys.enter then
  saveSettings()
  break
elseif key == keys.c then
  break
elseif key == keys.d then
  setDefault()
end
end

term.clear()
term.setCursorPos(1,1)
