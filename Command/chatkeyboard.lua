local keynormal = {}
keynormal[1] = {"1","2","3","4","5","6","7","8","9","0","backspace"}
keynormal[2] = {"q","w","e","r","t","z","u","i","o","p","enter","capsLock"}
keynormal[3] = {"a","s","d","f","g","h","j","k","l","up","down","space"}
keynormal[4] = {"y","x","c","v","b","n","m","left","right","tab"}

local capskey = {}
capskey[1] = {"!",'\\"',"?","$","%","&","/","(",")","=","backspace"}
capskey[2] = {"Q","W","E","R","T","Z","U","I","O","P","enter","capsLock"}
capskey[3] = {"A","S","D","F","G","H","J","K","L","up","down","space"}
capskey[4] = {"Y","X","C","V","B","N","M","left","right","tab"}

local blocks = {}
blocks[1] = {"dirt","stone","grass","planks","glass","log","iron_ore","pumpkin","sponge","coal_ore","redstone_block"}
blocks[2] = {"diamond_ore","wool","sandstone","stone_slab","bedrock","stone_stairs","quartz_ore","lapis_ore","red_sandstone","nether_brick","stained_glass","beacon"}
blocks[3] = {"jungle_stairs","quartz_stairs","soul_sand","birch_stairs","wooden_slab","brick_stairs","sea_lantern","coal_block","melon_block","dropper","piston","redstone_lamp"}
blocks[4] = {"hay_block","emerald_ore","emerald_block","prismarine","spruce_stairs","quartz_block","cobblestone","tnt","noteblock","dispenser"}

local keylist = {}

local testcaps = false

local posx,posy,posz = commands.getBlockPosition()
--local posy = "6"
--local posz = "-132"
posy = 255


local function clearChat()
commands.exec('tellraw @a ["\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"]')
end

local function copyTable(a,b)
for k,v in pairs(a) do
  b[k] = v
end
end

local function createKeyboard()
local text = '/tellraw @p [""'
for i,c in ipairs(keylist) do
for k,v in ipairs(c) do
  text = text..',{"text":"'
  text = text..v
  text = text..'","color":"blue"'
  text = text..',"clickEvent":{"action":"run_command","value":"'
  text = text..'/setblock '..posx..' '..posy..' '..posz..' minecraft:'..blocks[i][k]..' 1 replace'
  text = text..'"}}'
  text = text..',{"text":" "}'  
end
text = text..',{"text":"\\n"}'
end
text = text.."]"
commands.exec(text)
--print(text)
end

copyTable(keynormal,keylist)
commands.exec("gamerule sendCommandFeedback false")
clearChat()
createKeyboard()

while true do
local block = commands.getBlockInfo(tonumber(posx),tonumber(posy),tonumber(posz))
for i,c in ipairs(blocks) do
  for k,v in ipairs(c) do
    if "minecraft:"..v == block.name then
      --print(keylist[i][k])
      os.queueEvent("key",keys[string.lower(keylist[i][k])])
      --if blockkeys[keylist[i][k]] ~= true then
      if #keylist[i][k] == 1 then
        os.queueEvent("char",keylist[i][k])
      elseif keylist[i][k] == '\\"' then
        os.queueEvent("char",'"')
      elseif keylist[i][k] == 'space' then
        os.queueEvent("char",' ')
      end
      if keylist[i][k] == "capsLock" then
        if testcaps == false then
          copyTable(capskey,keylist)
          testcaps = true
        else
          copyTable(keynormal,keylist)
          testcaps = false
        end
        clearChat()
        createKeyboard()
      end
      commands.exec("/setblock "..posx.." "..posy.." "..posz.." minecraft:air")
    end
  end
end
end
