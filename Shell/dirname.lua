local tArgs = {...}
if tArgs[1] == nil then
    print("Usage: dirname <path>")
    return 1
end
print("/"..fs.getDir(tArgs[1]))
