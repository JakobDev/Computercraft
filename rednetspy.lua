local modem = peripheral.find("modem")
if modem == nil then
print("No modem found")
return
end
modem.open(65533)
while true do
local ev,si,ch,rp,con,dis = os.pullEvent("modem_message")
write(con["nMessageID"])
write(" ")
write(con["nRecipient"])
write(" ")
write(con["message"])
write(" ")
if not (con["sProtocol"] == nil) then
write(con["sProtocol"])
end
print()
end
