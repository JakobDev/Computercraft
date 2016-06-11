--start
local GpsTimer = os.startTimer(1)
local sModemSide = "right"
modem = peripheral.wrap("right")
modem.open(gps.CHANNEL_GPS)
local file = fs.open("/owncloud/config/gps","r")
o = file.readLine()
x = file.readLine()
y = file.readLine()
z = file.readLine()
file.close()
if o == "true" then
while true do
  local e = nil
		local e, p1, p2, p3, p4, p5 = os.pullEvent()
		if e == "modem_message" then
			 sSide, sChannel, sReplyChannel, sMessage, nDistance = p1, p2, p3, p4, p5
			if sSide == sModemSide and sChannel == gps.CHANNEL_GPS and sMessage == "PING" and nDistance then
				modem.transmit( sReplyChannel, gps.CHANNEL_GPS, { x, y, z } )
			end
  break
  elseif e == "timer" then
    break
  end
end
end
