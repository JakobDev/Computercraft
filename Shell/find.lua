local Args = ...

os.loadAPI("/usr/apis/wilmaapi")

local fileta
if Args == nil then
  fileta = wilmaapi.listAllFiles()
else
  fileta = wilmaapi.listAllFiles(Args)
end

for _,filename in ipairs(fileta) do
print(filename)
end
