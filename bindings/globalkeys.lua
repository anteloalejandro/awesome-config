local vars = require("main.user-variables")
local modkey = "Mod4"
local gears = require("gears")
local awful = require("awful")
local client = awful.client
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
local menu = require("main.menu")

local floaty = true
local terminal = vars.apps.terminal
local editor = vars.apps.editor
local editor_cmd = terminal .. " -e " .. editor
local browser = vars.apps.browser
local file_manager = vars.apps.file_manager

local globalkeys = {}
globalkeys = gears.table.join(

awful.key({ modkey, }, "Left", awful.tag.viewprev,
{description = "view previous", group = "tag"}),

awful.key({ modkey, }, "Right", awful.tag.viewnext,
{description = "view next", group = "tag"}),

awful.key({ modkey, }, "Escape", awful.tag.history.restore,
{description = "go back", group = "tag"}),

awful.key({ modkey, }, "j",
function ()
  awful.client.focus.byidx( 1)
end,
{description = "focus next by index", group = "client"}
),

awful.key({ modkey, }, "k",
function ()
  awful.client.focus.byidx(-1)
end,
{description = "focus previous by index", group = "client"}
),

awful.key({ modkey, }, "w", function () menu.mymainmenu:show() end,
{description = "show main menu", group = "awesome"}),

-- Layout manipulation
awful.key({ modkey, "Shift" }, "j", function () awful.client.swap.byidx( 1) end,
{description = "swap with next client by index", group = "client"}),

awful.key({ modkey, "Shift" }, "k", function () awful.client.swap.byidx( -1) end,
{description = "swap with previous client by index", group = "client"}),

awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
{description = "focus the next screen", group = "screen"}),

awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
{description = "focus the previous screen", group = "screen"}),

awful.key({ modkey, }, "u", awful.client.urgent.jumpto,
{description = "jump to urgent client", group = "client"}),

awful.key({ modkey, }, "Tab",
function ()
  awful.client.focus.history.previous()
  if client.focus then
    client.focus:raise()
  end
end,
{description = "go back", group = "client"}),

-- Basic awesome commands
awful.key({ modkey, }, "s", hotkeys_popup.show_help,
{description="show help", group="awesome"}),

awful.key({ modkey, "Control" }, "r", awesome.restart,
{description = "reload awesome", group = "awesome"}),

awful.key({modkey, "Shift"}, "r", function ()
  awful.spawn.with_shell("Xephyr :5 & sleep 1; DISPLAY=:5 awesome" )
end,
{description = "Test awesome configuration on Xephyr", group = "awesome"}),

awful.key({ modkey, "Shift" }, "q", awesome.quit,
{description = "quit awesome", group = "awesome"}),

-- Spawn default applications
awful.key({ modkey, }, "t", function () awful.spawn(terminal) end,
{description = "open a terminal", group = "launcher"}),

awful.key({ modkey }, "f", function () awful.spawn(file_manager) end,
{description = "launch file manager", group = "launcher"}),

awful.key({ modkey }, "b", function() awful.util.spawn(browser) end,
{description = "launch browser", group = "launcher"}),

awful.key({ modkey }, "e", function() awful.util.spawn(editor_cmd) end,
{description = "launch neovim", group = "launcher"}),

-- Layout manipulation and navegation
awful.key({ modkey, }, "l", function () awful.tag.incmwfact( 0.05) end,
{description = "increase master width factor", group = "layout"}),

awful.key({ modkey, }, "+", function () awful.client.incwfact( 0.1) end,
{description = "increase client width factor", group = "layout"}),

awful.key({ modkey, }, "h", function () awful.tag.incmwfact(-0.05) end,
{description = "decrease master width factor", group = "layout"}),

awful.key({ modkey, }, "-", function () awful.client.incwfact(-0.05) end,
{description = "decrease client width factor", group = "layout"}),

awful.key({ modkey, "Shift" }, "h", function () awful.tag.incnmaster( 1, nil, true) end,
{description = "increase the number of master clients", group = "layout"}),

awful.key({ modkey, "Shift" }, "l", function () awful.tag.incnmaster(-1, nil, true) end,
{description = "decrease the number of master clients", group = "layout"}),

awful.key({ modkey, "Control" }, "h", function () awful.tag.incncol( 1, nil, true) end,
{description = "increase the number of columns", group = "layout"}),

awful.key({ modkey, "Control" }, "l", function () awful.tag.incncol(-1, nil, true) end,
{description = "decrease the number of columns", group = "layout"}),

awful.key({ modkey, }, "u", function () awful.layout.inc( 1) end,
{description = "select next", group = "layout"}),

awful.key({ modkey, "Control" }, "n",
function ()
  local c = awful.client.restore()
  -- Focus restored client
  if c then
    c:emit_signal(
    "request::activate", "key.unminimize", {raise = true}
    )
  end
end,
{description = "restore minimized", group = "client"}),

-- Prompt
awful.key({ modkey }, "x",
function ()
  awful.prompt.run {
    prompt = "Run Lua code: ",
    textbox = awful.screen.focused().mypromptbox.widget,
    exe_callback = awful.util.eval,
    history_path = awful.util.get_cache_dir() .. "/history_eval"
  }
end,
{description = "lua execute prompt", group = "awesome"}),

-- Menubar
awful.key({ modkey }, "p", function() menubar.show() end,
{description = "show the menubar", group = "launcher"}),

-- Custom
---[[
awful.key({ modkey }, "space", function() awful.util.spawn("rofi -show drun -sidebar-mode") end,
{description = "run prompt", group = "launcher"}),

awful.key({ "Mod1" }, "Tab", function() awful.util.spawn("rofi -show window -sidebar-mode") end,
{description = "run prompt", group = "launcher"}),

-- Not working properly
awful.key({ modkey }, "y", function ()
  if floaty then
    awful.layout.layouts = {awful.layout.suit.floating}
    awful.layout.set(awful.layout.suit.floating)
  else
    awful.layout.layouts = {awful.layout.suit.tile, awful.layout.suit.tile.bottom}
    awful.layout.set(awful.layout.suit.tile)
  end
  floaty = not floaty
end,
{description = "(WIP) toggle floating layout", group="layout" })
--]]
)

-- Bind to tags
for i = 1, 9 do
  globalkeys = gears.table.join(globalkeys,
  -- View tag only.
  awful.key({ modkey }, "#" .. i + 9,
  function ()
    local screen = awful.screen.focused()
    local tag = screen.tags[i]
    if tag then
      tag:view_only()
    end
  end,
  {description = "view tag #"..i, group = "tag"}),
  -- Toggle tag display.
  awful.key({ modkey, "Control" }, "#" .. i + 9,
  function ()
    local screen = awful.screen.focused()
    local tag = screen.tags[i]
    if tag then
      awful.tag.viewtoggle(tag)
    end
  end,
  {description = "toggle tag #" .. i, group = "tag"}),
  -- Move client to tag.
  awful.key({ modkey, "Shift" }, "#" .. i + 9,
  function ()
    if client.focus then
      local tag = client.focus.screen.tags[i]
      if tag then
        client.focus:move_to_tag(tag)
      end
    end
  end,
  {description = "move focused client to tag #"..i, group = "tag"}),
  -- Toggle tag on focused client.
  awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
  function ()
    if client.focus then
      local tag = client.focus.screen.tags[i]
      if tag then
        client.focus:toggle_tag(tag)
      end
    end
  end,
  {description = "toggle focused client on tag #" .. i, group = "tag"})
  )
end

return globalkeys
