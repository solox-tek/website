# Implementation Plan: Solox Tek Website Improvements, Phase 1

Source spec: SPEC.md (repo root). Branch: feat/site-review-improvements. PR only after the owner tests locally.

## Overview

Implement the July 2026 review findings: shared Layout, copy and conversion fixes, FAQ sections with structured data, SEO and accessibility passes, performance fixes, approved trust content (Limo Mont, Meta credential), and repo hygiene. Visual language and pricing numbers stay unchanged.

## Architecture Decisions

- No test framework. A 3 page static Astro site earns verification through build gates, browser checks, and grep gates on dist output, per SPEC.md Testing Strategy. Each task's Verify section is its test.
- New src/layouts/Layout.astro owns head, reset, fonts, Cal loader, and (later) analytics. Pages keep their per page styles and scripts.
- Canonical URL form: with trailing slash, matching the sitemap. Derived centrally in Layout.
- Cloudflare Web Analytics beacon (spec item 31) is NOT in this plan: blocked on an owner dashboard action. Everything else from SPEC.md Phase 1 and 2 is included, except the optional chimp3 case study (spec item 40, owner has not asked for it).

## Task List

### Phase A: Foundation

Task 1: Commit the pending Nav/Footer refactor
- Description: Stage and commit the already made local changes: src/components/Nav.astro, src/components/Footer.astro, and the three modified pages (includes the earlier "Ad spend up to 30,000 EUR" fix). Deploy safety: pages import the components, so they must land together.
- Acceptance: git status clean apart from planning artifacts; build passes.
- Verify: npm run build; all three pages render in the browser.
- Dependencies: none. Files: src/components/Nav.astro, src/components/Footer.astro, src/pages/index.astro, src/pages/services.astro, src/pages/paid-media.astro. Scope: M (commit only, no new edits).

Task 2: Create Layout.astro and migrate all three pages
- Description: New src/layouts/Layout.astro with props title, description, path, optional image. Renders charset, viewport, favicon, canonical and og:url from path with trailing slash, full OG and Twitter set (og:site_name Solox Tek, twitter:site @SoloxTek, og:image with dimensions), shared reset and sxDrift keyframes, font imports, Cal.com loader. Pages keep only page specific head bits (JSON-LD stays in pages for now).
- Acceptance: all three pages use Layout; inner pages gain the full Twitter/OG set; canonical and og:url end with a slash on inner pages; no duplicated reset/fonts/Cal loader remains in pages.
- Verify: npm run build; diff of each built page head against the pre change head shows only intended differences; browser check of all three pages.
- Dependencies: Task 1. Files: src/layouts/Layout.astro (new), 3 pages. Scope: M.

Task 3: Make Nav self contained and sticky on inner pages
- Description: Move the nav scroll state JS from index.astro into Nav.astro, emitted only when fixed. Non fixed variant becomes position sticky with the scrolled background style. Delete any remaining duplicated .hx0/.navlink hover rules from pages.
- Acceptance: homepage nav behavior unchanged; on services and paid media the Book a call pill stays visible when scrolling; no page level duplicate hover rules remain.
- Verify: npm run build; browser scroll check on all three pages.
- Dependencies: Task 2. Files: src/components/Nav.astro, 3 pages. Scope: S.

Checkpoint A: build clean, three pages visually identical to before except sticky inner nav, git log has three clean commits.

### Phase B: Copy and Conversion

Task 4: Resolve the discovery naming conflict
- Description: Engagement step 1 renamed to "Audit and roadmap" with body opening "After the free call, a paid and focused audit of one workflow, with a plan ranked by ROI." Closing homepage CTA button restores "free". Services CTA sentence becomes "Book a call and we'll find the workflow with the biggest payoff, then scope it."
- Acceptance: the word discovery no longer describes a paid step anywhere; closing CTA says free; services sentence has its noun.
- Verify: grep for "Discovery &" in src returns nothing; browser read of both sections.
- Dependencies: Task 2. Files: index, services. Scope: S.

Task 5: Paid media copy and pricing clarity
- Description: "Bi weekly reporting and call" becomes "Reporting and a call every two weeks". Merge the two near duplicate testing bullets into "Structured A/B testing of creatives, copy, and audiences". Hero claim becomes "Meta certified, with over 15 years in performance marketing across Meta, Google, and TikTok." Growth bullet becomes "Conversion tracking and pixel management". Footnote: "Setup and tracking implementation is 450 EUR one time on all plans, waived with a 6 month commitment." Add "Month to month. Cancel anytime." Custom plan pill: "We'll build you a custom plan." Meta description aligned with the hero wording.
- Acceptance: all seven strings updated exactly; prices unchanged; tier bullet counts still render cleanly.
- Verify: build; browser read of hero, tiers, fine print.
- Dependencies: Task 2. Files: paid-media. Scope: S.

Task 6: Copy polish batch
- Description: Rewrite the Why us paragraph so it stops repeating the hero. Parallel noun forms in the lead automation list. DeFi line explains itself ("we build DeFi systems where a bug costs real money"). Reframe the 20%+ stat caption as first party observation. Standardize "over a decade" everywhere. Footer copyright "© 2026 Solox Tek". "built to best practices" on paid media.
- Acceptance: no sentence appears verbatim on two pages; no unsourced claim presented as an external stat.
- Verify: build; browser read; grep for the old phrases returns nothing.
- Dependencies: Task 2. Files: index, services, paid-media, Footer. Scope: S.

Task 7: Fix dead ends and internal links
- Description: Homepage What we do cards link to /services. Add a "See all services" line with a descriptive anchor under the cards. Featured AI Automation card on services gets a next step link to /#process.
- Acceptance: cards are real anchors with the existing hover style intact; new links work.
- Verify: build; click through in the browser.
- Dependencies: Task 2. Files: index, services. Scope: S.

Checkpoint B: full browser pass of all copy changes, zero dashes in rendered output (grep the dist HTML).

### Phase C: FAQ

Task 8: Homepage FAQ section with FAQPage JSON-LD
- Description: New FAQ section between What you get and the closing CTA, native details/summary accordion styled to the existing language, 6 owner approved questions and answers (agency, cost, timeline, data safety, maintenance, what happens on the call). FAQPage node merged into the existing JSON-LD @graph, text mirrored exactly.
- Acceptance: visible text and JSON-LD match verbatim; section heading is an h2; accordion works without JS.
- Verify: build; browser interaction; paste built JSON-LD into a schema validator mentally checked against schema.org FAQPage shape.
- Dependencies: Task 4 (copy consistency). Files: index. Scope: M.

Task 9: Paid media FAQ with FAQPage JSON-LD
- Description: Short FAQ between How it works and the CTA: account and pixel ownership (client owns), contract terms (month to month, cancel anytime), time to first results, what happens near the spend cap. FAQPage JSON-LD added.
- Acceptance: same bar as Task 8.
- Verify: same as Task 8.
- Dependencies: Task 5. Files: paid-media. Scope: S.

### Phase D: SEO

Task 10: Agency wording and llms.txt
- Description: "AI automation agency" enters the homepage title, meta description, Organization JSON-LD description, and once in the Why us body. Rewrite public/llms.txt: all three pages one line each, retainer range 1,300 to 3,300 EUR, free call CTA, FAQ mirrored.
- Acceptance: grep finds agency in all four homepage locations; llms.txt lists three URLs in canonical form.
- Verify: build; grep dist.
- Dependencies: Tasks 6, 8. Files: index, public/llms.txt. Scope: S.

Task 11: Inner page structured data
- Description: paid-media gets Service with OfferCatalog of the three tiers (price, priceCurrency EUR, spend cap in description) plus BreadcrumbList. services gets BreadcrumbList plus ItemList of the five service names. Same is:inline JSON.stringify pattern as index.
- Acceptance: valid JSON-LD, prices match the visible tiers exactly.
- Verify: build; JSON parses; spot check against schema.org types.
- Dependencies: Task 5. Files: services, paid-media. Scope: S.

Task 12: Compress og.png
- Description: Reduce public/og.png (currently 508KB) under 300KB, target under 150KB, no visible loss at 1200x630.
- Acceptance: file under 300KB, dimensions unchanged, looks identical at social preview size.
- Verify: ls -l; visual open.
- Dependencies: none. Files: public/og.png. Scope: XS.

Checkpoint C: structured data present on all pages, llms.txt current, share image light.

### Phase E: Accessibility

Task 13: Semantic structure pass
- Description: Section labels become h2, card, tier, and step titles become h3 (margin 0, identical visuals). Every page wraps content in main. Paid media pricing grid gets h2 "Pricing and packages" (can be visually subtle but must exist; simplest is converting the existing PAID MEDIA MANAGEMENT label).
- Acceptance: each page has one h1 and an ordered outline; main landmark on every page; zero visual diff.
- Verify: build; browser screenshot comparison; accessibility tree read.
- Dependencies: Tasks 8, 9 (their headings join the outline). Files: 3 pages. Scope: M.

Task 14: Small accessibility fixes
- Description: alt="" on logo images inside links that contain the wordmark (Nav and Footer). Padding on footer social icons for a 29px tap target. Scroll cue color to #6F87A4.
- Acceptance: single accessible name per link; tap targets 29px or more; cue contrast 4.5 or better.
- Verify: build; accessibility tree; computed ratio.
- Dependencies: Task 3. Files: Nav, Footer, index. Scope: XS.

Task 15: CTA contrast fix
- Description: Primary CTA gradient darkened to linear-gradient(180deg,#1B76B8,#146199) on all pages; light #36A9E6 tones stay in ring and glow only. MOST POPULAR badge recolored to pass 4.5:1.
- Acceptance: white 16px text passes 4.5:1 against both gradient stops; buttons still read as the same design family.
- Verify: computed ratios; screenshot.
- Dependencies: Task 2. Files: 3 pages. Scope: S.

Task 16: Reduced motion support
- Description: Add to Layout global CSS: media prefers-reduced-motion reduce disables all animations and smooth scroll.
- Acceptance: with reduced motion emulated, no animation runs and scrolling is instant; JS guards already existed and stay.
- Verify: browser emulation of prefers-reduced-motion.
- Dependencies: Task 2. Files: Layout. Scope: XS.

Checkpoint D: axe style pass on all three pages shows no regressions, screenshots match pre change visuals except the darker CTA.

### Phase F: Performance

Task 17: Font inlining and Cal.com defer
- Description: astro.config.mjs gets vite build assetsInlineLimit 0. Cal loader in Layout becomes lazy: injected on first pointerover, focusin, or touchstart on any [data-cal-link], with a load timeout fallback.
- Acceptance: built CSS contains no data:font URI; embed.js absent from the network log until a CTA interaction, popup still opens.
- Verify: grep dist CSS for data:font; browser network log before and after hover.
- Dependencies: Task 2. Files: astro.config.mjs, Layout. Scope: S.

Task 18: Homepage animation performance
- Description: Orb parallax moves to transform on new wrapper divs (keyframes keep the orb's own transform). Hero canvas rAF loop gated by an IntersectionObserver, cancelled off screen. Stat counter gets inline-block, min-width 2ch, text-align right, tabular-nums.
- Acceptance: no marginLeft/marginTop writes in the parallax path; canvas loop stops when hero is off screen; counter no longer shifts siblings while counting.
- Verify: code inspection; browser scroll test; visual counter check.
- Dependencies: Task 2. Files: index. Scope: S.

Task 19: Per tier Cal.com intent
- Description: Each paid media tier button gets data-cal-config with a notes prefill naming the tier; the custom plan pill likewise.
- Acceptance: opening the popup from each button carries the tier name into the booking notes.
- Verify: browser open of each tier popup, inspect the prefilled field.
- Dependencies: Task 5. Files: paid-media. Scope: XS.

### Phase G: Trust Content (owner approved)

Task 20: Who you talk to lines and Meta credential
- Description: Under the closing CTAs: engineering pages get "Your call is with a senior engineer, not a sales rep."; paid media gets "Your intro call is with the Meta certified specialist who runs the campaigns, not a sales rep." plus the Meta Certified Digital Marketing Associate credential linking the Credly badge near the hero claim. No personal name in copy.
- Acceptance: lines render under all three closing CTAs; Credly link opens the badge; no name appears.
- Verify: build; browser.
- Dependencies: Tasks 4, 5. Files: index, services, paid-media. Scope: S.

Task 21: Limo Mont case study strip
- Description: Compact named case study between Why us and How we work on the homepage: family transport business Limo Mont (limomont.rs), full modernization, digitalized bookkeeping, automated internal processes, AI agent answering pricing and service questions from their own data. Qualitative only, no invented numbers. Styled like the existing cards.
- Acceptance: strip renders, link works, copy is dash free and metric free.
- Verify: build; browser desktop and mobile.
- Dependencies: Task 6. Files: index. Scope: S.

### Phase H: Hygiene and Final Sweep

Task 22: Repo hygiene
- Description: git rm --cached solox-tek-linkedin-banner.png. README updated to the three page plus components structure, scaffolding removed. Dead code out of index.astro: sxPulseB keyframes, data-screen-label, _cleanup array and pushes.
- Acceptance: banner untracked, README accurate, grep finds none of the three dead identifiers.
- Verify: git status; grep; build.
- Dependencies: Task 18 (same file region as _cleanup). Files: README, index, git index. Scope: S.

Task 23: Final verification sweep
- Description: Full gate run from SPEC.md: build, dash grep on dist HTML (em dash, en dash check), browser pass of all three pages at desktop and 375px with console clean, Cal popup from every CTA location, JSON-LD parse check, og.png size, head inspection per page. Fix anything found, or stop and report if a fix is not obvious.
- Acceptance: every SPEC.md success criterion except the analytics beacon (blocked on owner) checks green.
- Verify: the sweep itself.
- Dependencies: all. Files: as needed. Scope: S.

## Risks and Mitigations

| Risk | Impact | Mitigation |
|------|--------|------------|
| Layout migration changes rendered head subtly | Med | Per page head diff in Task 2 verify |
| Heading tag swaps shift typography | Med | Explicit margin 0 and font inheritance, screenshot compare in Task 13 |
| Cal defer breaks the popup for fast clickers | Med | href fallback already navigates to cal.com; timeout fallback pre warms |
| og.png tooling unavailable locally | Low | Try sips, then npx sharp based one off script in scratchpad |
| JSON-LD drift from visible text later | Low | Success criterion pins verbatim mirroring; noted in SPEC boundaries |

## Out of Scope

- Cloudflare Web Analytics beacon: waiting on owner dashboard action (SPEC item 31).
- chimp3 case study (SPEC item 40): optional, owner has not requested it.
- Any pricing number change, new pages, or new dependencies.
