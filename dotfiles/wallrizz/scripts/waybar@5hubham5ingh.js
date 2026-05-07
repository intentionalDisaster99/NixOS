// NOTHING would work, so I had to just pull it from the kitty config that it created and use that
export function getDarkThemeConf(colors) { return ""; }
export function getLightThemeConf(colors) { return ""; }

export function setTheme(newThemeConfigPath) {
    const cacheDir = HOME_DIR.concat("/.cache/wallrizz");
    const liveConfigPath = cacheDir.concat("/waybar.css");
    OS.exec(["mkdir", "-p", cacheDir]);

    let configText = STD.loadFile(newThemeConfigPath);
    if (!configText || configText.length < 100) {
        configText = STD.loadFile(cacheDir.concat("/kitty.conf"));
    }

    if (configText) {
        const extract = (key, fallback) => {
            const searchStr = key + " #";
            const idx = configText.indexOf(searchStr);
            if (idx !== -1) {
                const start = idx + key.length + 1;
                return configText.substring(start, start + 7);
            }
            return fallback;
        };
        const bg = extract("background", "#1e1e2e");
        const fg = extract("foreground", "#cdd6f4");

        const tabInactiveBg = extract("inactive_tab_background", "#181825");
        const tabActiveBg = extract("active_tab_background", "#313244");
        const selectionBg = extract("selection_background", "#45475a");

        const tabInactiveFg = extract("inactive_tab_foreground", "#a6adc8");
        const tabActiveFg = extract("active_tab_foreground", "#bac2de");

        const borderInactive = extract("inactive_border_color", "#6c7086");
        const borderActive = extract("active_border_color", "#7f849c");

        const c0 = extract("color0", "#45475a");
        const c1 = extract("color1", "#f38ba8");
        const c2 = extract("color2", "#a6e3a1");
        const c3 = extract("color3", "#f9e2af");
        const c4 = extract("color4", "#89b4fa");
        const c5 = extract("color5", "#cba6f7");
        const c6 = extract("color6", "#94e2d5");

        const css = `/* Waybar Colors perfectly mapped from Kitty UI config */
@define-color base ${bg};
@define-color mantle ${c0};
@define-color crust ${tabInactiveBg};

@define-color text ${fg};
@define-color subtext0 ${tabInactiveFg};
@define-color subtext1 ${tabActiveFg};

/* Waybar module backgrounds now use Kitty's tab/selection shading */
@define-color surface0 ${tabInactiveBg};
@define-color surface1 ${tabActiveBg};
@define-color surface2 ${selectionBg};

@define-color overlay0 ${borderInactive};
@define-color overlay1 ${borderActive};
@define-color overlay2 ${fg};

/* Standard Accents */
@define-color blue ${c4};
@define-color lavender ${c4};
@define-color sapphire ${c4};
@define-color sky ${c6};
@define-color teal ${c6};
@define-color green ${c2};
@define-color yellow ${c3};
@define-color peach ${c3};
@define-color maroon ${c1};
@define-color red ${c1};
@define-color mauve ${c5};
@define-color pink ${c5};
@define-color flamingo ${c1};
@define-color rosewater ${c1};
`;

        const file = STD.open(liveConfigPath, "w");
        if (file) {
            file.puts(css);
            file.close();
        }
    }

    OS.exec(["sh", "-c", "pkill -SIGUSR2 waybar > /dev/null 2>&1"]);
}