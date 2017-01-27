os.loadAPI("clipboard")

local Args = {...}

if not(clipboard) then
  print("Clipboard API was not found")
  return
end

if not(type(oldpasteread) == "function") then
  oldpasteread = read
end

function getRead()
readstr = oldpasteread(Arg1,Arg2,Arg3,Arg4)
os.queueEvent("exit_clip")
end

function getClip()
while true do
local ev,me = os.pullEvent()
if ev == "mouse_click" then
  if me == 3 then
    os.queueEvent("paste",clipboard.getTextLine())
  end
elseif ev == "exit_clip" then
  break
end
end
end

function read(a,b,c,d)
Arg1 = a
Arg2 = b
Arg3 = c
Arg4 = d
parallel.waitForAll(getRead,getClip)
Arg1 = nil
Arg2 = nil
Arg3 = nil
Arg4 = nil
local readcopy = readstr
rreadstr = nil
return readcopy
end

if not(Args[1] == "mute") then
  print("All Done! You can now click the Mousewhell to paste Text from the Clipboard API to Textfiels who are made with read()")
end
