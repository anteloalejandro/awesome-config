local awful = require("awful")
local wibox = require("wibox")
local vicious = require("vicious")

local volume = wibox.widget.textbox()
vicious.register(volume, vicious.widgets.volume, function (widget, args)
  local current_volume = ""
  if args[1] == nil then
    return " 🔈 N/A "
  end
  if args[1] >= 50 then
    current_volume = "🔊"
  else 
    current_volume = "🔈"
  end
  return " " .. current_volume .. " " .. args[1] .. "% "
end, 5, "Master")

volume:connect_signal("button::press",
function (_, _, _, button)
  if button == 4 then
    awful.spawn.with_shell("amixer -D pipewire sset Master 10%+")
  elseif button == 5 then
    awful.spawn.with_shell("amixer -D pipewire sset Master 10%-")
  end
  vicious.force({volume})
end
)
return volume
