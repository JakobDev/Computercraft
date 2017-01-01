os.loadAPI("/usr/apis/wilmaapi")

if fs.exists("/etc/crontab") == false then
  local writecron = io.open("/etc/crontab","w")
  writecron:write("#Write here your tasks\n")
  writecron:write("#Lines who are started with # are ignored\n")
  writecron:write("#Example:\n")
  writecron:write("#7 * ls\n")
  writecron:write("#Runs ls every day at 7\n")
  writecron:write("#If the command a Folder, cron will run all files insid\n")
  writecron:write("* * /etc/cron.hourly\n")
  writecron:write("7 * /etc/cron.daily\n")
  writecron:close()
end

if fs.exists("/etc/cron.daily") == false then
  fs.makeDir("/etc/cron.daily")
end

if fs.exists("/etc/cron.hourly") == false then
  fs.makeDir("/etc/cron.hourly")
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

local function runAll(folder)
local filelist = fs.list(folder)
for ind,file in ipairs(filelist) do
  shell.run(folder.."/"..file)
end
end

local blocktime = math.floor(os.time())
local sleepta = {}
local check = {}

local function loop()
for ind,ta in ipairs(cronta) do
local time = math.floor(os.time())
local day = os.day()
local crontime = ta["time"]:gsub("*",time)
local cronday = ta["day"]:gsub("*",day)
if time == tonumber(crontime) then
  if day == tonumber(cronday) then
    --if not(sleepta[ind]==true) then
      if fs.isDir(ta["command"]) == true then
        runAll(ta["command"])
      else
        shell.run(ta["command"])
      end
      sleepta[ind] = true
    end
  --end
end
end
end

loop()
while true do

if not(blocktime==math.floor(os.time())) then
  sleepta = {}
  blocktime = math.floor(os.time())
  --if fs.isDir("/etc/cron.hourly") == true then
  --  runAll("/etc/cron.hourly")
  --ssend
  loop()
end

os.sleep(0.1)
end
