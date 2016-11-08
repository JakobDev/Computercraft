local Arg = {...}
if Arg[1] == nil then
print("Usage: whois <command>")
return
end
local path = shell.resolveProgram(Arg[1])
if path == nil then
print("Can't find command "..Arg[1])
return
end
print(Arg[1].." is /"..path)
