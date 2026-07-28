# Todo: Solox Tek Website Improvements, Phase 1

Branch: feat/site-review-improvements. One commit per task. Details in tasks/plan.md.
Status: ALL TASKS COMPLETE (July 28, 2026). Awaiting owner local test, then PR.

## Phase A: Foundation
- [x] Task 1: Commit the pending Nav/Footer refactor
- [x] Task 2: Create Layout.astro and migrate all three pages
- [x] Task 3: Make Nav self contained and sticky on inner pages
- [x] Checkpoint A: build clean, visuals unchanged, three clean commits

## Phase B: Copy and Conversion
- [x] Task 4: Resolve the discovery naming conflict
- [x] Task 5: Paid media copy and pricing clarity
- [x] Task 6: Copy polish batch
- [x] Task 7: Fix dead ends and internal links
- [x] Checkpoint B: browser pass, dash grep on dist clean

## Phase C: FAQ
- [x] Task 8: Homepage FAQ section with FAQPage JSON-LD
- [x] Task 9: Paid media FAQ with FAQPage JSON-LD

## Phase D: SEO
- [x] Task 10: Agency wording and llms.txt
- [x] Task 11: Inner page structured data
- [x] Task 12: Compress og.png (508KB to 49KB)
- [x] Checkpoint C: structured data present, llms.txt current, share image light

## Phase E: Accessibility
- [x] Task 13: Semantic structure pass
- [x] Task 14: Small accessibility fixes
- [x] Task 15: CTA contrast fix
- [x] Task 16: Reduced motion support
- [x] Checkpoint D: outline ordered, contrast passing, motion respected

## Phase F: Performance
- [x] Task 17: Font inlining and Cal.com defer (also fixed the booking popup: the embed never intercepted clicks)
- [x] Task 18: Homepage animation performance
- [x] Task 19: Per tier Cal.com intent

## Phase G: Trust Content
- [x] Task 20: Who you talk to lines and Meta credential
- [x] Task 21: Limo Mont case study strip

## Phase H: Hygiene and Final Sweep
- [x] Task 22: Repo hygiene
- [x] Task 23: Final verification sweep (30 automated gates green, mobile and desktop browser pass, console clean)

## Blocked / Out of Scope
- Cloudflare Web Analytics beacon: owner dashboard action pending
- chimp3 case study: optional, not requested
- Cal.com event types are named in Serbian ("Sastanak od 15 Min"): rename in the Cal.com dashboard to match the English site
