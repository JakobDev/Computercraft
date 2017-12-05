local tArgs = { ... }

if tArgs[1] == nil then
    printError( "Usage: touch <path>" )
    return 1
end

local sPath = shell.resolve( tArgs[1] )

if fs.isReadOnly( sPath ) then
    printError( "/" .. sPath .. " is readonly" )
    return 2
end

local file = fs.open( sPath, "a" )
file.close()

return 0
