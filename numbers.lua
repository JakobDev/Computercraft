zahl = 1
while true do
print(zahl)
zahl = zahl + 1
sleep(1)
random = math.random(1,8)
if random == 1 then
  term.setTextColor(colors.white)
elseif random == 2 then
  term.setTextColor(colors.pink)
elseif random == 3 then
  term.setTextColor(colors.blue)
elseif random == 4 then
  term.setTextColor(colors.green)
elseif random == 5 then
  term.setTextColor(colors.red)
elseif random == 6 then
  term.setTextColor(colors.yellow)
elseif random == 7 then
  term.setTextColor(colors.purple)
elseif random == 8 then
  term.setTextColor(colors.orange)
end
if zahl == 1500 then
  zahl = 0
end
end
