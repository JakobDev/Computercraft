local nScreenw,nScreenh = term.getSize()

if not term.isColour() then
    print("Requires an Advanced Computer")
    return
end

local function completeMultipleChoice( sText, tOptions, bAddSpaces )
    local tResults = {}
    for n=1,#tOptions do
        local sOption = tOptions[n]
        if #sOption + (bAddSpaces and 1 or 0) > #sText and string.sub( sOption, 1, #sText ) == sText then
            local sResult = string.sub( sOption, #sText + 1 )
            if bAddSpaces then
                table.insert( tResults, sResult .. " " )
            else
                table.insert( tResults, sResult )
            end
        end
    end
    return tResults
end

local function completeFile( shell, nIndex, sText, tPreviousText )
    if nIndex == 1 then
        return fs.complete( sText, shell.dir(), true, false )
    end
end

shell.setCompletionFunction(shell.getRunningProgram(),completeFile)

local tArgs = {...}
if #tArgs == 0 then
    print("Usage: textpaint <path>")
    return
end
local sFile = shell.resolve(tArgs[1])
local bReadOnly = fs.isReadOnly(sFile)
if fs.exists(sFile) and fs.isDir(sFile) then
    print("Cannot edit a directory.")
    return
end

local tField = {}

local function clear()
for i=1,nScreenh-1 do
    tField[i] = {}
    tField[i]["text"] = ""
    for a=1,nScreenw-1 do
        tField[i]["text"] = tField[i]["text"].." "
    end
    tField[i]["color"] = ""
    for a=1,nScreenw-1 do
        tField[i]["color"] = tField[i]["color"].."0"
    end
    tField[i]["background"] = ""
    for a=1,nScreenw-1 do
        tField[i]["background"] = tField[i]["background"].."0"
    end
end
end
clear()

local function replacechar(pos, str, r)
    return str:sub(1, pos-1) .. r .. str:sub(pos+1)
end

-- Create .nfp files by default
if not fs.exists( sFile ) and not string.find( sFile, "%." ) then
    local sExtension = ".nft"
    if sExtension ~= "" then
        sFile = sFile..sExtension
    end
end

if fs.exists(sFile) == true then
    local fileh = fs.open(sFile,"r")
    local sMode = "text"
    local nReadColor = "0"
    local nReadBackground = "0"
    for i=1,nScreenh-1 do
        local nCou = 1
        local sLine = fileh.readLine()
        for a = 1, #sLine do
            local c = sLine:sub(a,a)
            if c == "\30" then
                sMode = "background"
            elseif c == "\31" then
                sMode = "color"
            elseif sMode == "background" then
                nReadBackground = c
                sMode = "text"
            elseif sMode == "color" then
                nReadColor = c
                sMode = "text"
            elseif sMode == "text" then
                tField[i]["text"] = replacechar(nCou,tField[i]["text"],c)
                tField[i]["background"] = replacechar(nCou,tField[i]["background"],nReadBackground)
                tField[i]["color"] = replacechar(nCou,tField[i]["color"],nReadColor)
                nCou = nCou + 1
            end
        end
    end
end

local tColors = {}
table.insert(tColors,"0")
table.insert(tColors,"1")
table.insert(tColors,"2")
table.insert(tColors,"3")
table.insert(tColors,"4")
table.insert(tColors,"5")
table.insert(tColors,"6")
table.insert(tColors,"7")
table.insert(tColors,"8")
table.insert(tColors,"9")
table.insert(tColors,"a")
table.insert(tColors,"b")
table.insert(tColors,"c")
table.insert(tColors,"d")
table.insert(tColors,"e")
table.insert(tColors,"f")

local tHex = {}
tHex["0"] = 1
tHex["1"] = 2
tHex["2"] = 4
tHex["3"] = 8
tHex["4"] = 16
tHex["5"] = 32
tHex["6"] = 64
tHex["7"] = 128
tHex["8"] = 256
tHex["9"] = 512
tHex["a"] = 1024
tHex["b"] = 2048
tHex["c"] = 4096
tHex["d"] = 8192
tHex["e"] = 16384
tHex["f"] = 32768

local nBackground = "0"
local nColor = "0"
local nPosX = 1
local nPosY = 1
local bWrite = false
local nMenuColor = 2^math.random(1,15)
--[[
local function replacechar(pos, str, r)
    return str:sub(1, pos-1) .. r .. str:sub(pos+1)
end
--]]

local function redraw()
    term.setBackgroundColor(nMenuColor)
    for i=1,nScreenh-1 do
        term.setCursorPos(1,i)
        term.blit(tField[i]["text"],tField[i]["color"],tField[i]["background"])
        term.setCursorPos(nScreenw,i)
        if type(tColors[i]) == "string" then
            term.blit(" ","0",tColors[i])
        else
            term.write(" ")
        end
    end
    term.setCursorPos(1,nScreenh)
    term.clearLine()
    term.setTextColor(colors.white)
    term.write("Save Exit Clear")
    term.setTextColor(tHex[nColor])
    term.setCursorPos(nPosX,nPosY)
    term.setCursorBlink(bWrite)
end

redraw()

while true do
    local ev,me,x,y = os.pullEvent()
    if ev == "mouse_click" then
        if me == 1 then
            if x == nScreenw and y ~= nScreenh then
                if type(tColors[y]) == "string" then
                    nBackground = tColors[y]
                    nColor = tColors[y]
                    term.setTextColor(tHex[nColor])
                end
            elseif x ~= nScreenw and y ~= nScreenh then
                tField[y]["background"] = replacechar(x,tField[y]["background"],nBackground)
                redraw()
            elseif y == nScreenh then
                if x < 5 then 
                    --Save
                    local fileh = fs.open(sFile,"w")
                    local nWriteColor
                    local nWriteBackground
                    for i=1,nScreenh-1 do
                        for a = 1, #tField[i]["text"] do
                            local t = tField[i]["text"]:sub(a,a)
                            local c = tField[i]["color"]:sub(a,a)
                            local b = tField[i]["background"]:sub(a,a)
                            if b ~= nWriteBackground then
                                nWriteBackground = b
                                fileh.write("\30"..b)
                            end
                            if c ~= nWriteColor then
                                nWriteColor = c
                                fileh.write("\31"..c)
                            end
                            fileh.write(t)
                        end
                        nWriteColor = nil
                        nWriteBackground = nil
                        fileh.write("\n")
                    end
                    fileh.close()
                elseif x > 5 and x < 10 then
                    break
                elseif x > 10 and x < 16 then
                    clear()
                    redraw()
                end
            end
        elseif me == 2 then
            if  x == nScreenw or y == nScreenh then
                bWrite = false
                term.setCursorBlink(false)
            else
                nPosX = x
                nPosY = y
                term.setCursorPos(nPosX,nPosY)
                term.setCursorBlink(true)
                term.setTextColor(tHex[nColor])
                bWrite = true
            end
        end
    elseif ev == "mouse_drag" and x ~= nScreenw and y ~= nScreenh then
        tField[y]["background"] = replacechar(x,tField[y]["background"],nBackground)
        redraw()
    elseif ev == "char" and bWrite == true then
        tField[nPosY]["text"] = replacechar(nPosX,tField[nPosY]["text"],me)
        tField[nPosY]["color"] = replacechar(nPosX,tField[nPosY]["color"],nColor)
        nPosX = nPosX + 1
        if nPosX == nScreenw then
            if nPosY == nScreenh-1 then
                bWrite = false
            else
                nPosY = nPosY + 1
                nPosX = 1
            end
        end
        redraw()
    elseif ev == "key" and bWrite == true then
        if me == keys.enter then
            if nPosY ~= nScreenh-1 then
                nPosY = nPosY + 1
                nPosX = 1
            end
            redraw()
        elseif me == keys.backspace then
            if nPosX == 1 then
                if  nPosY ~= 1 then
                    nPosX = nScreenw-1
                    nPosY = nPosY - 1
                end
            else
                nPosX = nPosX -1
            end
            tField[nPosY]["text"] = replacechar(nPosX,tField[nPosY]["text"]," ")
            tField[nPosY]["color"] = replacechar(nPosX,tField[nPosY]["color"],nColor)
            redraw()
        end
    end
end

term.setBackgroundColor(colors.black)
term.setTextColor(colors.white)
term.clear()
term.setCursorPos(1,1)
