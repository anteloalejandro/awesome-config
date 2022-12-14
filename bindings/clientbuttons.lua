local gears = require("gears")
local awful = require("awful")
local menu = require("main.menu")
local modkey = require("settings").modkey

local clientbuttons = {}
clientbuttons = gears.table.join(
  awful.button({ }, 1, function (c)
    menu.mymainmenu:hide()
    c:emit_signal("request::activate", "mouse_click", {raise = true})
  end),
  awful.button({ modkey }, 1, function (c)
    c:emit_signal("request::activate", "mouse_click", {raise = true})
    awful.mouse.client.move(c)
  end),
  awful.button({ modkey }, 3, function (c)
    c:emit_signal("request::activate", "mouse_click", {raise = true})
    awful.mouse.client.resize(c)
  end)
  )

return clientbuttons
