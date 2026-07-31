#!/usr/bin/env bash
# Renders every card template in this directory to a 1080x1350 PNG.
#
#   ./cards/render.sh              all cards
#   ./cards/render.sh 3-compare    one card
#
# No npm dependencies. Fonts and the logo are inlined into a generated
# assets.css so a card renders identically on any machine, with or without
# network access. That file and the PNGs are gitignored: both are build output.
set -euo pipefail
cd "$(dirname "$0")"
ROOT=".."

CHROME="${CHROME:-/Applications/Google Chrome.app/Contents/MacOS/Google Chrome}"
[ -x "$CHROME" ] || { echo "Chrome not found. Set CHROME=/path/to/chrome" >&2; exit 1; }

for f in "$ROOT/node_modules/@fontsource-variable/sora/files/sora-latin-wght-normal.woff2" \
         "$ROOT/node_modules/@fontsource-variable/manrope/files/manrope-latin-wght-normal.woff2" \
         "$ROOT/public/logo-icon.png"; do
  [ -f "$f" ] || { echo "Missing $f. Run npm install first." >&2; exit 1; }
done

# Regenerated every run so a font or logo change propagates without thinking about it.
python3 - "$ROOT" <<'PY'
import base64, pathlib, sys
root = pathlib.Path(sys.argv[1])
enc = lambda p: base64.b64encode((root / p).read_bytes()).decode()
sora = enc("node_modules/@fontsource-variable/sora/files/sora-latin-wght-normal.woff2")
manrope = enc("node_modules/@fontsource-variable/manrope/files/manrope-latin-wght-normal.woff2")
logo = enc("public/logo-icon.png")
pathlib.Path("assets.css").write_text(
    f"@font-face{{font-family:'Sora';src:url(data:font/woff2;base64,{sora}) format('woff2');"
    "font-weight:100 800;font-display:block}\n"
    f"@font-face{{font-family:'Manrope';src:url(data:font/woff2;base64,{manrope}) format('woff2');"
    "font-weight:200 800;font-display:block}\n"
    f":root{{--logo:url(data:image/png;base64,{logo})}}\n"
)
PY

targets=("$@")
[ ${#targets[@]} -eq 0 ] && targets=(*.html)

for t in "${targets[@]}"; do
  html="${t%.html}.html"
  [ -f "$html" ] || { echo "No such card: $html" >&2; exit 1; }
  "$CHROME" --headless --disable-gpu --hide-scrollbars \
            --force-device-scale-factor=1 --window-size=1080,1350 \
            --screenshot="${html%.html}.png" "file://$PWD/$html" 2>/dev/null
  echo "  ${html%.html}.png"
done
