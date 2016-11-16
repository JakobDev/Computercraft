local monitor = peripheral.find("monitor")

if monitor == nil then
  print("No monitor found")
  return 1
end

monitor.setBackgroundColour(colors.black)
monitor.clear()

return 0
