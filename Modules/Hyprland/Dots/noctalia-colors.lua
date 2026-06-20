hl.config({
    general = {
        col = {
            active_border = "rgb(bfc2ff)",
            inactive_border = "rgb(131316)",
        },
    },

    group = {
        col = {
            border_active = "rgb(c5c4dd)",
            border_inactive = "rgb(131316)",
            border_locked_active = "rgb(ffb4ab)",
            border_locked_inactive = "rgb(131316)",
        },

        groupbar = {
            col = {
                active = "rgb(c5c4dd)",
                inactive = "rgb(131316)",
                locked_active = "rgb(ffb4ab)",
                locked_inactive = "rgb(131316)",
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
            color = "rgb(c5c4dd)",
            color_inactive = "0x00000000",
        },
    },
})
