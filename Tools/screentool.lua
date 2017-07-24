
local tHex = {
    [ colors.white ] = "0",
    [ colors.orange ] = "1",
    [ colors.magenta ] = "2",
    [ colors.lightBlue ] = "3",
    [ colors.yellow ] = "4",
    [ colors.lime ] = "5",
    [ colors.pink ] = "6",
    [ colors.gray ] = "7",
    [ colors.lightGray ] = "8",
    [ colors.cyan ] = "9",
    [ colors.purple ] = "a",
    [ colors.blue ] = "b",
    [ colors.brown ] = "c",
    [ colors.green ] = "d",
    [ colors.red ] = "e",
    [ colors.black ] = "f",
}

local string_rep = string.rep
local string_sub = string.sub

local function create( parent, nX, nY, nWidth, nHeight, bStartVisible )

    if type( parent ) ~= "table" or
       type( nX ) ~= "number" or
       type( nY ) ~= "number" or
       type( nWidth ) ~= "number" or
       type( nHeight ) ~= "number" or
       (bStartVisible ~= nil and type( bStartVisible ) ~= "boolean") then
        error( "Expected object, number, number, number, number, [boolean]", 2 )
    end

    if parent == term then
        error( "term is not a recommended window parent, try term.current() instead", 2 )
    end

    local sEmptySpaceLine
    local tEmptyColorLines = {}
    local function createEmptyLines( nWidth )
        sEmptySpaceLine = string_rep( " ", nWidth )
        for n=0,15 do
            local nColor = 2^n
            local sHex = tHex[nColor]
            tEmptyColorLines[nColor] = string_rep( sHex, nWidth )
        end
    end

    createEmptyLines( nWidth )

    -- Setup
    local bVisible = (bStartVisible ~= false)
    local nCursorX = 1
    local nCursorY = 1
    local bCursorBlink = false
    local nTextColor = colors.white
    local nBackgroundColor = colors.black
    local tLines = {}
    do
        local sEmptyText = sEmptySpaceLine
        local sEmptyTextColor = tEmptyColorLines[ nTextColor ]
        local sEmptyBackgroundColor = tEmptyColorLines[ nBackgroundColor ]
        for y=1,nHeight do
            tLines[y] = {
                text = sEmptyText,
                textColor = sEmptyTextColor,
                backgroundColor = sEmptyBackgroundColor,
            }
        end
    end

    -- Helper functions
    local function updateCursorPos()
        if nCursorX >= 1 and nCursorY >= 1 and
           nCursorX <= nWidth and nCursorY <= nHeight then
            parent.setCursorPos( nX + nCursorX - 1, nY + nCursorY - 1 )
        else
            parent.setCursorPos( 0, 0 )
        end
    end
    
    local function updateCursorBlink()
        parent.setCursorBlink( bCursorBlink )
    end
    
    local function updateCursorColor()
        parent.setTextColor( nTextColor )
    end
    
    local function redrawLine( n )
        local tLine = tLines[ n ]
        parent.setCursorPos( nX, nY + n - 1 )
        parent.blit( tLine.text, tLine.textColor, tLine.backgroundColor )
    end

    local function redraw()
        for n=1,nHeight do
            redrawLine( n )
        end
    end

    local function internalBlit( sText, sTextColor, sBackgroundColor )
        local nStart = nCursorX
        local nEnd = nStart + #sText - 1
        if nCursorY >= 1 and nCursorY <= nHeight then
            if nStart <= nWidth and nEnd >= 1 then
                -- Modify line
                local tLine = tLines[ nCursorY ]
                if nStart == 1 and nEnd == nWidth then
                    tLine.text = sText
                    tLine.textColor = sTextColor
                    tLine.backgroundColor = sBackgroundColor
                else
                    local sClippedText, sClippedTextColor, sClippedBackgroundColor
                    if nStart < 1 then
                        local nClipStart = 1 - nStart + 1
                        local nClipEnd = nWidth - nStart + 1
                        sClippedText = string_sub( sText, nClipStart, nClipEnd )
                        sClippedTextColor = string_sub( sTextColor, nClipStart, nClipEnd )
                        sClippedBackgroundColor = string_sub( sBackgroundColor, nClipStart, nClipEnd )
                    elseif nEnd > nWidth then
                        local nClipEnd = nWidth - nStart + 1
                        sClippedText = string_sub( sText, 1, nClipEnd )
                        sClippedTextColor = string_sub( sTextColor, 1, nClipEnd )
                        sClippedBackgroundColor = string_sub( sBackgroundColor, 1, nClipEnd )
                    else
                        sClippedText = sText
                        sClippedTextColor = sTextColor
                        sClippedBackgroundColor = sBackgroundColor
                    end

                    local sOldText = tLine.text
                    local sOldTextColor = tLine.textColor
                    local sOldBackgroundColor = tLine.backgroundColor
                    local sNewText, sNewTextColor, sNewBackgroundColor
                    if nStart > 1 then
                        local nOldEnd = nStart - 1
                        sNewText = string_sub( sOldText, 1, nOldEnd ) .. sClippedText
                        sNewTextColor = string_sub( sOldTextColor, 1, nOldEnd ) .. sClippedTextColor
                        sNewBackgroundColor = string_sub( sOldBackgroundColor, 1, nOldEnd ) .. sClippedBackgroundColor
                    else
                        sNewText = sClippedText
                        sNewTextColor = sClippedTextColor
                        sNewBackgroundColor = sClippedBackgroundColor
                    end
                    if nEnd < nWidth then
                        local nOldStart = nEnd + 1
                        sNewText = sNewText .. string_sub( sOldText, nOldStart, nWidth )
                        sNewTextColor = sNewTextColor .. string_sub( sOldTextColor, nOldStart, nWidth )
                        sNewBackgroundColor = sNewBackgroundColor .. string_sub( sOldBackgroundColor, nOldStart, nWidth )
                    end

                    tLine.text = sNewText
                    tLine.textColor = sNewTextColor
                    tLine.backgroundColor = sNewBackgroundColor
                end

                -- Redraw line
                if bVisible then
                    redrawLine( nCursorY )
                end
            end
        end

        -- Move and redraw cursor
        nCursorX = nEnd + 1
        if bVisible then
            updateCursorColor()
            updateCursorPos()
        end
    end

    -- Terminal implementation
    local window = {}

    function window.write( sText )
        sText = tostring( sText )
        internalBlit( sText, string_rep( tHex[ nTextColor ], #sText ), string_rep( tHex[ nBackgroundColor ], #sText ) )
    end

    function window.blit( sText, sTextColor, sBackgroundColor )
        if type(sText) ~= "string" or type(sTextColor) ~= "string" or type(sBackgroundColor) ~= "string" then
            error( "Expected string, string, string", 2 )
        end
        if #sTextColor ~= #sText or #sBackgroundColor ~= #sText then
            error( "Arguments must be the same length", 2 )
        end
        internalBlit( sText, sTextColor, sBackgroundColor )
    end

    function window.clear()
        local sEmptyText = sEmptySpaceLine
        local sEmptyTextColor = tEmptyColorLines[ nTextColor ]
        local sEmptyBackgroundColor = tEmptyColorLines[ nBackgroundColor ]
        for y=1,nHeight do
            tLines[y] = {
                text = sEmptyText,
                textColor = sEmptyTextColor,
                backgroundColor = sEmptyBackgroundColor,
            }
        end
        if bVisible then
            redraw()
            updateCursorColor()
            updateCursorPos()
        end
    end

    function window.clearLine()
        if nCursorY >= 1 and nCursorY <= nHeight then
            local sEmptyText = sEmptySpaceLine
            local sEmptyTextColor = tEmptyColorLines[ nTextColor ]
            local sEmptyBackgroundColor = tEmptyColorLines[ nBackgroundColor ]
            tLines[ nCursorY ] = {
                text = sEmptyText,
                textColor = sEmptyTextColor,
                backgroundColor = sEmptyBackgroundColor,
            }
            if bVisible then
                redrawLine( nCursorY )
                updateCursorColor()
                updateCursorPos()
            end
        end
    end

    function window.getCursorPos()
        return nCursorX, nCursorY
    end

    function window.setCursorPos( x, y )
        nCursorX = math.floor( x )
        nCursorY = math.floor( y )
        if bVisible then
            updateCursorPos()
        end
    end

    function window.setCursorBlink( blink )
        bCursorBlink = blink
        if bVisible then
            updateCursorBlink()
        end
    end

    local function isColor()
        return parent.isColor()
    end

    function window.isColor()
        return isColor()
    end

    function window.isColour()
        return isColor()
    end

    local function setTextColor( color )
        if not parent.isColor() then
            if color ~= colors.white and color ~= colors.black and color ~= colors.gray and color ~= colors.lightGray then
                error( "Color not supported", 3 )
            end
        end
        nTextColor = color
        if bVisible then
            updateCursorColor()
        end
    end

    function window.setTextColor( color )
        setTextColor( color )
    end

    function window.setTextColour( color )
        setTextColor( color )
    end

    local function setBackgroundColor( color )
        if not parent.isColor() then
            if color ~= colors.white and color ~= colors.black and color ~= colors.gray and color ~= colors.lightGray then
                error( "Color not supported", 3 )
            end
        end
        nBackgroundColor = color
    end

    function window.setBackgroundColor( color )
        setBackgroundColor( color )
    end

    function window.setBackgroundColour( color )
        setBackgroundColor( color )
    end

    function window.getSize()
        return nWidth, nHeight
    end

    function window.scroll( n )
        if n ~= 0 then
            local tNewLines = {}
            local sEmptyText = sEmptySpaceLine
            local sEmptyTextColor = tEmptyColorLines[ nTextColor ]
            local sEmptyBackgroundColor = tEmptyColorLines[ nBackgroundColor ]
            for newY=1,nHeight do
                local y = newY + n
                if y >= 1 and y <= nHeight then
                    tNewLines[newY] = tLines[y]
                else
                    tNewLines[newY] = {
                        text = sEmptyText,
                        textColor = sEmptyTextColor,
                        backgroundColor = sEmptyBackgroundColor,
                    }
                end
            end
            tLines = tNewLines
            if bVisible then
                redraw()
                updateCursorColor()
                updateCursorPos()
            end
        end
    end

    function window.getTextColor()
        return nTextColor
    end

    function window.getTextColour()
        return nTextColor
    end

    function window.getBackgroundColor()
        return nBackgroundColor
    end

    function window.getBackgroundColour()
        return nBackgroundColor
    end

    -- Other functions
    function window.getLine(nLine)
        return tLines[nLine]
    end

    function window.setVisible( bVis )
        if bVisible ~= bVis then
            bVisible = bVis
            if bVisible then
                window.redraw()
            end
        end
    end

    function window.redraw()
        if bVisible then
            redraw()
            updateCursorBlink()
            updateCursorColor()
            updateCursorPos()
        end
    end

    function window.restoreCursor()
        if bVisible then
            updateCursorBlink()
            updateCursorColor()
            updateCursorPos()
        end
    end

    function window.getPosition()
        return nX, nY
    end

    function window.reposition( nNewX, nNewY, nNewWidth, nNewHeight )
        nX = nNewX
        nY = nNewY
        if nNewWidth and nNewHeight then
            local tNewLines = {}
            createEmptyLines( nNewWidth )
            local sEmptyText = sEmptySpaceLine
            local sEmptyTextColor = tEmptyColorLines[ nTextColor ]
            local sEmptyBackgroundColor = tEmptyColorLines[ nBackgroundColor ]
            for y=1,nNewHeight do
                if y > nHeight then
                    tNewLines[y] = {
                        text = sEmptyText,
                        textColor = sEmptyTextColor,
                        backgroundColor = sEmptyBackgroundColor
                    }
                else
                    local tOldLine = tLines[y]
                    if nNewWidth == nWidth then
                        tNewLines[y] = tOldLine
                    elseif nNewWidth < nWidth then
                        tNewLines[y] = {
                            text = string_sub( tOldLine.text, 1, nNewWidth ),
                            textColor = string_sub( tOldLine.textColor, 1, nNewWidth ),
                            backgroundColor = string_sub( tOldLine.backgroundColor, 1, nNewWidth ),
                        }
                    else
                        tNewLines[y] = {
                            text = tOldLine.text .. string_sub( sEmptyText, nWidth + 1, nNewWidth ),
                            textColor = tOldLine.textColor .. string_sub( sEmptyTextColor, nWidth + 1, nNewWidth ),
                            backgroundColor = tOldLine.backgroundColor .. string_sub( sEmptyBackgroundColor, nWidth + 1, nNewWidth ),
                        }
                    end
                end
            end
            nWidth = nNewWidth
            nHeight = nNewHeight
            tLines = tNewLines
        end
        if bVisible then
            window.redraw()
        end
    end

    if bVisible then
        window.redraw()
    end
    return window
end

local win = create(term.current(),1,1,51,19)

local function screen()
    while true do
        local ev,me = os.pullEvent("key_up")
        if me == keys.pause then
            local a,b = term.getSize()
            local file = fs.open("/screen/"..os.clock()..".nft","w")
            for i=1,b do
                local ta = win.getLine(i)
                for w = 1, #ta.text do
                    file.write("\30"..ta.backgroundColor:sub(w,w))
                    file.write("\31"..ta.textColor:sub(w,w))
                    file.write(ta.text:sub(w,w))
                end
                file.write("\n")
            end
            file.close()
        end
    end
end

local function run()
    shell.run("shell")
end

term.redirect(win)
parallel.waitForAny(run,screen)
