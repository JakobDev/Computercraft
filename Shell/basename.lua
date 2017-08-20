local tArgs = {...}
if tArgs[1] == nil then
    print("Usage: basename <path>")
    return 1
end
print(fs.getName(tArgs[1]))
