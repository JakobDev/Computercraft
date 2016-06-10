function upload()
file = fs.open(up,"r")
con["file"] = file.readAll()
file.close()
con["func"] = "file upload "..fn
modem.transmit(2100,2100,con)
mainshell()
end

function download()
con["func"] = "file download "..dow
modem.transmit(2100,2100,con)
a,b,c,d,text = os.pullEvent("modem_message")
file = fs.open(pa,"w")
file.write(text)
file.close()
mainshell()
end

function list()
  con["func"] = "file list"
  modem.transmit(2100,2100,con)
  a,b,c,d,text = os.pullEvent("modem_message")
  print(text)
  mainshell()
end

function delete()
  con["func"] = "file delete "..del
  modem.transmit(2100,2100,con)
  mainshell()
end

function mainshell()
	write("OwncloudFile> ") 
	sh = read()
	if sh == "upload" then
		print("Select file to upload")
		write("Upload> ")
		up = read()
		print("Name in Owncloud")
		write("Name> ")
		fn = read()
		upload()
 elseif sh == "download" then
   print("Select the File to download")
   write("Download> ")
   dow = read()
   print("Select path to save the file")
   write("Save> ")
   pa = read()
   download()
 elseif sh == "list" then
   list()
 elseif sh == "delete" then
   print("What File do you want to delete?")
   write("Delete> ")
   del = read()
   delete()
 elseif sh == "help" then
   print("upload to upload a file")
   print("download to download a file")
   print("list to list all files in your cloud")
   print("delete to delete a file in your cloud")
   print("exit to close the program")
   print("ver to see the version of the program")
   mainshell()
 elseif sh == "ver" then
   print("Version 1.0.1")
   mainshell()
 elseif sh == "exit" then
   exit = 1
 else
   print("Unknown command. Enter help to see all commands")
   mainshell()
 end
end

for n,sSide in ipairs(rs.getSides()) do
  if peripheral.getType(sSide) == "modem" then
    ModemSide = sSide
    break
   end
 end
modem = peripheral.wrap("right")
--print(ModemSide)

con = {}
write("Please enter your username:")
con["user"] = read()
write("Please enter your password:")
con["password"] = read("*")
modem.open(2100)
--modem.transmit(2100,2100,con)
--modem.transmit(
--if con == nil then
--  print("Can't connect to "..idr..". Are you sure, that Owncloud is running on this computer?")
--elseif con == "Wrong login" then
 -- print("Login failed. If you don't know your login, try as root as user and password")  
--else
 mainshell()
--end  
