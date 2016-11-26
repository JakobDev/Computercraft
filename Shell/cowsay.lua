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

local function headin(text)
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

cow["head-in"] = headin

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

function cow.cock(text)
print(" ______")
print("< "..text.." >")
print(" ------")
print("    \\")
print("     \\  /\\/\\")
print("       \\   /")
print("       |  0 >>")
print("       |___|")
print(" __((_<|   |")
print("(          |")
print("(__________)")
print("   |      |")
print("   |      |")
print("   /\\     /\\")
end

function cow.moofasa(text)
print(" ______")
print("< "..text.." >")
print(" ------")
print("       \\    ____")
print("        \\  /    \\")
print("          | ^__^ |")
print("          | (oo) |______")
print("          | (__) |      )\\/\\")
print("           \\____/|----w |")
print("                ||     ||")
print("")
print("                 Moofasa")
end

function cow.suse(text)
print(" _____")
print("< "..text.." >")
print(" -----")
print("  \\")
print("   \\____")
print("  /@    ~-.")
print("  \\/ __ .- |")
print("   // //  @")
end

function cow.bong(text)
print(" _______")
print("< "..text.." >")
print(" -------")
print("         \\")
print("          \\")
print("            ^__^ ")
print("    _______/(oo)")
print("/\\/(       /(__)")
print("   | W----|| |~|")
print("   ||     || |~|  ~~")
print("             |~|  ~")
print("             |_| o")
print("             |#|/")
print("            _+#+_")
end

function cow.kosh(text)
print(" ____")
print("< "..text.." >")
print(" ----")
print("    \\")
print("     \\")
print("      \\")
print("  ___       _____     ___")
print(" /   \\     /    /|   /   \\")
print("|     |   /    / |  |     |")
print("|     |  /____/  |  |     |     ")
print("|     |  |    |  |  |     |")
print("|     |  | {} | /   |     |")
print("|     |  |____|/    |     |")
print("|     |    |==|     |     |")
print("|      \\___________/      |")
print("|                         |")
print("|                         |")
end

local function flamingsheep(text)
print("____")
print("< "..text.." >")
print(" ----")
print("  \\            .    .     .   ")
print("   \\      .  . .     `  ,     ")
print("    \\    .; .  : .' :  :  : . ")
print("     \\   i..`: i` i.i.,i  i . ")
print("      \\   `,--.|i |i|ii|ii|i: ")
print("           UooU\\.'@@@@@@`.||' ")
print("           \\__/(@@@@@@@@@@)'  ")
print("                (@@@@@@@@)    ")
print("                `YY~~~~YY'    ")
print("                 ||    ||     ")
end

cow["flaming-sheep"] = flamingsheep

function cow.bunny(text)
print(" ____")
print("< "..text.." >")
print(" ----")
print("  \\")
print("   \\   \\")
print("        \\ /\\")
print("        ( )")
print("      .( o ).")
end

function cow.apt(text)
print(" _____")
print("< "..text.." >")
print(" -----")
print("       \\ (__)")
print("         (oo)")
print("   /------\\/")
print("  / |    ||")
print(" *  /\\---/\\")
print("    ~~   ~~")
end

function cow.pony(text)
print(" _______")
print("< "..text.." >")
print(" -------")
print("     \\      _^^")
print("      \\   _- oo\\")
print("          \\----- \\______")
print("                \\       )\\")
print("                ||-----|| \\")
print("                ||     ||")
end

function cow.unipony(text)
print("____")
print("< "..text.." >")
print(" ----")
print("   \\        \\")
print("    \\        \\")
print("     \\       _\\^")
print("      \\    _- oo\\")
print("           \\---- \\______")
print("                 \\       )\\")
print("                ||-----||  \\")
print("                ||     ||")
end

local function lukekoala(text)
print(" _______")
print("< "..text.." >")
print(" -------")
print("  \\")
print("   \\          .")
print("       ___   //")
print("     {~._.~}// ")
print("      ( Y )K/  ")
print("     ()~*~()   ")
print("     (_)-(_)   ")
print("     Luke    ")
print("     Skywalker")
print("     koala   ")
end

cow["luke-koala"] = lukekoala

local function sodasheep(text)
print(" _____")
print("< "..text.." >")
print(" -----")
print("  \\                 __ ")
print("   \\               (oo)")
print("    \\              (  )")
print("     \\             /--\\")
print("       __         / \\  \\ ")
print("      UooU\\.'@@@@@@`.\\  )")
print("      \\__/(@@@@@@@@@@) /")
print("           (@@@@@@@@)(( ")
print("           `YY~~~~YY' \\\\")
print("            ||    ||   >> ")
end

cow["sodomized-sheep"] = sodasheep

function cow.cower(text)
print("____")
print("< "..text.." >")
print(" ----")
print("     \\")
print("      \\")
print("        ,__, |    | ")
print("        (oo)\\|    |___")
print("        (__)\\|    |   )\\_")
print("             |    |_w |  \\")
print("             |    |  ||   *")
print("")
print("             Cower....")
end

local function budfrogs(text)
print(" ____")
print("< "..text.." >")
print(" ----")
print("     \\")
print("      \\")
print("          oO)-.                       .-(Oo")
print("         /__  _\\                     /_  __\\")
print("         \\  \\(  |     ()~()         |  )/  /")
print("          \\__|\\ |    (-___-)        | /|__/")
print("          '  '--'    ==`-'==        '--'  '")
end

cow["bud-frogs"] = budfrogs

function cow.kitty(text)
print(" ____")
print("< "..text.." >")
print(" ----")
print("     \\")
print("      \\")
print("      (\"`-'  '-/\") .___..--' ' \"`-._")
print("         ` *_ *  )    `-.   (      ) .`-.__. `)")
print("         (_Y_.) ' ._   )   `._` ;  `` -. .-'")
print("      _.. `--'_..-_/   /--' _ .' ,4")
print("   ( i l ),-''  ( l i),'  ( ( ! .-'    ")
end

local function vaderkoala(text)
print(" ____")
print("< "..text.." >")
print(" ----")
print("   \\")
print("    \\        .")
print("     .---.  //")
print("    Y|o o|Y// ")
print("   /_(i=i)K/ ")
print("   ~()~*~()~  ")
print("    (_)-(_)   ")
print("")
print("     Darth ")
print("     Vader    ")
print("     koala        ")
end

cow["vader-koala"] = vaderkoala

local function elephantsnake(text)
print(" ____")
print("< "..text.." >")
print(" ----")
print("       \\")
print("        \\  ....")
print("          .    ........")
print("          .            .")
print("          .             .")
print("    .......              .........")
print("    ..............................")
print("Elephant inside ASCII snake")
end

cow["elephant-in-snake"] = elephantsnake

local function threeeyes(text)
print(" ________")
print("< Augen! >")
print(" --------")
print("        \\  ^___^")
print("         \\ (ooo)\\_______")
print("           (___)\\       )\\/\\")
print("                ||----w |")
print("                ||     ||")
end

cow["three-eyes"] = threeeyes

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
