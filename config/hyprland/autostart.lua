-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
hl.on("hyprland.start", function()
    -- Apps
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")       -- Required for GUI applications to be able to request elevated privileges.
    hl.exec_cmd("hypridle")
    hl.exec_cmd("hyprsunset")                                   -- Blue light filter
    hl.exec_cmd("wl-paste --type text --watch cliphist store")  -- Stores only text data
    hl.exec_cmd("wl-paste --type image --watch cliphist store") -- Stores only image data
    hl.exec_cmd("mpris-proxy")                                  -- For bluetooth devices to control media                                        --  For bluetooth devices to control media
    hl.exec_cmd("cliphist wipe")
    hl.exec_cmd("nm-applet")
    -- hyperhdr

    -- Rice
    hl.exec_cmd("qs -p /home/barab/brice/bell")
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd(
        "awww img /home/barab/.config/brice/unsplash.jpg && wallust run /home/barab/.config/brice/unsplash.jpg -C /home/barab/brice/config/wallust/wallust.toml && /home/barab/brice/scripts/unsplash.sh")

    -- Rclone
    hl.exec_cmd('rclone mount r2:public ~/rclone/Cloudflare')
    hl.exec_cmd('rclone mount onedrive: ~/rclone/Onedrive/ --vfs-cache-mode writes')
    hl.exec_cmd('rclone mount freebox:"Freebox" ~/rclone/Freebox')
end
)
hl.on("hyprland.shutdown", function()
    hl.exec_cmd("cliphist wipe")
end
)
