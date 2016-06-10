Arg = {...}
os.loadAPI("/owncloud/owncloud API")
print(con["file"])
tonumber(channel)
if Arg[1] == "upload" then
  file = fs.open("/owncloud/file/"..con["user"].."/"..Arg[2],"w")
  file.write(con["file"])
  file.close()
elseif Arg[1] == "download" then
   file = fs.open("/owncloud/file/"..con["user"].."/"..Arg[2],"r")
   text = file.readAll()
   file.close()
   modem.transmit(2100,2100,text)
   print(id)
   print(text)
elseif Arg[1] == "list" then
  fl = fs.list("/owncloud/file/"..con["user"])
  print(channel)
  modem.transmit(2100,2100,table.concat(fl," "))
elseif Arg[1] == "delete" then
  fs.delete("/owncloud/file/"..con["user"].."/"..Arg[2])
end
--shell.run("/owncloud/owncloud")
