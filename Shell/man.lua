local arg = {...}
if fs.exists("/usr/man/"..arg[1]) == true then
  shell.run("edit /usr/man/"..arg[1])
else
  print('No Manpage found for "'..arg[1]..'"')
end
