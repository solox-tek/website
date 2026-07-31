# Social cards

Branded images for LinkedIn posts.

```bash
./cards/render.sh                     # all cards, 1080x1080
./cards/render.sh 3-compare           # one card
SIZE=4x5 ./cards/render.sh 3-compare  # 1080x1350, saved with a -4x5 suffix
```

**Square is the default, deliberately.** Portrait takes more room in a phone feed,
but LinkedIn crops 4:5 slightly on desktop and anything taller gets centre cropped
to 4:5. The crop eats the top and bottom of the frame, which is exactly where the
logo and the footer live, so the one thing the format is supposed to buy is the
first thing it costs. Square renders uncropped on both surfaces.

Reach for `SIZE=4x5` when a card is going out mobile first and you have checked
that losing a strip top and bottom does not matter. Keep anything load bearing
inside the middle 80 percent of the frame either way.

PNGs land next to their templates. Nothing is committed except the templates and
this script: `assets.css` and every `.png` are build output.

## Why this exists rather than a design file

Ten beautiful but unrelated images build nothing. Ten images that share a palette,
a typeface and a footer are recognized in the feed before a word is read. So the
brand is fixed in `base.css` and only the composition changes per card.

**Constants**, never edited per card: the `#06121E` background with the same
radial glow and grid the site uses, Sora for display, Manrope for body, `#8FE0FF`
as the accent, the logo lockup, the footer rule.

**Composition**, chosen per post. The five templates are archetypes, not slots:

| Template | Use it for |
| --- | --- |
| `1-checklist` | rules, steps, tests, anything a reader might save |
| `2-number` | one figure that carries the whole point |
| `3-compare` | two options, side by side |
| `4-statement` | a single sentence worth reading alone |
| `5-flow` | a sequence, in order |

Pick by what the content is. Reusing one template for every post is the thing
this is built to avoid.

## Adding a card

Copy the closest template, change the markup and the per-card `<style>` block.
Do not touch `base.css` unless the brand itself changes.

Two rules carried from `SPEC.md`, and they bind card copy as much as page copy:

- No em dashes or en dashes.
- No sentence ending in a colon followed by a run of comma separated items.

And one that matters more here than anywhere: **no invented numbers.** A figure
on a card reads as a fact, gets screenshotted, and outlives the post. Every number
must be traceable to something already public on solox-tek.com or to a named
source on the card itself.

## Requirements

Chrome, and `npm install` for the fonts. Override the browser path with
`CHROME=/path/to/chrome ./cards/render.sh` on Linux or CI.
