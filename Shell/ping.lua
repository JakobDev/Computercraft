local tArgs = {...}
if tArgs[1] == nil then
  printError("Usage: ping <url> <times>")
  return 1
end
local times = 3
if tArgs[2] ~= nil then
  times = tonumber(tArgs[2])
end
if tArgs[1]:find("http") ~= 1 then
  tArgs[1] = "http://"..tArgs[1]
end
print("Ping "..tArgs[1])
for i=1,times do
  local time = os.time()
  if http.get(tArgs[1]) == nil then
    print("Unknown host")
  else
    print("Got request in "..tostring((os.time()-time)*1000).." ms")
  end
end
