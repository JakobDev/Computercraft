write("Please enter new Computer ID:")
newid = read()
newid = tonumber(newid)
if newid == nil then
  print("Please enter number")
  return
end

function os.getComputerID()
  return newid
end
