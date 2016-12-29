os.loadAPI("/usr/apis/wilmaapi")

if fs.exists("/etc/crontab") == false then
  local writecron = io.open("/etc/crontab","w")
  writecron:write("#Write here your tasks\n")
  writecron:write("#Lines who are started with # are ignored\n")
  writecron:write("#Example:\n")
  writecron:write("#7 * ls\n")
  writecron:write("#Runs ls every day at 7\n")
  writecron:close()
end

print("Cron is running! Put your tasks in /etc/crontab!")

local cronta = {}
local cronfile = io.open("/etc/crontab","r")
for linecon in cronfile:lines() do
if not(linecon:find("#")==1) then
local tmpta = {}
tmpta["time"],tmpta["day"] = wilmaapi.splitString(linecon," ")
local strlen = tmpta["time"]:len() + tmpta["day"]:len() + 3
tmpta["command"] = linecon:sub(strlen,-1)
table.insert(cronta,tmpta)
end
end

cronfile:close()

local blocktime = math.floor(os.time())
local sleepta = {}
local check = {}

while true do

if not(blocktime==math.floor(os.time())) then
  sleepta = {}
  blocktime = math.floor(os.time())
end

for ind,ta in ipairs(cronta) do
local time = math.floor(os.time())
local day = os.day()
ta["time"] = ta["time"]:gsub("*",time)
ta["day"] = ta["day"]:gsub("*",day)
if time == tonumber(ta["time"]) then
  if day == tonumber(ta["day"]) then
    if not(sleepta[ind]==true) then
      shell.run(ta["command"])
      sleepta[ind] = true
    end
  end
end
end

os.sleep(0.1)
end
