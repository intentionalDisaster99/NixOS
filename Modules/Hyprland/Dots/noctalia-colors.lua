hl.config({
    general = {
        col = {
            active_border = "rgb(ffb68f)",
            inactive_border = "rgb(18120f)",
        },
    },

    group = {
        col = {
            border_active = "rgb(e6beab)",
            border_inactive = "rgb(18120f)",
            border_locked_active = "rgb(ffb4ab)",
            border_locked_inactive = "rgb(18120f)",
        },

        groupbar = {
            col = {
                active = "rgb(e6beab)",
                inactive = "rgb(18120f)",
                locked_active = "rgb(ffb4ab)",
                locked_inactive = "rgb(18120f)",
            },
        },
    },
    decoration = {
        rounding = 10,
        blur = {
            size = 8,
            passes = 2
        },
        shadow = {
            enabled = true,
            range = 15,
            render_power = 3,
            color = "rgb(e6beab)",
            color_inactive = "0x00000000",
        },
    }
})
