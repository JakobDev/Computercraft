Arg = {...}

cf = fs.open("/owncloud/config/channel","r")
cn = cf.readLine()
cf.close()
channel = tonumber(cn)
print(channel)

--for n,sSide in ipairs(rs.getSides()) do
--  if peripheral.getType(sSide) == "modem" then
  --  ModemSide = sSide
  --  break
  -- end
--end
modem = peripheral.wrap("right")

tcou = 0
FileList = fs.list("/owncloud/plugins")
for _, file in ipairs(FileList) do
  tcou = tcou + 1
end

function Cloud()
while true do
term.clear()
term.setCursorPos(1,1)
print("Owncloud is running. The channel is "..channel)
print()
print(tcou.." Plugins loaded")
ev,a,b,c,con = os.pullEvent("modem_message")
print(con["func"])
--print(con["file"])
if fs.exists("/owncloud/user/"..con["user"]) == true then
 ps = fs.open("/owncloud/user/"..con["user"],"r")
  wo = ps.readLine()
  ps.close()
  if wo == con["password"] then
    if func == "logintest" then
    modem.transmit(2100,2100,"All right")
    else
    shell.run("/owncloud/plugins/"..con["func"])
  end
end
end
end
end

function Plugin()
  while true do
  pft = fs.open("/owncloud/plugins/"..FileList[tcz],"r")
  isstart = pft.readLine()
  pft.close()
  if isstart == "--start" then
  shell.run("/owncloud/plugins/"..FileList[tcz].." start")
  end
  tcz = tcz - 1
  if tcz == 0 then
    tcz = tcou
  end
  sleep(1)
  end
end

modem.open(2100)
tcz = tcou
parallel.waitForAny(Cloud,Plugin)



