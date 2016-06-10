function langtunnel()
lang = lang - 1
if lang == 0 then
  exit = 1
else
  Haupttunnel()
end
end

function minetunnel()
if Richtung == "rechts" then
  turtle.turnRight()
end
s2 = 1
sm = mine
while s2 == 1 do
turtle.dig()
turtle.up()
turtle.dig()
turtle.down()
turtle.forward()
sm = sm - 1
if sm == 0 then
  s2 = 0
end
end
s3 = 1
sm = mine
turtle.turnLeft()
turtle.turnLeft()
while s3 == 1 do
turtle.forward()
sm = sm - 1
if sm == 0 then
s3 = 0
end
end
if Richtung == "rechts" then
  Richtung = "links"
  minetunnel()
elseif Richtung == "links" then
  turtle.turnLeft()
  Richtung = "rechts"
  langtunnel()
end
end

function Haupttunnel()
sh = weg
s1 = 1
while s1 == 1 do
turtle.dig()
turtle.up()
turtle.dig()
turtle.down()
turtle.forward()
sh = sh - 1
if sh == 0 then
s1 = 0
end
end
minetunnel()
end

function mine()
write("How often I will mine? ")
lang = read()
write("How long are the minetunnels? ")
mine = read()
write("How long are the distance between the tunnels? ")
weg = read()
Haupttunnel()
end
Richtung = "rechts"
mine()

