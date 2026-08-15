#!/usr/bin/env bash
# Renders every card template in this directory to a 1080x1350 PNG.
#
#   ./cards/render.sh                    all cards, square
#   ./cards/render.sh 3-compare          one card, square
#   SIZE=4x5 ./cards/render.sh 3-compare one card, portrait
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

# 1:1 is the default: it renders uncropped on both desktop and mobile.
# 4:5 takes more phone feed space but LinkedIn crops it slightly on desktop,
# which eats the logo and footer, so it is opt in per card.
case "${SIZE:-1x1}" in
  1x1) W=1080; H=1080 ;;
  4x5) W=1080; H=1350 ;;
  *)   echo "SIZE must be 1x1 or 4x5" >&2; exit 1 ;;
esac

targets=("$@")
[ ${#targets[@]} -eq 0 ] && targets=(*.html)
[ "${SIZE:-1x1}" = "4x5" ] && SUF="-4x5"

for t in "${targets[@]}"; do
  html="${t%.html}.html"
  [ -f "$html" ] || { echo "No such card: $html" >&2; exit 1; }
  "$CHROME" --headless --disable-gpu --hide-scrollbars \
            --force-device-scale-factor=1 --window-size=$W,$H \
            --screenshot="${html%.html}${SUF:-}.png" "file://$PWD/$html" 2>/dev/null
  echo "  ${html%.html}${SUF:-}.png (${W}x${H})"
done
