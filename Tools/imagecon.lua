local function betterNumber(num)
local str = tostring(num)
if #str == 1 then
    return "0000"..str
elseif #str == 2 then
    return "000"..str
elseif #str == 3 then
    return "00"..str
elseif #str == 4 then
    return "0"..str
elseif #str == 5 then
    return str
end
end

local tArgs = {...}
if #tArgs < 2 then
    printError("Usage: imagecon <input> <output>")
    return 1
end
local tImage = paintutils.loadImage(tArgs[1])
if tImage == nil then
    printError("Not a Picture")
    return
end
local tFile = fs.open(tArgs[2],"w")
--Get Size
local nSize = 0
for k,v in ipairs(tImage) do
    if #v > nSize then
        nSize = #v
    end
end
--Write Image
tFile.writeLine("local tImage = {")
for k,v in ipairs(tImage) do
    local writestr = "{"
    for a,b in ipairs(v) do
        writestr = writestr..betterNumber(b)..","
    end
    for i=0,nSize-#v-1 do
        writestr = writestr.."00000"..","
    end
    writestr = writestr:sub(1,-2)
    writestr = writestr.."},"
    tFile.writeLine(writestr)
end
tFile.writeLine("}\n")
tFile.writeLine("paintutils.drawImage(tImage,1,1)")
tFile.close()
