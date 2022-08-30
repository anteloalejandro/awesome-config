pcall(require, "luarocks.loader")

local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
require("awful.autofocus")
require("awful.hotkeys_popup.keys")

local vars = require("main.user-variables")

-- Error handling
require("main.error-handling")

--  Variable definitions
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme.lua")
beautiful.wallpaper = vars.wallpaper

local main = {
  layouts = require("main.layouts"),
  tags = require("main.tags"),
  menu = require("main.menu"),
  rules = require("main.rules")
}

local bindings = {
  globalbuttons = require("bindings.globalbuttons"),
  clientbuttons = require("bindings.clientbuttons"),
  globalkeys = require("bindings.globalkeys"),
  clientkeys = require("bindings.clientkeys"),
}

-- Layouts
awful.layout.layouts = require("main.layouts")

-- Wibar and wallpaper
require("decos.statusbar")

-- Titlebar
require("decos.titlebar")

-- Mouse bindings
root.buttons(require("bindings.globalbuttons"))

-- Key bindings
root.keys(require("bindings.globalkeys"))

-- Rules
awful.rules.rules = require("main.rules")

-- Signals
require("main.signals")

-- Start compositor
awful.spawn.with_shell(vars.compositor)
