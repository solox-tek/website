# Spec: Solox Tek Website Improvements, Phase 1

Status: draft, awaiting owner approval. See Open Questions before implementing Phase 2 items.

## Objective

Raise the conversion credibility, SEO reach, accessibility, and code hygiene of the Solox Tek marketing site (solox-tek.com) based on the July 2026 multi-dimension review, without changing the visual language or adding a framework. The site sells one action: booking a free discovery call via Cal.com. Success means a cold visitor meets fewer trust gaps and contradictions on the way to that booking, search and AI answer engines get complete machine-readable signals, and the codebase stops triplicating shared markup.

Phase 1 (this spec): quick wins, homepage FAQ, Layout.astro refactor, analytics wiring.
Phase 2 (blocked on Open Questions): client proof (Limo Mont case study), paid media trust block (specialist name and Meta certification), cancellation terms.

## Tech Stack

- Astro 4 (static output, no framework runtime), deployed on Cloudflare Pages
- @astrojs/sitemap, @fontsource-variable/sora, @fontsource-variable/manrope
- Styling: inline styles in .astro files plus small `is:global` blocks. Deliberate choice, keep it.
- Booking: Cal.com popup embed (cal.com/solox-tek), email fallback contact@solox-tek.com

## Commands

- Dev server: `npm run dev` (port 4321)
- Build: `npm run build` (must pass before every commit)
- Preview built output: `npm run preview`

## Project Structure

```
src/pages/index.astro        Homepage
src/pages/services.astro     Services hub
src/pages/paid-media.astro   Paid media pricing page
src/components/Nav.astro     Shared nav (fixed and static variants)
src/components/Footer.astro  Shared footer
src/layouts/Layout.astro     NEW: shared head, reset, Cal loader, analytics
public/                      robots.txt, llms.txt, og.png, logos
```

## Code Style

Match the existing idiom: semantic tag, inline style attribute, hover rules and media queries in `is:global` blocks keyed by short class names. Example from the codebase:

```astro
<a href="/services" class="navlink" style="font-family:'Sora Variable',sans-serif;font-weight:500;font-size:14px;letter-spacing:.02em;color:#C4D6EA;transition:color .25s ease;">Services</a>
<style is:global>
.navlink:hover{color:#EEF4FB !important;}
</style>
```

Copy rules: no em dashes, no en dashes, no hyphens used as asides anywhere in visible text. Prefer rewording over hyphenated compounds ("Reporting and a call every two weeks", not "Bi-weekly reporting"). US English. Sentence case headings with a closing period in heroes.

No colon introduced lists. A sentence must never end in a colon followed by a run of comma separated items, because that is one of the most recognizable signatures of machine written prose and it reads as such even to people who could not name why. Added July 30, 2026 after the owner found nine instances across the first two blog posts. Fold the items into the sentence, or give them a sentence of their own, or use a real markdown list on separate lines when a reader would actually scan them. Do not overcorrect into bulleted lists everywhere, which is a stronger tell than the pattern it replaces. This binds post bodies, meta descriptions, and the generated social and validation copy alike, and it is enforced in the n8n drafting prompt as well as here.

## Phase 1 Work Items

### A. Deploy safety (do first)

1. Commit `src/components/Nav.astro` and `src/components/Footer.astro` together with the three modified pages. The pages import them; committing pages alone breaks the Cloudflare build.

### B. Layout refactor

2. Create `src/layouts/Layout.astro` accepting `title`, `description`, `path` (and optional `image`). It renders: charset, viewport, favicon, canonical and og:url derived from `path` with a trailing slash, the full OG and Twitter tag set (og:site_name "Solox Tek", twitter:site "@SoloxTek", og:image dimensions), the shared CSS reset and sxDrift keyframes, the fonts, and the Cal.com loader. All three pages migrate to it.
3. Move the nav scroll-state JS from index.astro into Nav.astro, gated on the `fixed` prop, so the fixed variant is self-contained.
4. Non-fixed Nav becomes `position:sticky` with the scrolled background the homepage already uses, so Book a call stays visible on inner pages. No JS.
5. Delete the page-level duplicate `.hx0:hover` and `.navlink:hover` rules that Nav and Footer already emit.

### C. Copy and conversion fixes

6. Resolve the discovery conflict: rename engagement step 1 to "Audit and roadmap", open its body with "After the free call, a paid and focused audit of one workflow, with a plan ranked by ROI." Restore "free" in the closing homepage CTA button.
7. Fix the services CTA sentence: "Book a call and we'll find the workflow with the biggest payoff, then scope it."
8. Paid media pricing tier: "Bi weekly reporting and call" becomes "Reporting and a call every two weeks". Merge the near-duplicate testing bullets into "Structured A/B testing of creatives, copy, and audiences".
9. Paid media hero certification claim, final wording: "Meta certified, with over 15 years in performance marketing across Meta, Google, and TikTok." No Google certification exists, so the copy never says "certified" about Google or TikTok.
10. Reframe the unsourced 20%+ stat as first party observation in the caption, e.g. "what we typically find when we audit a workflow". Do not invent a source.
11. Copy polish batch: rewrite the Why us paragraph so it stops repeating the hero verbatim; parallel noun forms in the lead automation list; explain the DeFi line ("we build DeFi systems where a bug costs real money"); "© 2026 Solox Tek" in the footer; "built to best practices"; "We'll build you a custom plan."; standardize on "over a decade" everywhere; align the paid media meta description with the hero (over 15 years).
12. Link the dead ends: homepage What we do cards link to /services, add a "See all services" line under them, featured AI Automation card on services gets a next step link. Use descriptive anchors ("AI automation services").
13. Resolve the setup fee contradiction (owner delegated the wording, numbers unchanged): the Growth tier bullet becomes "Conversion tracking and pixel management" (ongoing work), and the footnote states explicitly that setup applies to all plans: "Setup and tracking implementation is 450 EUR one time on all plans, waived with a 6 month commitment." Add cancellation terms to the fine print: "Month to month. Cancel anytime."

### D. Homepage FAQ (new section)

14. Insert an FAQ section between What you get and the closing CTA on index.astro, in the existing visual language (simple two column list or minimal accordion, no library). 6 questions, visible HTML text:
    - What does an AI automation agency do?
    - How much does an AI automation project cost?
    - How long until something is live?
    - Is our data safe if AI touches it?
    - Do we need our own developers to maintain it?
    - What actually happens on the discovery call?
    Answers are drafted (see review notes) but every business claim in them must be confirmed by the owner before publishing (Open Question 4).
15. Add FAQPage JSON-LD merged into the existing @graph on index.astro, mirroring the visible text exactly.
16. Add a short FAQ to paid-media.astro between How it works and the CTA: who owns the ad accounts and pixel (the client does), contract terms (month to month, cancel anytime), time to first results, what happens when spend approaches the cap. Mark up with FAQPage JSON-LD.

### E. SEO and metadata

17. Trailing slash consistency: canonical and og:url on inner pages match the sitemap form (with slash). Handled centrally by Layout.astro.
18. Work "AI automation agency" once into: homepage title, meta description, Organization JSON-LD description, and one body mention (Why us paragraph).
19. Rewrite public/llms.txt: one line per page for all three URLs, the 1,300 to 3,300 EUR retainer range, the free discovery call CTA, and mirror the FAQ questions and answers.
20. Inner page JSON-LD: paid-media gets Service with an OfferCatalog of the three tiers (price, priceCurrency EUR, spend cap in description) plus BreadcrumbList; services gets BreadcrumbList plus an ItemList of the five service names. Reuse the is:inline JSON.stringify pattern.
21. Compress public/og.png to under 300KB (target under 150KB) with no visible loss.

### F. Accessibility

22. Darken the primary CTA gradient to pass AA at 4.5:1 for white 16px text, e.g. `linear-gradient(180deg,#1B76B8,#146199)`; keep the light #36A9E6 tones for ring and glow only. Apply to all CTAs and the MOST POPULAR badge.
23. Semantic pass: section labels become h2, card and tier and step titles become h3 (with margin:0 so visuals do not change), every page wraps content in `<main>`, paid media pricing grid gets an h2 "Pricing and packages".
24. Reduced motion: add to the shared global CSS `@media (prefers-reduced-motion:reduce){*,*::before,*::after{animation:none !important}html{scroll-behavior:auto}}`.
25. Small fixes: `alt=""` on the logo img inside links that already contain the wordmark; padding on the 17px footer social icons for a 29px tap target; scroll cue color to #6F87A4.

### G. Performance

26. `vite: { build: { assetsInlineLimit: 0 } }` in astro.config.mjs so the unused cyrillic-ext font subset stops shipping inside the blocking CSS.
27. Defer the Cal.com loader: inject embed.js on first pointerover, focusin, or touchstart of any `[data-cal-link]`, with a setTimeout-after-load fallback. The href fallback already covers non-JS.
28. Orb parallax writes transforms on a wrapper div instead of marginLeft/marginTop on the blurred orbs.
29. Gate the hero canvas rAF loop with an IntersectionObserver so it stops when the hero is off screen.
30. Stat counter: `display:inline-block;min-width:2ch;text-align:right;font-variant-numeric:tabular-nums` on #sb-stat so the layout stops shifting while counting.

### H. Analytics

31. Cloudflare Web Analytics beacon in Layout.astro. Blocked on one owner action in the Cloudflare dashboard: either enable Web Analytics on the Pages project (auto injection, no code needed) or create a Web Analytics site and hand over the snippet token for Layout.astro. Steps are documented in the project conversation.
32. Per tier Cal.com config on the paid media tier buttons (notes prefill with the tier name) so tier intent reaches the intro call. This replaces custom click events: Cloudflare Web Analytics does not support custom events, so page level traffic comes from the beacon and booking intent comes from Cal.com's own data. A Pages Function for custom events stays out of scope unless the owner asks.

### I. Repo hygiene

34. `git rm --cached solox-tek-linkedin-banner.png` (gitignore already intends to exclude it).
35. Update README.md: three pages plus components structure, remove push-to-GitHub scaffolding.
36. Delete dead code in index.astro: `@keyframes sxPulseB`, `data-screen-label`, the `_cleanup` array and its push sites.

## Phase 2 Work Items (unblocked, content approved)

37. Limo Mont mini case study strip on the homepage between Why us and How we work. Named and linked (limomont.rs), owner approved (family business, no legal concerns). Qualitative only, no numbers: full modernization of a small construction business, digitalized bookkeeping, automated internal processes, and an AI agent that answers pricing and service questions from their own data. No metric until the owner supplies a real measured one; industry averages must never be presented as this client's result.
38. Paid media trust block: show the Meta Certified Digital Marketing Associate credential linking the Credly badge. The specialist is not named or promoted in site copy (owner decision); the badge page itself carries the name and that is acceptable.
39. "Who you will talk to" line under each CTA. Engineering pages: "Your call is with a senior engineer, not a sales rep." Paid media: "Your intro call is with the Meta certified specialist who runs the campaigns, not a sales rep."
40. Optional second proof point: anonymized development case study ("a Web3 startup") based on the chimp3 engagement, if the owner wants it.

## Testing Strategy

No test framework exists and none is warranted for a 3 page static site. Verification gates instead:

- `npm run build` passes with zero errors and zero new warnings before every commit.
- Browser verification after every change batch: all three pages render at desktop and 375px mobile, console clean, Cal popup opens from nav, hero, tiers, and closing CTA.
- FAQ JSON-LD validated against schema.org (visible text and markup must match exactly).
- Contrast changes spot-checked with computed ratios (4.5:1 minimum for normal text).
- After the Layout refactor: view-source diff of each page's head against the pre-refactor head; only intended differences (added tags, fixed canonical) may appear.
- After deploy: verify live canonical, sitemap, and og.png size; run one Meta and one X share preview.

## Boundaries

- Always: run the build before committing; keep the zero dash rule in all visible copy; preserve the existing visual design and inline style idiom; keep all three pages working from a single shared Layout; verify in the browser before declaring done.
- Ask first: changing any price, tier content, or business claim; publishing any client name, logo, or metric; adding a dependency; adding pages or routes; changing astro.config beyond the items in this spec; anything touching the Cloudflare dashboard.
- Never: invent metrics, clients, sources, or certifications; publish the broken TikTok certificate link; commit secrets or tokens; remove the email fallback from CTAs; introduce em or en dashes into copy.

## Success Criteria

- A single commit lands src/components with the page edits; Cloudflare deploy succeeds.
- No page contains the word "discovery" describing a paid step; the closing CTA says "free".
- Homepage has a visible FAQ whose text matches its FAQPage JSON-LD; paid media has its own FAQ.
- All canonical and og:url values match the sitemap URL forms exactly.
- "AI automation agency" appears in the homepage title, meta description, JSON-LD, and body.
- Every primary CTA passes 4.5:1 contrast; every page has one h1, ordered h2/h3 sections, and a main landmark; animations stop under prefers-reduced-motion.
- Built CSS contains no inlined font data URI; Cal embed.js does not load before first interaction with a CTA.
- Beacon requests visible in the network log on all three pages (once the token exists).
- llms.txt lists all three pages with the pricing range.
- og.png under 300KB.
- Zero em dashes, en dashes, or aside hyphens in rendered copy (grep gate on dist HTML).

## Decision Log (July 28, 2026)

1. Limo Mont: named case study approved, qualitative only. Industry averages are not client metrics and will not be presented as such. A real measured number can be added later if the owner obtains one.
2. Cancellation: month to month, cancel anytime (owner decision). Setup fee footnote reworded to apply to all plans; Growth bullet reworded to "management" to remove the contradiction. Numbers unchanged.
3. No Google credential. Meta Certified Digital Marketing Associate is real (Credly verified) and may be shared; the specialist is not personally promoted in copy. The TikTok certificate is a 2022 course completion with a dead link and is never published.
4. FAQ business claims (fixed price after audit, post handover support, data stays in client accounts) confirmed true by the owner.
5. Analytics route pending one owner action in the Cloudflare dashboard (see item 31).
6. The site currently says nowhere who takes the call; the "senior engineer, not a sales rep" line is approved positioning and truthful.

## Remaining Owner Action

- Enable Cloudflare Web Analytics (dashboard steps in the conversation), or send the snippet token.
- Optional, any time: one real measured Limo Mont number to upgrade the case study.
