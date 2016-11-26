local cow = {}

function cow.cow(text)
print("______")
print("< "..text.." >")
print("------")
print("        \\   ^__^")
print("         \\  (oo)\\_______")
print("            (__)\\       )\\/\\ ")
print("                ||----w |")
print("                ||     ||")
end

function cow.head(text)
print(" _______")
print("< "..text.." >")
print(" -------")
print("    \\")
print("     \\")
print("    ^__^         /")
print("    (@@)\\_______/  _________")
print("    (__)\\       )=(  ____|_ \\_____")
print("        ||----w |  \\ \\     \\_____ |")
print("        ||     ||   ||           ||")
end

function cow.eyes(text)
print(" _______")
print("< "..text.." >")
print(" -------")
print("    \\")
print("     \\")
print("                                   .::!!!!!!!:.")
print("  .!!!!!:.                        .:!!!!!!!!!!!!")
print("  ~~~~!!!!!!.                 .:!!!!!!!!!UWWW$$$")
print("      :$$NWX!!:           .:!!!!!!XUWW$$$$$$$$$P")
print('      $$$$$##WX!:      .<!!!!UW$$$$"  $$$$$$$$#')
print("      $$$$$  $$$UX   :!!UW$$$$$$$$$   4$$$$$*")
print('      ^$$$B  $$$$\     $$$$$$$$$$$$   d$$R"')
print('        "*$bd$$$$      \'*$$$$$$$$$$$o+#"') 
print('             """"          """""""')
end

function cow.tux(text)
print(" _____")
print("< "..text.." >")
print(" -----")
print("   \\")
print("    \\")
print("        .--.")
print("       |o_o |")
print("       |:_/ |")
print("      //   \\ \\")
print("     (|     | )")
print("    /'\\_   _/`\\")
print("    \\___)=(___/")
end

function cow.vader(text)
print("_________")
print("< "..text.." >")
print(" ---------")
print("        \\    ,-^-.")
print("         \\   !oYo!")
print("          \\ /./=\\.\\______")
print("               ##        )\\/\\")
print("                ||-----w||")
print("                ||      ||")
print("")
print("               Cowth Vader")
end

function cow.sheep(text)
print("_________")
print("< "..text.." >")
print(" ---------")
print("  \\")
print("   \\")
print("       __")
print("      UooU\\.'@@@@@@`.")
print("      \\__/(@@@@@@@@@@)")
print("           (@@@@@@@@)")
print("           `YY~~~~YY'")
print("            ||    ||")
end

function cow.duck(text)
print("_________")
print("< "..text.." >")
print(" ---------")
print(" \\")
print("  \\")
print("   \\ >()_")
print("      (__)__ _")
end

function cow.snowman(text)
print("________")
print("< "..text.." >")
print(" --------")
print("   \\")
print(" ___###")
print("   /oo\\ |||")
print("   \\  / \\|/")
print('   /""\\  I')
print("()|    |(I)")
print("   \\  /  I")
print('  /""""\\ I')
print(" |      |I")
print(" |      |I")
print("  \\____/ I")
end

function cow.skeleton(text)
print("________")
print("< "..text.." >")
print(" --------")
print("          \\      (__)")
print("           \\     /oo|")
print("            \\   (_\"_)*+++++++++*")
print("                   //I#\\\\\\\\\\\\\\\\I\\")
print("                   I[I|I|||||I I `")
print("                   I`I'///'' I I")
print("                   I I       I I")
print("                   ~ ~       ~ ~")
print("                     Scowleton")
end

function cow.koala(text)
print(" ______")
print("< "..text.." >")
print(" ------")
print("  \\")
print("   \\")
print("       ___")
print("     {~._.~}")
print("      ( Y )")
print("     ()~*~()")
print("     (_)-(_)")
end

function cow.elephant(text)
print("____")
print("< "..text.." >")
print(" ----")
print(" \\     /\\  ___  /\\")
print("  \\   // \\/   \\/ \\\\")
print("     ((    O O    ))")
print("      \\\\ /     \\ //")
print("       \\/  | |  \\/")
print("        |  | |  |")
print("        |  | |  |")
print("        |   o   |")
print("        | |   | |")
print("        |m|   |m|")
end

function cow.moose(text)
print(" ______")
print("< "..text.." >")
print(" ------")
print("  \\")
print("   \\   \\_\\_    _/_/")
print("    \\      \\__/")
print("           (oo)\\_______")
print("           (__)\\       )\\/\\")
print("               ||----w |")
print("               ||     ||")
end

function cow.hellokitty(text)
print(" ____")
print("< "..text.." >")
print(" ----")
print("  \\")
print("   \\")
print("      /\\_)o<")
print("     |      \\")
print("     | O . O|")
print("      \\_____/")
end

function cow.random(text)
local rancou = 0
local randomta = {}
for _,con in pairs(cow) do
table.insert(randomta,con)
rancou = rancou + 1
end
randomta[math.random(1,rancou)](text)
end

table.sort(cow)

local Args = {...}

if Args[1] == nil then
  print("Usage: cowsay -f <cow> <text>")
  return 1
end

local cowchoice

if Args[1] == "-f" then
 table.remove(Args,1)
 cowchoice = Args[1]
 table.remove(Args,1)
elseif Args[1] == "-l" then
	for ind,_ in pairs(cow) do
		write(ind.." ")
	end
	print()
        return 0
else
  cowchoice = "cow"
end

if Args[1] == nil then
  print("Usage: cowsay -f <cow> <text>")
  return 1
end

local cowsay = ""

for _,text in ipairs(Args) do
cowsay = cowsay.." "..text
end
cowsay = cowsay:sub(2,-1)


if type(cow[cowchoice]) == "function" then
  cow[cowchoice](cowsay)
else
  print("Can't find cow \""..cowchoice.."\". Use cowsay -l to list all cows.")
  return 2
end

return 0
