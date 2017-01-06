if type(oldday) == "function" then
  os.day = oldday
end

oldday = os.day
write("Enter new day:")
local newday = tonumber(read())

if newday == nil then
  print("Please enter number")
  return
end

local nowday = os.day()
difday = newday-nowday

function os.day()
return oldday()+difday
end
