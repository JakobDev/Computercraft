local w,h = term.getSize()
os.loadAPI("/usr/apis/wilmaapi")
os.loadAPI("/usr/apis/clipboard")
if type(mineshark) == "table" then
  http.get = mineshark.htppget
end
mineshark = {}
mineshark.modem = peripheral.find("modem")
mineshark.listcon = {}
mineshark.listpos = 0
mineshark.httpget = http.get
mineshark.headbar = window.create(term.current(),1,1,w,1)
mineshark.listwindow = window.create(term.current(),1,2,w,h-1)

function http.get(url,headers)
local getcon = mineshark.httpget(url,headers)
if type(getcon) == "table" then
  local tmpspy = getcon.readAll()
  local writefi = fs.open("/tmp/httpspy.tmp","w")
  writefi.write(tmpspy)
  writefi.close()
  returnta = fs.open("/tmp/httpspy.tmp","r")
  fs.delete("/tmp/httpspy.tmp")
  os.queueEvent("http_get",url,tmpspy)
else
  os.queueEvent("http_get",url,"Fail")
end
return returnta
end

function mineshark.redrawHeader()
mineshark.headbar.setBackgroundColour(colors.blue)
mineshark.headbar.setTextColour(colors.black)
mineshark.headbar.setCursorPos(1,1)
mineshark.headbar.clear()
mineshark.headbar.write("Mineshark")
mineshark.headbar.setCursorPos(w,1)
mineshark.headbar.blit("X","f","e")
end

function mineshark.redrawList()
mineshark.listwindow.setBackgroundColour(colors.white)
mineshark.listwindow.setTextColour(colors.black)
mineshark.listwindow.clear()
mineshark.listwindow.setCursorPos(1,1)
if #mineshark.listcon == 0 then
  mineshark.listwindow.write("Mineshark is now listening. All connections will be") 
  mineshark.listwindow.setCursorPos(1,2)
  mineshark.listwindow.write("shown here.")
end
local lw,lh = mineshark.listwindow.getSize()
for i=1,lh do
if type(mineshark.listcon[i+mineshark.listpos]) == "table" then
  mineshark.listwindow.write(mineshark.listcon[i+mineshark.listpos]["text"])
  local x,y = mineshark.listwindow.getCursorPos()
  mineshark.listwindow.setCursorPos(1,y+1)
end
end
end

function mineshark.redrawInfoWindow()
term.setBackgroundColor(colors.white)
term.setTextColor(colors.black)
term.clear()
term.setCursorPos(1,1)
local w,h = term.getSize()
for i=1,h do
  if type(mineshark.infocon[i+mineshark.infopos]) == "string" then
    term.setCursorPos(1,i)
    term.write(mineshark.infocon[i+mineshark.infopos])
  end
end
end

function mineshark.scrollInfoWindow(str)
mineshark.infopos = 0
mineshark.infocon,mineshark.infoline = wilmaapi.stringLineTable(str)
mineshark.redrawInfoWindow()
local w,h = term.getSize()
while true do
  local ev,me = os.pullEvent()
  if ev == "mouse_scroll" then
    if me == 1 then
      if not(mineshark.infopos+h>=mineshark.infoline) then
        mineshark.infopos = mineshark.infopos + 1
        mineshark.redrawInfoWindow()
      end
    elseif me == -1 then
      if not(mineshark.infopos==0) then
        mineshark.infopos = mineshark.infopos - 1
        mineshark.redrawInfoWindow()
      end
    end
  elseif ev == "key_up" then
    if me == keys.q or mee == keys.enter or me == keys.space then
      break
    elseif me == keys.c then
      clipboard.setText(str)
    end
  end
end
end

function mineshark.getHttpInfo(pos)
mineshark.scrollInfoWindow(mineshark.listcon[pos+mineshark.listpos]["file"])
end

function mineshark.getRednetInfo(pos)
term.setBackgroundColor(colors.white)
term.setTextColour(colors.black)
term.clear()
term.setCursorPos(1,1)
local tmpta = mineshark.listcon[pos+mineshark.listpos]
tmpstr = "Target: "..tmpta.target
tmpstr = tmpstr.."Content: "..tostring(tmpta.con)
--os.pullEvent("key_up")
mineshark.scrollInfoWindow(tmpstr)
end

function mineshark.insertList(inscon)
table.insert(mineshark.listcon,inscon)
end

mineshark.modem.open(65533)

mineshark.redrawList()

function mineshark.spyLoop(ev,me,x,y,con)
--local ev,me,x,y,con = os.pullEvent()
if ev == "modem_message" then
  local tmpta = {}
  local tmpstr = con.nMessageID.." "
  tmpstr = tmpstr..con.nRecipient.." "..tostring(con.message)
  tmpta.text = tmpstr
  tmpta.func = mineshark.getRednetInfo
  tmpta.target = con.nRecipient
  tmpta.con = con.message
  mineshark.insertList(tmpta)
elseif ev == "http_get" then
  local tmpta = {}
  tmpta.text = "http_get "..me
  tmpta.file = x
  tmpta.func = mineshark.getHttpInfo
  mineshark.insertList(tmpta)
end
--mineshark.redrawList()
end

function mineshark.mainloop()
while true do
local ev,me,x,y,con = os.pullEvent()
if ev == "mouse_scroll" then
  if me == -1 then
    if not(mineshark.listpos == 0) then
      mineshark.listpos = mineshark.listpos - 1
    end
  elseif me == 1 then
    mineshark.listpos = mineshark.listpos + 1
  end
elseif ev == "mouse_click" then
  if y == 1 then
    if x == w then
      return
    end
  else
    if type(mineshark.listcon[mineshark.listpos+y-1]) == "table" then
      if type(mineshark.listcon[mineshark.listpos+y-1]["func"]) == "function" then
        mineshark.listcon[mineshark.listpos+y-1]["func"](y-1)
      end
    end
  end
else
  mineshark.spyLoop(ev,me,x,y,con)
end
mineshark.redrawList()
mineshark.redrawHeader()
end
end

mineshark.mainloop()
http.get = mineshark.htppget
mineshark = nil
term.setBackgroundColor(colors.black)
term.clear()
print()
return 0
