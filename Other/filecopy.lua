local Arg = {...}

os.loadAPI("clipboard")

if Arg[1] == nil then
  print("Usage: filecopy <path>")
  return
end

if clipboard == nil then
  print("Clipboard API was not found")
  return
end
  
local filename = shell.resolve(Arg[1])

if fs.exists(filename) == false then
  print("File not found")
  return
end

local filehandle = fs.open(filename,"r")
clipboard.setText(filehandle.readAll())
filehandle.close()
