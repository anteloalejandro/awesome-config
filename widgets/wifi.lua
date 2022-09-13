local awful = require("awful")
local wibox = require("wibox")
local vicious = require("vicious")

local wifi = wibox.widget.textbox()
vicious.register(wifi, vicious.widgets.wifiiw, function (widget, args)
  local quality = ""
  if args["{txpw}"] == 0 then
    return "⚠️ Device not found "
  end
  local linp = args["{linp}"]
  if linp > 90 then
    quality = "===="
  elseif linp > 75 then
    quality = "===-"
  elseif linp > 50 then
    quality = "==--"
  elseif linp > 25 then
    quality = "=---"
  else
    quality = "----"
  end
  return " 📶 " .. args["{ssid}"] .. " " .. quality
end, 5, "wlan0")

return wifi
