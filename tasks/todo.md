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

## Phase 2: Blog and topic validation (July 30, 2026)

Branch: feat/blog-revision. Specs: SPEC-blog.md, SPEC-blog-writer.md, SPEC-blog-revision.md.
Items 41 to 65 shipped earlier the same day. Items 66 to 77 are from SPEC-blog-revision.md.

### Site side (SPEC-blog.md, items 41 to 53)
- [x] Items 41 to 53: content collection, blog index, post page, prose block, JSON-LD, feed, nav and footer links, llms.txt

### n8n Blog Writer (SPEC-blog-writer.md, items 54 to 65)
- [x] Items 54 to 64: workflow, backlog data table, live web search validation, Telegram approval
- [ ] Item 65: record real cost from the Anthropic console after one full cycle

### Validation advice quality (SPEC-blog-revision.md)
- [x] Item 66: Angle line no longer recommends leading with the seller's weaknesses
- [x] Item 67: AI Overview line weighs phrasing resilience and names the citation risk
- [x] Item 68: entity recognition check on proposed category labels
- [x] Item 69: assessment wired into the drafting prompt
- [x] Item 70: verified by manual execution 432. Found and fixed a second bug on the way: maxTokens 1024 truncated the response before the Verdict line could be generated, now 2048

### Post rewrite (SPEC-blog-revision.md) — CANCELLED, false premise
- [-] Items 71 to 74: cancelled. The post positioned Solox Tek as one person. The owner
      confirmed it is a team, which the live site has said all along. Both drafts discarded.
      The ordering rule from item 72 and the softening rule from item 74 carried into item 78.

### Correction sweep (unplanned, from the same finding)
- [x] Removed the one person claim from the live validation prompt in n8n, where it was
      shaping every assessment, and added a rule forbidding the node from assuming company size
- [x] Corrected the claim in SPEC-blog.md and SPEC-blog-writer.md
- [x] Recorded the propagation path and two preventive rules in SPEC-blog-revision.md Decision Log 7

### Replacement post (SPEC-blog-revision.md bucket V)
- [x] Item 75: src/content/blog/fixed-price-vs-time-and-materials.md, headcount neutral topic
- [x] Item 76: angle grounded in a live search, the unoccupied position is risk allocation
- [x] Item 77: limits in the middle, never in the lead
- [x] Item 78: only the two engagement claims already public on the site
- [x] Item 79: llms.txt line

### Backlog
- [x] Item 80: the one person agency row retires itself tonight via the pending approval timeouts
- [ ] Item 81: owner action, set the fixed price row to drafted in the n8n data table UI,
      otherwise the next scheduled run drafts a duplicate. The MCP surface has no row update tool.
