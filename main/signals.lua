local awful = require("awful")
local beautiful = require("beautiful")

client.connect_signal("manage", function (c)
  -- Set the windows at the slave,
  -- i.e. put it at the end of others instead of setting it master.
  if not awesome.startup then awful.client.setslave(c) end
  if awesome.startup
    and not c.size_hints.user_position
    and not c.size_hints.program_position then
    -- Prevent clients from being unreachable after screen count changes.
    awful.placement.no_offscreen(c)
  end
end)

  -- Add titlebar if client if client is floating and restore geometry
  local function save_geometry(c)
    c.last_geometry = c:geometry()
  end

  local function restore_geometry(c)
    c:geometry(c.last_geometry)
  end

  client.connect_signal("property::floating", function(c)
    if c.floating then
      restore_geometry(c)
      save_geometry(c)
      awful.titlebar.show(c)
    else
      save_geometry(c)
      awful.titlebar.hide(c)
    end
  end)

  client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
  client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
