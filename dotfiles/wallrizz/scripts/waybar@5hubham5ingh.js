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

    OS.exec(["sh", "-c", "killall -SIGUSR2 waybar || pkill -SIGUSR2 waybar"]);
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

/* 14 Distinct Accent Colors Pulled from the Expanded Pool */
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
    const colors = colorCodes.map((c) => Color(c));
    const pickColor = (dark) => {
        const index = colors.findIndex((color) =>
            (dark ?? isDark) ? color.isDark() : color.isLight()
        );

        return index !== -1
            ? colors.splice(index, 1)[0]
            : isDark
                ? Color("black")
                : Color("white");
    };

    const background = pickColor();

    for (const color of colors) {
        while (!Color.isReadable(color, background)) {
            isDark ? color.saturate(1).brighten(1) : color.desaturate(1).darken(1);
        }
    }

    const originalColors = [...colors];
    if (originalColors.length > 0) {
        for (let i = 1; i <= 60; i++) {
            let baseColor = originalColors[i % originalColors.length];
            let spinAngle = (i * 15) % 360;
            let variation = baseColor.spin(spinAngle);

            if (i % 2 === 0) variation.saturate(15);
            if (i % 3 === 0) isDark ? variation.brighten(15) : variation.darken(15);

            colors.push(variation);
        }
    }

    return Object.assign(
        {
            background,
            foreground: pickColor(false),
            cursor: pickColor(),
        },
        ...selectDistinctColors(colors, 14).map((color, i) => ({
            [`color${i}`]: color,
        })),
    );
}

function selectDistinctColors(colorObjects, count) {
    const sortedColors = colorObjects.sort((a, b) =>
        a.getBrightness() - b.getBrightness()
    );

    const selectedColors = [];
    while (selectedColors.length < count && colorObjects.length > 0) {
        if (selectedColors.length === 0) {
            const midIndex = Math.floor(sortedColors.length / 2);
            selectedColors.push(sortedColors[midIndex]);
            sortedColors.splice(midIndex, 1);
            continue;
        }

        let maxDistanceColor = null;
        let maxDistance = -1;

        for (let i = 0; i < sortedColors.length; i++) {
            const currentColor = sortedColors[i];
            const minDistance = Math.min(
                ...selectedColors.map((selected) =>
                    Color.readability(selected, currentColor)
                ),
            );

            if (minDistance > maxDistance) {
                maxDistance = minDistance;
                maxDistanceColor = currentColor;
            }
        }

        if (maxDistanceColor) {
            selectedColors.push(maxDistanceColor);
            sortedColors.splice(sortedColors.indexOf(maxDistanceColor), 1);
        } else {
            break;
        }
    }

    return selectedColors;
}