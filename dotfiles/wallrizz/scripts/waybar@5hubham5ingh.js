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

    OS.exec(["sh", "-c", "pkill -SIGUSR2 waybar > /dev/null 2>&1"]);
}


function generateWaybarCss(theme) {
    const bg = theme.background.darken(5).toHexString();
    const fg = theme.foreground.toHexString();

    const darkModuleBg = theme.background.lighten(5).toHexString();
    const textMuted = theme.foreground.desaturate().toHexString();

    const c0 = theme.color0.toHexString();
    const c1 = theme.color1.toHexString();
    const c2 = theme.color2.toHexString();
    const c3 = theme.color3.toHexString();
    const c4 = theme.color4.toHexString();
    const c5 = theme.color5.toHexString();
    const c6 = theme.color6.toHexString();
    const c7 = theme.color7.toHexString();
    const c8 = theme.color0.darken().toHexString();

    return `/* Waybar Colors perfectly mapped from Wallrizz */
@define-color base ${c0};
@define-color mantle ${c0};
@define-color crust ${c0};

@define-color text ${fg};
@define-color subtext0 ${fg}; 
@define-color subtext1 ${fg};

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

    while (colors.length < 8) {
        colors.push(
            colors[Math.floor(Math.random() * colors.length)].analogous()[3],
        );
    }

    return Object.assign(
        {
            background,
            foreground: pickColor(false),
            cursor: pickColor(),
        },
        ...selectDistinctColors(colors, 8).map((color, i) => ({
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