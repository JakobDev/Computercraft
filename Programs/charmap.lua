term.clear()
term.setCursorPos(1,1)
local pos = 1
local max,high = term.getSize()
local line = 1
local tChars = {}
for i=1,high do
    tChars[i] = {}
end
for i=0,255 do
   term.write(string.char(i))
   tChars[line][pos] = i
   pos = pos + 1
   if pos == max+1 then
       line = line + 1
       term.setCursorPos(1,line)
       pos = 1
   end
end

print()
print()
print("Click a char to see his Number. Press any Key to Exit")
local _,endpos = term.getCursorPos()

while true do
    local ev,me,x,y = os.pullEvent()
    if ev == "mouse_click" then
        if tChars[y][x] ~= nil then
            term.setCursorPos(1,endpos+2)
            term.clearLine()
            term.write(tChars[y][x])
        end
    elseif ev == "char" then
        break
    end
end

term.clear()
term.setCursorPos(1,1)
