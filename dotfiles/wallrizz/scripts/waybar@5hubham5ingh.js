export function getDarkThemeConf(colors) {
    const theme = generateTheme(colors, true);
    return generateWaybarCss(theme);
}

export function getLightThemeConf(colors) {
    const theme = generateTheme(colors, false);
    return generateWaybarCss(theme);
}

export function setTheme(newThemeConfigPath) {
    const cacheDir = HOME_DIR.concat("/.cache/wallrizz");
    const liveConfigPath = cacheDir.concat("/waybar.css");
    OS.exec(["mkdir", "-p", cacheDir]);

    const configText = STD.loadFile(newThemeConfigPath);
    if (configText) {
        const file = STD.open(liveConfigPath, "w");
        if (file) {
            file.puts(configText);
            file.close();
        }
    }

    OS.exec(["sh", "-c", "killall -SIGUSR2 waybar || pkill -SIGUSR2 waybar > /dev/null 2>&1"]);
}


function generateWaybarCss(theme) {
    const bgHex = theme.background.toHexString();
    const fgHex = theme.foreground.toHexString();

    const base = Color(bgHex).darken(5).toHexString();
    const mantle = Color(bgHex).darken(8).toHexString();
    const crust = Color(bgHex).darken(10).toHexString();

    const surface0 = bgHex;
    const surface1 = Color(bgHex).lighten(5).toHexString();
    const surface2 = Color(bgHex).lighten(10).toHexString();

    const text = fgHex;
    const subtext1 = Color(fgHex).darken(10).toHexString();
    const subtext0 = Color(fgHex).darken(20).toHexString();

    const overlay2 = Color(fgHex).darken(30).toHexString();
    const overlay1 = Color(fgHex).darken(40).toHexString();
    const overlay0 = Color(fgHex).darken(50).toHexString();

    return `/* Waybar Colors perfectly mapped from Wallrizz */
@define-color base ${base};
@define-color mantle ${mantle};
@define-color crust ${crust};

@define-color text ${text};
@define-color subtext0 ${subtext0};
@define-color subtext1 ${subtext1};

@define-color surface0 ${surface0};
@define-color surface1 ${surface1};
@define-color surface2 ${surface2};

@define-color overlay0 ${overlay0};
@define-color overlay1 ${overlay1};
@define-color overlay2 ${overlay2};

@define-color blue ${theme.color0.toHexString()};
@define-color lavender ${theme.color1.toHexString()};
@define-color sapphire ${theme.color2.toHexString()};
@define-color sky ${theme.color3.toHexString()};
@define-color teal ${theme.color4.toHexString()};
@define-color green ${theme.color5.toHexString()};
@define-color yellow ${theme.color6.toHexString()};
@define-color peach ${theme.color7.toHexString()};
@define-color maroon ${theme.color8.toHexString()};
@define-color red ${theme.color9.toHexString()};
@define-color mauve ${theme.color10.toHexString()};
@define-color pink ${theme.color11.toHexString()};
@define-color flamingo ${theme.color12.toHexString()};
@define-color rosewater ${theme.color13.toHexString()};
`;
}

function generateTheme(colorCodes, isDark = true) {
    const rawColors = colorCodes.map((c) => Color(c));

    // Set safe defaults just in case the wallpaper is pure black/white
    let bg = Color(isDark ? "#1e1e2e" : "#eff1f5");
    let fg = Color(isDark ? "#cdd6f4" : "#4c4f69");

    if (rawColors.length > 0) {
        // Sort by brightness to reliably grab a background and foreground
        const sorted = [...rawColors].sort((a, b) => a.getBrightness() - b.getBrightness());
        bg = isDark ? sorted[0] : sorted[sorted.length - 1];
        fg = isDark ? sorted[sorted.length - 1] : sorted[0];
    }

    const accents = [];
    const basePool = rawColors.length > 0 ? rawColors : [fg];

    for (let i = 0; i < 14; i++) {
        if (i < basePool.length) {
            accents.push(basePool[i]);
        } else {
            let sourceColor = basePool[i % basePool.length];
            let spinAmt = (i * 35) % 360;

            let newColor = Color(sourceColor.toHexString()).spin(spinAmt);

            if (i % 2 === 0) newColor.saturate(20);
            if (i % 3 === 0) isDark ? newColor.brighten(15) : newColor.darken(15);

            accents.push(newColor);
        }
    }

    for (let color of accents) {
        while (!Color.isReadable(color, bg)) {
            isDark ? color.saturate(1).brighten(1) : color.desaturate(1).darken(1);
        }
    }

    const themeMap = { background: bg, foreground: fg };
    for (let i = 0; i < 14; i++) {
        themeMap[`color${i}`] = accents[i];
    }

    return themeMap;
}