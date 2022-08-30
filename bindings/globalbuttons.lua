local awful = require("awful")
local gears = require("gears")
local menu = require("main.menu")

local globalbuttons = {}
globalbuttons = gears.table.join(
awful.button({ }, 3, function () menu.mymainmenu:show() end),
awful.button({ }, 1, function () menu.mymainmenu:hide() end)
-- awful.button({ }, 5, awful.tag.viewnext),
-- awful.button({ }, 4, awful.tag.viewprev)
)

return globalbuttons
