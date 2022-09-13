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
  if awful.layout.getname() == "floating" then
    awful.titlebar.show(c)
  end
end)

client.connect_signal("property::floating_geometry", function (c)
  if not c.maximized then
    c.last_geometry = c:geometry()
  end
end)
-- Add titlebar if client is floating and restore geometry
client.connect_signal("property::floating", function(c)
  if c.floating then
    c:geometry(c.last_geometry)
    awful.titlebar.show(c)
  else
    if awful.layout.getname() == "floating" then
      awful.titlebar.show(c)
    else
      awful.titlebar.hide(c)
    end
  end
end)

  client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
  client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

  -- Toggle titlebars in floating layout
  tag.connect_signal("property::layout", function (t)
    if t.layout == awful.layout.suit.floating then
      for _, c in ipairs(client.get()) do
        c:geometry(c.last_geometry)
        awful.titlebar.show(c)
      end
    else
      for _, c in ipairs(client.get()) do
        if not c.floating then
          awful.titlebar.hide(c)
        end
      end
    end
  end)
