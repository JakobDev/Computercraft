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
if con["type"] == "owncloud" then
if fs.exists("/owncloud/user/"..con["user"]) == true then
 ps = fs.open("/owncloud/user/"..con["user"],"r")
  wo = ps.readLine()
  ps.close()
  if wo == con["password"] then
    if con["func"] == "logintest" then
    modem.transmit(2100,2100,"All right")
    else
    shell.run("/owncloud/plugins/"..con["func"])
  end
end
end
end
end
end

function Plugin()
plr = splc
--print(plr)
print(startpl[plr])
  while true do
  shell.run(startpl[plr].." start")
  plr = plr - 1
  if plr == 0 then
    plr = splc
  end
  sleep(0.1)
  end
end

startpl = {}
tcz = tcou
splc = 0
scp = 1
while true do
  local pft = fs.open("/owncloud/plugins/"..FileList[tcz],"r")
  local isstart = pft.readLine()
  pft.close()
  if isstart == "--start" then
    startpl[scp] = "/owncloud/plugins/"..FileList[tcz]
    splc = splc + 1
    scp = scp + 1
  end
  tcz = tcz - 1
  if tcz == 0 then
    break
  end
end

modem.open(2100)
parallel.waitForAny(Cloud,Plugin)
