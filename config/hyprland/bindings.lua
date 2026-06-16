local terminal    = "kitty"
local fileManager = "nautilus -w"
local menu        = "rofi -show drun -theme /home/barab/brice/config/rofi/launcher.rasi"
local browser     = "firefox"
local editor      = "zeditor"
local screenshot  = 'grim -g "$(slurp)" - | swappy -f -'

---------------------
---- KEYBINDINGS ----
---------------------



local mainMod = "SUPER" -- Sets "Windows" key as main modifier

hl.bind(mainMod .. " + X", function()
    hl.dispatch(hl.dsp.workspace.toggle_special("minimize"))
    hl.dispatch(hl.dsp.window.move({ workspace = "+0" }))
    hl.dispatch(hl.dsp.workspace.toggle_special("minimize"))
    hl.dispatch(hl.dsp.window.move({ workspace = "special:minimize" }))
    hl.dispatch(hl.dsp.workspace.toggle_special("minimize"))
end)

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd(editor))
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("/home/barab/brice/config/rofi/powermenu.sh"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("zeditor brice"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle", mode = "fullscreen" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pin({ action = "toggle" }))
hl.bind(mainMod .. " + J", hl.dsp.window.resize())
hl.bind("ALT + TAB", hl.dsp.focus({ last = true }))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd(screenshot))
hl.bind(mainMod .. " + V",
    hl.dsp.exec_cmd(
        "cliphist list | rofi -dmenu -theme /home/barab/brice/config/rofi/clipboard.rasi | cliphist decode | wl-copy"))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.exec_cmd("hyprctl kill"))

local closeWindowBind = hl.bind(mainMod .. " + C", hl.dsp.window.close())
-- closeWindowBind:set_enabled(false)
hl.bind(mainMod .. " + T", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
--hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit")) -- dwindle only
--hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + space", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + ALT + space", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Switch between workspaces
hl.bind(mainMod .. " + ampersand", hl.dsp.focus({ workspace = "1" }))
hl.bind(mainMod .. " + SHIFT + ampersand", hl.dsp.window.move({ workspace = "1" }))

hl.bind(mainMod .. " + eacute", hl.dsp.focus({ workspace = "2" }))
hl.bind(mainMod .. " + SHIFT + eacute", hl.dsp.window.move({ workspace = "2" }))

hl.bind(mainMod .. " + quotedbl", hl.dsp.focus({ workspace = "3" }))
hl.bind(mainMod .. " + SHIFT + quotedbl", hl.dsp.window.move({ workspace = "3" }))

hl.bind(mainMod .. " + apostrophe", hl.dsp.focus({ workspace = "4" }))
hl.bind(mainMod .. " + SHIFT + apostrophe", hl.dsp.window.move({ workspace = "4" }))

hl.bind(mainMod .. " + parenleft", hl.dsp.focus({ workspace = "5" }))
hl.bind(mainMod .. " + SHIFT + parenleft", hl.dsp.window.move({ workspace = "5" }))

hl.bind(mainMod .. " + minus", hl.dsp.focus({ workspace = "6" }))
hl.bind(mainMod .. " + SHIFT + minus", hl.dsp.window.move({ workspace = "6" }))

hl.bind(mainMod .. " + egrave", hl.dsp.focus({ workspace = "7" }))
hl.bind(mainMod .. " + SHIFT + egrave", hl.dsp.window.move({ workspace = "7" }))

hl.bind(mainMod .. " + underscore", hl.dsp.focus({ workspace = "8" }))
hl.bind(mainMod .. " + SHIFT + underscore", hl.dsp.window.move({ workspace = "8" }))

hl.bind(mainMod .. " + ccedilla", hl.dsp.focus({ workspace = "9" }))
hl.bind(mainMod .. " + SHIFT + ccedilla", hl.dsp.window.move({ workspace = "9" }))

hl.bind(mainMod .. " + agrave", hl.dsp.focus({ workspace = "10" }))
hl.bind(mainMod .. " + SHIFT + agrave", hl.dsp.window.move({ workspace = "10" }))



-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
    { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
    { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("SHIFT + XF86MonBrightnessUp", hl.dsp.exec_cmd("hyprctl hyprsunset temperature -200"),
    { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })
hl.bind("SHIFT + XF86MonBrightnessDown", hl.dsp.exec_cmd("hyprctl hyprsunset temperature +200"),
    { locked = true, repeating = true }) -- Change temperature using brightness keys
-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
-- hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl position 10+"), { long_press = true, locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
--



hl.bind("XF86AudioMedia", hl.dsp.exec_cmd("zeditor brice"), { locked = true }) -- On my Framework Laptop
hl.bind("Print", hl.dsp.exec_cmd(screenshot))                                  -- On my Framework Laptop
hl.bind("XF86RFKill", function()
        hl.dsp.exec_cmd("rfkill toggle all && hyprctl notify")
        hl.notification.create({ text = "Airplane mode switched", duration = 5000 })
    end,
    { locked = true }) -- Turn on airplane mode


hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace",
})
local screen = function()
    hl.dsp.window.fullscreen({ action = "toggle", mode = "fullscreen" })
end
hl.gesture({
    fingers = 3,
    direction = "up",
    action = screen
})


local swipe = function()
    hl.notification.create({ text = "I just swiped on my trackpad!", duration = 5000, icon = "ok" })
end

hl.gesture({
    fingers = 3,
    direction = "down",
    action = swipe
})
