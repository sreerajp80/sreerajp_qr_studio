"""Generates the Android launcher icon layers from assets/app_icon.png.

Engineering standard §17.5: Android ships an adaptive icon (foreground +
background) with a monochrome layer for themed icons, and the dev flavor uses
a visibly different icon.

Writes:
  android/app/src/main/res/mipmap-<density>/ic_launcher_foreground.png
  android/app/src/main/res/mipmap-<density>/ic_launcher_monochrome.png
  android/app/src/dev/res/mipmap-<density>/ic_launcher_foreground.png  (DEV badge)
  android/app/src/dev/res/mipmap-<density>/ic_launcher.png             (DEV badge)

The background layer is the colour resource @color/ic_launcher_background
(white) and the layers are combined in mipmap-anydpi-v26/ic_launcher.xml.

Needs Python 3 and Pillow. Build-time only; not part of the app.
Run from the project root:  python tool/generate_launcher_icons.py
"""

from pathlib import Path

from PIL import Image, ImageDraw

SOURCE = Path('assets/app_icon.png')
MAIN_RES = Path('android/app/src/main/res')
DEV_RES = Path('android/app/src/dev/res')

# Adaptive icons are 108 dp; launchers always keep the centre 66 dp circle.
# The emblem is fitted into 64 dp to leave a small margin.
CANVAS_DP = 108
EMBLEM_DP = 64
DENSITIES = {'mdpi': 1.0, 'hdpi': 1.5, 'xhdpi': 2.0, 'xxhdpi': 3.0, 'xxxhdpi': 4.0}
LEGACY_DP = 48

WHITE = (255, 255, 255)
BADGE_RED = (211, 47, 47)


def is_coloured(rgb):
    hi, lo = max(rgb), min(rgb)
    return hi > 60 and hi - lo > 60


def load_source():
    image = Image.open(SOURCE).convert('RGB')
    return image


def without_black_corners(image):
    """The source has black outside its rounded corners; make it white."""
    out = image.copy()
    px = out.load()
    w, h = out.size
    for y in range(h):
        for x in range(w):
            if max(px[x, y]) < 60:
                px[x, y] = WHITE
    return out


def emblem_box(image):
    """Square box around the coloured emblem (the grey shadow is left out)."""
    px = image.load()
    w, h = image.size
    xs, ys = [], []
    for y in range(h):
        for x in range(w):
            if is_coloured(px[x, y]):
                xs.append(x)
                ys.append(y)
    cx = (min(xs) + max(xs)) / 2
    cy = (min(ys) + max(ys)) / 2
    side = max(max(xs) - min(xs), max(ys) - min(ys)) + 1
    return cx, cy, side


def foreground_canvas(image):
    """White square, emblem centred and scaled to EMBLEM_DP of CANVAS_DP."""
    cx, cy, side = emblem_box(image)
    canvas_side = round(side * CANVAS_DP / EMBLEM_DP)
    canvas = Image.new('RGB', (canvas_side, canvas_side), WHITE)
    left = round(cx - canvas_side / 2)
    top = round(cy - canvas_side / 2)
    # Paste the source so the emblem centre lands on the canvas centre; any
    # area outside the source stays white.
    canvas.paste(image, (-left, -top))
    return canvas, side


def monochrome_from(canvas):
    """Solid where the emblem is coloured, clear where it is white."""
    rgb = canvas.load()
    w, h = canvas.size
    mono = Image.new('RGBA', (w, h), (255, 255, 255, 0))
    out = mono.load()
    for y in range(h):
        for x in range(w):
            r, g, b = rgb[x, y]
            hi, lo = max(r, g, b), min(r, g, b)
            spread = hi - lo
            alpha = 0 if hi <= 60 else max(0, min(255, (spread - 30) * 255 // 50))
            out[x, y] = (255, 255, 255, alpha)
    return mono


def draw_badge(image, cx, cy, emblem_side):
    """Red rounded "DEV" label on the lower part of the emblem.

    Letters are plain shapes, so no font file is needed.
    """
    draw = ImageDraw.Draw(image)
    unit = emblem_side / 720.0  # sizes below are tuned for a 720 px emblem
    width, height = 400 * unit, 150 * unit
    top = cy + 165 * unit
    left = cx - width / 2
    draw.rounded_rectangle(
        (left, top, left + width, top + height),
        radius=36 * unit,
        fill=BADGE_RED,
        outline=WHITE,
        width=max(1, round(10 * unit)),
    )

    stroke = 22 * unit
    letter_w, letter_h, gap = 80 * unit, 92 * unit, 26 * unit
    x = cx - (3 * letter_w + 2 * gap) / 2
    y = top + (height - letter_h) / 2

    def rect(x0, y0, x1, y1):
        draw.rectangle((x0, y0, x1, y1), fill=WHITE)

    # D
    rect(x, y, x + stroke, y + letter_h)
    rect(x, y, x + letter_w - stroke, y + stroke)
    rect(x, y + letter_h - stroke, x + letter_w - stroke, y + letter_h)
    rect(x + letter_w - stroke, y + stroke, x + letter_w, y + letter_h - stroke)
    # E
    x += letter_w + gap
    rect(x, y, x + stroke, y + letter_h)
    rect(x, y, x + letter_w, y + stroke)
    rect(x, y + (letter_h - stroke) / 2, x + letter_w * 0.85, y + (letter_h + stroke) / 2)
    rect(x, y + letter_h - stroke, x + letter_w, y + letter_h)
    # V
    x += letter_w + gap
    mid = x + letter_w / 2
    draw.polygon(
        [
            (x, y),
            (x + stroke * 1.1, y),
            (mid, y + letter_h - stroke * 1.3),
            (x + letter_w - stroke * 1.1, y),
            (x + letter_w, y),
            (mid + stroke * 0.6, y + letter_h),
            (mid - stroke * 0.6, y + letter_h),
        ],
        fill=WHITE,
    )


def save(image, path):
    path.parent.mkdir(parents=True, exist_ok=True)
    image.save(path, optimize=True)
    print('wrote', path.as_posix(), image.size)


def main():
    source = load_source()
    clean = without_black_corners(source)
    canvas, emblem_side = foreground_canvas(clean)
    mono = monochrome_from(canvas)

    dev_canvas = canvas.copy()
    c = canvas.size[0] / 2
    draw_badge(dev_canvas, c, c, emblem_side)

    _, _, source_side = emblem_box(clean)
    scx, scy, _ = emblem_box(clean)
    dev_legacy = source.copy()
    draw_badge(dev_legacy, scx, scy, source_side)

    for name, scale in DENSITIES.items():
        size = round(CANVAS_DP * scale)
        legacy = round(LEGACY_DP * scale)
        folder = f'mipmap-{name}'
        save(canvas.resize((size, size), Image.LANCZOS),
             MAIN_RES / folder / 'ic_launcher_foreground.png')
        save(mono.resize((size, size), Image.LANCZOS),
             MAIN_RES / folder / 'ic_launcher_monochrome.png')
        save(dev_canvas.resize((size, size), Image.LANCZOS),
             DEV_RES / folder / 'ic_launcher_foreground.png')
        save(dev_legacy.resize((legacy, legacy), Image.LANCZOS),
             DEV_RES / folder / 'ic_launcher.png')


if __name__ == '__main__':
    main()
