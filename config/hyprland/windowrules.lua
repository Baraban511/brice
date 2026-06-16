--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

-- local suppressMaximizeRule = hl.window_rule({
--     -- Ignore maximize requests from all apps. You'll probably like this.
--     name           = "suppress-maximize-events",
--     match          = { class = ".*" },

--     suppress_event = "maximize",
-- })
-- suppressMaximizeRule:set_enabled(false)



hl.window_rule({
    -- Fix some dragging issues with XWayland
    name     = "fix-xwayland-drags",
    match    = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})
hl.window_rule({ match = { class = "com.moonlight_stream.Moonlight" }, fullscreen = true })
hl.window_rule({ match = { class = "com.obsproject.Studio" }, no_screen_share = true })
hl.window_rule({ match = { class = "Bitwarden" }, no_screen_share = true })
hl.window_rule({ match = { class = "org.gnome.NautilusPreviewer" }, float = true, size = { "(monitor_w*0.7)", "(monitor_h*0.7)" } })

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
-- hl.window_rule({
--     name  = "move-hyprland-run",
--     match = { class = "hyprland-run" },

--     move  = "20 monitor_h-120",
--     float = true,
-- })
