hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 10,
        border_size = 2,
        col = {
            active_border   = { colors = {"rgba(33ccffee)", "rgba(00ff99ee)"}, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },
        resize_on_border = false,
        allow_tearing    = false,
        layout           = "dwindle",
    },

    decoration = {
        rounding       = 10,
        rounding_power = 2,
        active_opacity   = 0.62,
        inactive_opacity = 0.5,
        shadow = {
            enabled      = true,
            range        = 1,
            render_power = 1,
            color        = 0xee1a1a1a,
        },
        blur = {
            enabled  = true,
            size     = 5,
            passes   = 3,
            vibrancy = 0.1696,
        },
    },

    animations = { enabled = true },
})



-- Misc
hl.config({
    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo   = false,
    },
})
