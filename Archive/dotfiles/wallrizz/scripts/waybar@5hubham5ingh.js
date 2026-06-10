export function getDarkThemeConf(colors) {
    try {
        const theme = generateTheme(colors, true);
        return generateWaybarCss(theme);
    } catch (e) {
        return `/* Theme Gen Error: ${e.message} */\n` + getFallbackCss();
    }
}

export function getLightThemeConf(colors) {
    try {
        const theme = generateTheme(colors, false);
        return generateWaybarCss(theme);
    } catch (e) {
        return `/* Theme Gen Error: ${e.message} */\n` + getFallbackCss();
    }
}

export function setTheme(newThemeConfigPath) {
    const cacheDir = HOME_DIR.concat("/.cache/wallrizz");
    const liveConfigPath = cacheDir.concat("/waybar.css");
    OS.exec(["mkdir", "-p", cacheDir]);

    let configText = STD.loadFile(newThemeConfigPath);

    if (configText && !configText.includes("@define-color")) {
        configText = getFallbackCss();
    }

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

/* 14 Distinct Accent Colors */
@define-color blue ${theme.colors[0].toHexString()};
@define-color lavender ${theme.colors[1].toHexString()};
@define-color sapphire ${theme.colors[2].toHexString()};
@define-color sky ${theme.colors[3].toHexString()};
@define-color teal ${theme.colors[4].toHexString()};
@define-color green ${theme.colors[5].toHexString()};
@define-color yellow ${theme.colors[6].toHexString()};
@define-color peach ${theme.colors[7].toHexString()};
@define-color maroon ${theme.colors[8].toHexString()};
@define-color red ${theme.colors[9].toHexString()};
@define-color mauve ${theme.colors[10].toHexString()};
@define-color pink ${theme.colors[11].toHexString()};
@define-color flamingo ${theme.colors[12].toHexString()};
@define-color rosewater ${theme.colors[13].toHexString()};
`;
}

function generateTheme(colorCodes, isDark = true) {
    let pool = [];
    if (colorCodes && colorCodes.length > 0) {
        pool = colorCodes.map(c => Color(c));
    } else {
        pool = [Color("#89b4fa"), Color("#f38ba8"), Color("#a6e3a1"), Color("#cba6f7"), Color("#94e2d5")];
    }

    pool.sort((a, b) => a.getBrightness() - b.getBrightness());

    let bgHex = isDark ? pool[0].toHexString() : pool[pool.length - 1].toHexString();
    let fgHex = isDark ? pool[pool.length - 1].toHexString() : pool[0].toHexString();

    let bg = Color(bgHex);
    let fg = Color(fgHex);

    if (Math.abs(bg.getBrightness() - fg.getBrightness()) < 50) {
        bg = Color(isDark ? "#1e1e2e" : "#eff1f5");
        fg = Color(isDark ? "#cdd6f4" : "#4c4f69");
    }

    let accents = [];
    for (let i = 0; i < 14; i++) {
        let baseColor = pool[i % pool.length];
        let newColor = Color(baseColor.toHexString());

        let spinAmt = (i * 25) % 360;
        if (spinAmt !== 0) newColor.spin(spinAmt);

        if (i % 2 === 1) newColor.saturate(20);
        if (i % 3 === 1) isDark ? newColor.brighten(15) : newColor.darken(15);

        let attempts = 0;
        while (!Color.isReadable(newColor, bg) && attempts < 10) {
            isDark ? newColor.saturate(5).brighten(5) : newColor.desaturate(5).darken(5);
            attempts++;
        }

        accents.push(newColor);
    }

    return { background: bg, foreground: fg, colors: accents };
}

function getFallbackCss() {
    return `
@define-color base #1e1e2e;
@define-color mantle #181825;
@define-color crust #11111b;
@define-color text #cdd6f4;
@define-color subtext0 #a6adc8;
@define-color subtext1 #bac2de;
@define-color surface0 #313244;
@define-color surface1 #45475a;
@define-color surface2 #585b70;
@define-color overlay0 #6c7086;
@define-color overlay1 #7f849c;
@define-color overlay2 #9399b2;
@define-color blue #89b4fa;
@define-color lavender #b4befe;
@define-color sapphire #74c7ec;
@define-color sky #89dceb;
@define-color teal #94e2d5;
@define-color green #a6e3a1;
@define-color yellow #f9e2af;
@define-color peach #fab387;
@define-color maroon #eba0ac;
@define-color red #f38ba8;
@define-color mauve #cba6f7;
@define-color pink #f5c2e7;
@define-color flamingo #f2cdcd;
@define-color rosewater #f5e0dc;
`;
}