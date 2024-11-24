-- keybinds module
-- simirian's awesome

local awful = require("awful")
local kbd = require("awful.keyboard")
local gkeys = kbd.append_global_keybindings
local ckeys = kbd.append_client_keybindings

-- default things
local menubar = require("menubar")
menubar.utils.terminal = "kitty"
local help = require("awful.hotkeys_popup")

local H = {}

--- Cretaes a keybind with the modifier string.
--- @param mods string The modifier keys, should only contain MCAS.
--- @param key string The key to specify the target.
--- @param cb fun(client: table?) The callback function.
--- @param desc table
function H.key(mods, key, cb, desc)
  local mk = {}
  if mods:match("M") then table.insert(mk, "Mod4") end
  if mods:match("C") then table.insert(mk, "Control") end
  if mods:match("A") then table.insert(mk, "Mod1") end
  if mods:match("S") then table.insert(mk, "Shift") end
  return awful.key {
    key = key,
    modifiers = mk,
    on_press = cb,
    description = desc[1],
    group = desc[2],
  }
end

-- tak focus keybinds
gkeys {
  H.key("M", "h", awful.tag.viewprev, { "view previous tag", "tags" }),
  H.key("M", "l", awful.tag.viewnext, { "view next tag", "tags" }),
  -- TODO: Mj and Mk once tag groups works
  H.key("M", "u", function()
    awful.client.focus.bydirection("left")
  end, { "focus client to the left", "client" }),
  H.key("M", "i", function()
    awful.client.focus.bydirection("down")
  end, { "focus client below", "client" }),
  H.key("M", "o", function()
    awful.client.focus.bydirection("up")
  end, { "focus client above", "client" }),
  H.key("M", "p", function()
    awful.client.focus.bydirection("right")
  end, { "focus client to the right", "client" }),
  H.key("M", "[", function()
    awful.screen.focus_relative(-1)
  end, { "focus previous screen", "screen" }),
  H.key("M", "]", function()
    awful.screen.focus_relative(1)
  end, { "focus next screen", "screen" }),
}

-- tak movement keybinds
gkeys {
  H.key("MS", "h", function()
    -- TODO
  end, { "(WIP) move client to previous tag", "tags" }),
  H.key("MS", "l", function()
    -- TODO
  end, { "(WIP) move client to next tag", "tags" }),
  -- TODO: MSj and MSk once tag groups works
  H.key("MS", "u", function()
    awful.client.swap.bydirection("left")
  end, { "swap client to the left", "client" }),
  H.key("MS", "i", function()
    awful.client.swap.bydirection("down")
  end, { "swap client below", "client" }),
  H.key("MS", "o", function()
    awful.client.swap.bydirection("up")
  end, { "swap client above", "client" }),
  H.key("MS", "p", function()
    awful.client.swap.bydirection("right")
  end, { "swap client to the right", "client" }),
}

-- general keybinds
gkeys {
  H.key("M", "s", help.show_help, { "show help", "general" }),
  H.key("M", "Return", function() awful.spawn("kitty") end, { "spawn a terminal", "general" }),
  H.key("MC", "r", awesome.restart, { "reload awesome", "session" }),
  H.key("MS", "q", awesome.quit, { "quit awesome", "session" }),
  H.key("M", "space", function() awful.layout.inc(1) end, { "select next", "layout" }),
  H.key("MS", "space", function() awful.layout.inc(-1) end, { "select previous", "layout" }),
  H.key("M", "r", function()
    awful.screen.focused().mypromptbox:run()
  end, { "run prompt", "runner" }),
  H.key("M", "x", function()
    awful.prompt.run {
      prompt       = "Run Lua code: ",
      textbox      = awful.screen.focused().mypromptbox.widget,
      exe_callback = awful.util.eval,
      history_path = awful.util.get_cache_dir() .. "/history_eval"
    }
  end, { "lua execute prompt", "runner" }),
  H.key("M", ";", function() menubar.show() end, { "show the menubar", "runner" }),
}

gkeys {
  awful.key {
    modifiers = { "Mod4" },
    keygroup = "numrow",
    description = "focus tag",
    group = "tags",
    on_press = function(i)
      local tag = awful.screen.focused().tags[i]
      if not tag then return end
      tag:view_only()
    end,
  },
  awful.key {
    modifiers = { "Mod4", "Shift" },
    keygroup = "numrow",
    description = "move client to tag",
    group = "client",
    on_press = function(i)
      if not client.focus then return end
      local tag = client.focus.screen.tags[i]
      client.focus:move_to_tag(tag)
    end,
  }
}

client.connect_signal("request::default_keybindings", function()
  ckeys{
    H.key("M", "f", function(c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end, { "toggle fullscreen", "client" }),
    H.key("MS", "c", function(c) c:kill() end, { "close", "client" }),
    H.key("MC", "space", awful.client.floating.toggle, { "toggle floating", "client" }),
    H.key("MC", "Return", function(c) c:swap(awful.client.getmaster()) end, { "move to master", "client" }),
    H.key("M", "o", function(c) c:move_to_screen() end, { "move to screen", "client" }),
    H.key("M", "t", function(c) c.ontop = not c.ontop end, { "toggle keep on top", "client" }),
    H.key("M", "n", function(c)
      c.minimized = true
    end, { "minimize", "client" }),
    H.key("M", "m", function(c)
      c.maximized = not c.maximized
      c:raise()
    end, { "(un)maximize", "client" }),
    H.key("MC", "m", function(c)
      c.maximized_vertical = not c.maximized_vertical
      c:raise()
    end, { "(un)maximize vertically", "client" }),
    H.key("MS", "m", function(c)
      c.maximized_horizontal = not c.maximized_horizontal
      c:raise()
    end, { "(un)maximize horizontally", "client" }),
  }
end)
