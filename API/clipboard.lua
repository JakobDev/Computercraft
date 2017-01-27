--Made by Wilma456

function set(con)
os.clipcon = con
end

function get()
return os.clipcon
end

function getType()
if os.clipcon then
  return clipcon.type
else
  return "none"
end
end

function setText(text)
os.clipcon = {}
os.clipcon.type = "text"
os.clipcon.con = text
end

function getText()
if os.clipcon then
  if os.clipcon.type == "text" then
    return os.clipcon.con
  else
    return ""
  end
else
  return ""
end
end

function getTextLine()
if os.clipcon then
  if os.clipcon.type == "text" then
    local linecon = os.clipcon.con:match("([^\n]+)\n([^\n]+)")
    if linecon == nil then
      return os.clipcon.con:gsub("\n","")
    else
      return linecon
    end
  else
    return ""
  end
else
  return ""
end
end
