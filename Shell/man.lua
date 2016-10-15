local Args = {...}

if Args[1] == nil then
  print("Usage: "..shell.getRunningProgram().." <helpfile>")
  return
end

if help.lookup(Args[1]) == nil then
  print('Can\'t find helpfile "'..Args[1]..'"')
else
  shell.run("edit "..help.lookup(Args[1]))
end
