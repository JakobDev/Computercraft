local Arg = {...}

if not Arg[1] then
  print("Usage: wc <file>")
  return
end

local filename = shell.resolve(Arg[1])

if fs.exists(filename) == false then
  print("File not found")
  return
end

local coufile = fs.open(filename,"r")
local loop = true
local linecou = 0
local lines = {}

while loop == true do
local linecon = coufile.readLine()
if linecon == nil then
  coufile.close()
  loop = nil
else
  table.insert(lines,linecon)
  linecou = linecou + 1
end
end

local charcou = 0
local wordchange = false
local wordcou = 1

for _,linecon in ipairs(lines) do
wordcou = wordcou + 1
wordchange = false
for i = 1,#linecon do
local c = linecon:sub(i,i)
charcou = charcou + 1
if string.byte(c,1) == 32 then
  wordchange = true
else
  if wordchange == true then
    wordcou = wordcou + 1
    wordchange = false
  end
end
end
end

wordcou = wordcou - 1
linecou = linecou - 1

print(linecou.." Lines")
print(wordcou.." Words")
print(charcou.." Characters")
