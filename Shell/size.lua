local Arg = {...}

if Arg[1] == nil then
  print("Usage: size <path>")
  return
end

if fs.exists(Arg[1]) == true then
  print("Size: "..fs.getSize(Arg[1]))
else
  print("File does not exists")
end
