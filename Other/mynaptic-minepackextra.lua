function mynaptic.configMinepack()
  if not fs.isDir("/etc/minepack") then
    mynaptic.showTextWindow("This Function need Minepack to Work")
    mynaptic.drawMenu()
    return
  end
  local tMinepackConf = {}
  local tMinepackFile = {}
  local confile = io.open("/etc/minepack/config.conf","r")
  for sLinecon in confile:lines() do
    if sLinecon:find("#") ~= 1 then
      local head,cont = wilmaapi.splitString(sLinecon,"=")
      table.insert(tMinepackConf,{name=head,con=cont})
      table.insert(tMinepackFile,#tMinepackConf)
    else
      table.insert(tMinepackFile,sLinecon)
    end
  end
  confile:close()
  while true do
    local w,h = term.getSize()
    term.setBackgroundColor(colors[config.menuBackgroundColour])
    term.setTextColor(colors[config.menuTextColour])
    term.clear()
    term.setCursorPos(1,1)
    for k,v in ipairs(tMinepackConf) do
      print(v.name)
    end
    term.setCursorPos(1,h)
    term.setBackgroundColor(colors[config.bottomBarColour])
    term.clearLine()
    term.write(lang.ok)
    local ev,me,x,y = os.pullEvent()
    if ev == "mouse_click" then
      if tMinepackConf[y] ~= nil then
        config[tMinepackConf[y]["name"]] = tMinepackConf[y]["con"]
        if tMinepackConf[y]["con"] == "true" or tMinepackConf[y]["con"] == "false" then
          mynaptic.configBool(tMinepackConf[y]["name"],false,"Unknown")
        else
          mynaptic.configNormal(tMinepackConf[y]["name"],false,"Unknown")
        end
        tMinepackConf[y]["con"] = config[tMinepackConf[y]["name"]]
        config[tMinepackConf[y]["name"]] = nil
      elseif y == h then
        local writefi = fs.open("/etc/minepack/config.conf","w")
        for k,v in ipairs(tMinepackFile) do
          if type(v) == "number" then
            writefi.writeLine(tMinepackConf[v]["name"].."="..tMinepackConf[v]["con"])
          else
            writefi.writeLine(v)
          end
        end
        writefi.close()
        return
      end
    end
  end
end

function mynaptic.getRepoName()
  term.setBackgroundColor(colors[config.menuBackgroundColour])
  term.setTextColor(colors[config.menuTextColour])
  term.setCursorPos(1,1)
  term.clear()
  print("Please Enter a Name for the Repo:")
  term.write(">")
  return read()
end

function mynaptic.getRepoURL()
  term.setBackgroundColor(colors[config.menuBackgroundColour])
  term.setTextColor(colors[config.menuTextColour])
  term.setCursorPos(1,1)
  term.clear()
  print("Please Enter a URL for the Repo:")
  term.write(">")
  return read()
end

function mynaptic.addRepo(tRepo)
  while true do
    term.setBackgroundColor(colors[config.menuBackgroundColour])
    term.setTextColor(colors[config.menuTextColour])
    term.setCursorPos(1,1)
    term.clear()
    print("Please choose a Type:")
    print("list")
    print("repo")
    local ev,me,x,y = os.pullEvent("mouse_click")
    if y == 2 then
      table.insert(tRepo,{"list",mynaptic.getRepoURL()})
      return
    elseif y == 3 then
      table.insert(tRepo,{"repo",mynaptic.getRepoName(),mynaptic.getRepoURL()})
      return
    end
  end
end

function mynaptic.configRepo()
  if not fs.isDir("/etc/minepack") then
    mynaptic.showTextWindow("This Function need Minepack to Work")
    mynaptic.drawMenu()
    return
  end
  local tMinepackRepo = {}
  local tMinepackFile = {}
  local confile = io.open("/etc/minepack/sources.list","r")
  for sLinecon in confile:lines() do
    if sLinecon:find("#") ~= 1 then
      local head,cont = wilmaapi.splitString(sLinecon," ")
      local name,url = wilmaapi.splitString(cont,";")
      if name == nil then
        table.insert(tMinepackRepo,{head,cont})
      else
        table.insert(tMinepackRepo,{head,name,url})
      end
      table.insert(tMinepackFile,#tMinepackRepo)
    else
      table.insert(tMinepackFile,sLinecon)
    end
  end
  confile:close()
  while true do
    local w,h = term.getSize()
    term.setBackgroundColor(colors[config.menuBackgroundColour])
    term.setTextColor(colors[config.menuTextColour])
    term.clear()
    for k,v in ipairs(tMinepackRepo) do
      term.setCursorPos(1,k)
      if #v == 2 then
        term.write(v[1].." "..v[2])
      else
        term.write(v[1].." "..v[2].." "..v[3])
      end
    end
    term.setCursorPos(1,h)
    term.setBackgroundColor(colors[config.bottomBarColour])
    term.clearLine()
    term.write(lang.ok)
    term.setCursorPos(w-#lang.add+1,h)
    term.write(lang.add)
    local ev,me,x,y = os.pullEvent()
    if ev == "mouse_click" then
      if y == h then
        if x < #lang.ok+1 then
          local writefi = fs.open("/etc/minepack/sources.list","w")
          for k,v in ipairs(tMinepackFile) do
            if type(v) == "number" then
              if #tMinepackRepo[v] == 2 then
                writefi.writeLine(tMinepackRepo[v][1].." "..tMinepackRepo[v][2])
              else
                writefi.writeLine(tMinepackRepo[v][1].." "..tMinepackRepo[v][2]..";"..tMinepackRepo[v][3])
              end
            else
              writefi.writeLine(v)
            end
          end
          writefi.close()
          return
        elseif x > w-#lang.add then
          mynaptic.addRepo(tMinepackRepo)
          table.insert(tMinepackFile,#tMinepackRepo)
        end
      end
    end
  end
end

function mynaptic.toolsMenu()
  if not fs.isDir("/etc/minepack") then
    mynaptic.showTextWindow("This Function need Minepack to Work")
    mynaptic.drawMenu()
    return
  end
  while true do
    local w,h = term.getSize()
    term.setBackgroundColor(colors[config.menuBackgroundColour])
    term.setTextColor(colors[config.menuTextColour])
    term.clear()
    term.setCursorPos(1,1)
    print("Config Minepack")
    print("Config Repositories")
    term.setCursorPos(1,h)
    term.setBackgroundColor(colors[config.bottomBarColour])
    term.clearLine()
    term.write(lang.back)
    local ev,me,x,y = os.pullEvent()
    if ev == "mouse_click" then
      if y == 1 then
        mynaptic.configMinepack()
      elseif y == 2 then
        mynaptic.configRepo()
      elseif y == h then
        break
      end
    end
  end
  mynaptic.drawMenu()
end

lang.add = "Add"

if not(pocket or config.forcePocketMode == "true") then
  table.insert(mynaptic.menubar,{text = "Tools",func = function() mynaptic.toolsMenu() end})
end
table.insert(mynaptic.menulist,{text = "Config Minepack",func = function() mynaptic.configMinepack() mynaptic.drawMenu() end})
table.insert(mynaptic.menulist,{text = "Config Repositories",func = function() mynaptic.configMinepack() mynaptic.drawMenu() end})

function shellcom.tools() mynaptic.toolsMenu() end
function shellcom.minepack() mynaptic.configMinepack() mynaptic.drawMenu() end
function shellcom.repositories() mynaptic.configRepo() mynaptic.drawMenu() end

tmpta = {}
tmpta["titel"] = "About Minepackextra"
tmpta["con"] = "Minepackextra Version 1.0 made by Wilma456. \n\nMinepackextra is a Plugin for Mynaptic, which offers some Functions for Minepack."
table.insert(helpta,tmpta)
