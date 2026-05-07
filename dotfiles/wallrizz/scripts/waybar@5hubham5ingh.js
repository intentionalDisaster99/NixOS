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

        const darkModuleBg = extract("inactive_tab_background", "#181825");
        const textMuted = extract("inactive_tab_foreground", "#a6adc8");

        const c0 = extract("color0", "#45475a");
        const c1 = extract("color1", "#f38ba8");
        const c2 = extract("color2", "#a6e3a1");
        const c3 = extract("color3", "#f9e2af");
        const c4 = extract("color4", "#89b4fa");
        const c5 = extract("color5", "#cba6f7");
        const c6 = extract("color6", "#94e2d5");
        const c7 = extract("color7", "#bac2de");
        const c8 = extract("color8", "#585b70");

        const css = `/* Waybar Colors perfectly mapped from Kitty UI config */
@define-color base ${c0};
@define-color mantle ${bg};
@define-color crust ${bg};

@define-color text ${fg};
@define-color subtext0 ${textMuted};
@define-color subtext1 ${fg};

/* Waybar modules now use the dark background for high contrast */
@define-color surface0 ${darkModuleBg};
@define-color surface1 ${darkModuleBg};
@define-color surface2 ${darkModuleBg};

@define-color overlay0 ${c8};
@define-color overlay1 ${c7};
@define-color overlay2 ${fg};

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