local awful = require("awful")
local menubar = require("menubar")
local beautiful = require("beautiful")
local apps = require("main.user-variables").apps

local terminal = apps.terminal
local editor = apps.editor
local editor_cmd = terminal .. " -e " .. editor

local m = {}

m.myawesomemenu = {

  { "hotkeys", function() awful.hotkeys_popup.show_help(nil, awful.screen.focused()) end },
  { "manual", terminal .. " -e man awesome" },
  { "edit config", editor_cmd .. " " .. awesome.conffile },
  { "restart", awesome.restart },
  { "quit", function() awesome.quit() end },
}

m.mymainmenu = awful.menu({ items = { { "awesome", m.myawesomemenu, beautiful.awesome_icon }, { "open terminal", terminal } } })

m.mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
menu = m.mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
return m
