local awful = require("awful")
local gears = require("gears")
local menu = require("main.menu")

local globalbuttons = {}
globalbuttons = gears.table.join(
awful.button({ }, 3, function () menu.mymainmenu:toggle() end),
awful.button({ }, 1, function () menu.mymainmenu:hide() end)
)

return globalbuttons
