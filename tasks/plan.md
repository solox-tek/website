# Implementation Plan: Custom AI agents positioning

Source spec: `SPEC-ai-agents.md` (repo root), work items 82 to 96. Branch: `feat/ai-agents-positioning`. One commit per task. PR only after the owner has tested the branch locally, the convention Phase 1 and the blog followed. This file and `tasks/todo.md` replace the Phase 1 planning files, which were complete; the old versions live on in git history.

## Overview

Make the site say that Solox Tek builds custom AI agents for companies, wires them into the tools the company already uses, and improves the process around them, for engineering, marketing and sales, operations, and leadership teams. Everything is copy and markup on two existing pages plus `llms.txt`, with the hero H1 and the share image as the one decision dependent piece. Visual language, engagement model, pricing, nav, and the Limo Mont case study do not change. All copy is already drafted in the spec; the build reproduces it verbatim.

## Decision defaults

The spec's open questions 1 to 4 were not answered before planning. The plan is written for the recommended options, which are H1 Option A (`Custom AI agents that survive production.`), title Option A, nine FAQ entries, and the team examples as drafted. Every task that depends on those answers sits in Phase D behind an explicit decision gate, because regenerating `og.png` is an ask first boundary in the spec and the H1 cannot change without it (the share image would contradict the page). Phases A, B, C, and E are unaffected by the answers and ship regardless. A one line answer from the owner releases Phase D; without one, the PR opens with Phase D listed as pending.

## Architecture Decisions

- No test framework. Verification is the build gate, grep gates on `dist` output, the in app browser preview (`astro-dev` on port 4325 from `.claude/launch.json`), and the schema.org validator. Same approach as Phase 1, recorded in the spec's Testing Strategy.
- Slice by message, not by file layer. Each homepage task lands one visible message completely, copy and markup together, and leaves the page coherent at every commit. `llms.txt` is one task near the end because its acceptance criterion is a mirror of the final page text, and mirroring in progress copy would only be verified twice.
- The Teams cards are `div` elements with `data-reveal`, no hover class and no href, because there is no team specific page to land on. Grid track `minmax(min(100%,420px),1fr)` gives two by two at the 1120px content width and one column at 375px without overflow. Plain `minmax(300px,1fr)` would render three plus one on desktop, which is why the spec pins the value.
- The reveal script collects every `[data-reveal]` element once at load (`index.astro`, the `querySelectorAll('[data-reveal]')` call in the page script), so the new section animates with no script change. Reduced motion handling is inherited from `Layout.astro`.
- The Teams section is the only task with layout risk, so it lands early (Task 3) to fail fast. Copy only tasks follow.
- The FAQ change touches the `faqs` array only. The accordion and the FAQPage JSON-LD both read from it, so visible text and structured data cannot drift; the verification is a count and an order check, not a diff.
- Share image (Task 10) reuses the headless Chrome approach from `cards/render.sh` at 1200 by 630, from a committed template so the image is reproducible next time. The current `og.png` has no source in the repo, which is exactly the problem Open Question 7 names. This adds one file under `cards/`, which the spec's Project Structure listed as untouched; the spec gets amended when the task is approved (see Spec amendments).

## Dependency Graph

```
Task 1  branch and baseline
  ├── Task 2  What we do rewrite                      (index.astro)
  ├── Task 3  Teams section                           (index.astro)
  ├── Task 4  problem, why us, what you get copy      (index.astro)
  ├── Task 5  FAQ array to nine entries               (index.astro)
  ├── Task 6  hero subheadline, meta, Organization    (index.astro)
  ├── Task 7  services page                           (services.astro)
  └── Task 8  llms.txt  ← needs final wording from Tasks 3, 5, 7
Decision gate (owner answers Q1, Q2, Q7)
  └── Task 9  H1 and title (Option A)                 (index.astro)
        └── Task 10 og.png regeneration, ask first    (public/og.png, cards/og.html)
Task 11 final gates and PR  ← everything above
```

Tasks 2 to 7 are independent of each other. They run sequentially in one session because they edit the same file, but any order works.

## Task List

### Phase A: Setup

- [ ] Task 1: Branch and baseline
- Checkpoint A: build passes on the new branch, baseline recorded

### Phase B: Homepage body

- [ ] Task 2: What we do section carries the agents message
- [ ] Task 3: Teams section
- [ ] Task 4: Supporting copy in problem, why us, and what you get
- [ ] Task 5: FAQ grows to nine entries
- Checkpoint B: homepage body verified at desktop and 375px, copy gates clean

### Phase C: Decision free remainder

- [ ] Task 6: Hero subheadline, meta description, Organization description
- [ ] Task 7: Services page
- [ ] Task 8: llms.txt
- Checkpoint C: both pages and llms.txt pass every gate, structured data validates

### Phase D: Decision gated hero (Option A)

- Decision gate: owner confirms H1 Option A, title Option A, and how og.png is sourced
- [ ] Task 9: H1 and title
- [ ] Task 10: Share image regeneration (ask first)
- Checkpoint D: title under 60 characters, og.png 1200 by 630 under 300KB, share preview matches the page

### Phase E: Release

- [ ] Task 11: Final gates and PR
- Checkpoint E: every success criterion in the spec ticked, owner tested locally, PR open

## Tasks

### Task 1: Branch and baseline

**Description:** Create `feat/ai-agents-positioning` from `main`, build, and record the numbers the later gates compare against so nothing pre existing gets blamed on this work. Baseline goes into the Task 1 entry of `tasks/todo.md`. Take one desktop screenshot of the homepage from the preview for the before and after.

**Acceptance criteria:**
- [ ] Branch exists and is checked out; `git status` shows only the untracked spec and the planning files
- [ ] `npm run build` passes
- [ ] Baseline recorded: current title length (62), FAQ `Question` count in `dist/index.html` (6), `<details>` count (6), and the output of the three copy gates on the current `dist` (expected empty; anything printed is noted as pre existing)

**Verification:**
- [ ] Build succeeds: `npm run build`
- [ ] Manual check: `git branch --show-current` prints the branch name

**Dependencies:** None

**Files likely touched:** `tasks/todo.md` (baseline notes only)

**Estimated scope:** XS

### Task 2: What we do section carries the agents message

**Description:** Spec item 86. In `#what`, replace the H2 text, both card titles and paragraphs, and the link text under the grid with the spec's wording, verbatim. Markup, the `hx3` and `hx4` hover classes, the `data-reveal` attributes, and both `/services` hrefs stay as they are. The colon list in the first card goes with the old text.

**Acceptance criteria:**
- [ ] H2 reads `Custom AI agents and automation that` with `hold up in production.` inside the bold span
- [ ] Card titles are `Custom AI agents with integrations` and `Process improvement and automation`, paragraphs match the spec word for word
- [ ] Link text is `See all AI agent and automation services`; no sentence in the section ends in a colon followed by a comma separated list

**Verification:**
- [ ] Build succeeds: `npm run build`
- [ ] `grep -c 'Custom AI agents with integrations' dist/index.html` prints 1
- [ ] Copy gates from the spec print nothing on `dist`
- [ ] Manual check in the preview: both cards still lift on hover and open `/services`

**Dependencies:** Task 1

**Files likely touched:** `src/pages/index.astro`

**Estimated scope:** XS

### Task 3: Teams section

**Description:** Spec item 87. Insert `<section id="teams">` between the closing tag of `#why` and the `<!-- CASE STUDY -->` comment so the Limo Mont strip follows it as proof. Copy the `#what` section's padding and centered header block (`data-reveal`, max width 780px), H2 `Any team,` with `one bottleneck at a time.` in the span, the lead sentence in the same style as the line under the What grid, then the four card grid from the spec's Code Style snippet. Cards are `div` elements with `data-reveal`, no hover class, no href.

**Acceptance criteria:**
- [ ] Exactly one `id="teams"` in the built page, with h3s `Engineering`, `Marketing and sales`, `Operations`, `Leadership` and the spec's paragraph text verbatim
- [ ] Desktop renders two columns by two rows; at 375px one column, and the document is not wider than the viewport
- [ ] The section fades in like its neighbours with no script change, and stays static under `prefers-reduced-motion`

**Verification:**
- [ ] Build succeeds: `npm run build`
- [ ] `grep -c 'id="teams"' dist/index.html` prints 1
- [ ] Preview at desktop, then `resize_window` to mobile: the grid's computed `gridTemplateColumns` has two tracks at desktop and one at 375px; `document.documentElement.scrollWidth === window.innerWidth` is true at 375px
- [ ] Manual check: scroll through the section once at each width, console clean

**Dependencies:** Task 1

**Files likely touched:** `src/pages/index.astro`

**Estimated scope:** S

### Task 4: Supporting copy in problem, why us, and what you get

**Description:** Spec items 85, 88, 89. Three copy edits in `index.astro`. Append the two team sentences to the `#problem` paragraph. Replace the `#why` paragraph with the spec's version, which removes the colon list. In `#get`, rename the first row to `Agents and workflows that run reliably`, add a sixth row `A process that makes sense, not just a faster version of the old one`, and move the missing bottom border from row five to row six so the list still closes the way it does today.

**Acceptance criteria:**
- [ ] Problem paragraph ends with `chasing numbers nobody has in one place.`
- [ ] Why us paragraph contains `builds agents the way a software team builds software` and no longer contains `builds like a software team:`
- [ ] What you get shows six rows, dividers between every pair, none under the last

**Verification:**
- [ ] Build succeeds: `npm run build`
- [ ] `grep -c 'a faster version of the old one' dist/index.html` prints 1 and `grep -c 'software team:' dist/index.html` prints 0
- [ ] Manual check in the preview: the six row list at desktop and 375px

**Dependencies:** Task 1

**Files likely touched:** `src/pages/index.astro`

**Estimated scope:** XS

### Task 5: FAQ grows to nine entries

**Description:** Spec item 90. Edit the `faqs` array in the frontmatter only. Change the first answer, insert the chatbot question and the teams question after it, insert the process question after the data safety question, and leave the rest untouched. Final order is the nine entry list in the spec. No markup or JSON-LD edit; both follow the array.

**Acceptance criteria:**
- [ ] Nine `<details>` elements and nine `Question` objects in the built page, questions in the spec's order
- [ ] Visible text and JSON-LD text are identical for every entry (guaranteed by the shared array; confirmed by the validator)
- [ ] Every new answer passes the copy rules: no dash, no colon list, no number

**Verification:**
- [ ] Build succeeds: `npm run build`
- [ ] `grep -o '"@type":"Question"' dist/index.html | wc -l` prints 9 and `grep -c '<details' dist/index.html` prints 9
- [ ] Order check: `node -e 'const h=require("fs").readFileSync("dist/index.html","utf8");const m=h.match(/<script type="application\/ld\+json">([\s\S]*?)<\/script>/);const g=JSON.parse(m[1])["@graph"].find(x=>x["@type"]==="FAQPage");g.mainEntity.forEach((q,i)=>console.log(i+1,q.name))'`
- [ ] Paste `dist/index.html` into validator.schema.org: FAQPage with nine questions, zero errors
- [ ] Manual check: open and close each new item in the preview, the animation matches the existing ones

**Dependencies:** Task 1

**Files likely touched:** `src/pages/index.astro`

**Estimated scope:** XS

### Checkpoint B: Homepage body

- [ ] `npm run build` clean
- [ ] Copy gates print nothing on `dist`
- [ ] Homepage body reviewed in the preview at desktop and 375px, console clean, Cal popup still opens from the nav and the hero
- [ ] Four commits, one per task, each message naming the spec item
- [ ] Recommended: owner skims the preview before Phase C, since this is the bulk of the visible change

### Task 6: Hero subheadline, meta description, Organization description

**Description:** Spec items 84 and the decision free parts of 82. Replace the hero paragraph under the H1 with the spec's subheadline. In the `<Layout>` call change `description` to the 156 character meta description. In the JSON-LD `@graph`, change the Organization `description`. The title and the H1 are not touched here; they belong to Task 9.

**Acceptance criteria:**
- [ ] Hero paragraph matches the spec verbatim and both trust chips and both buttons are unchanged
- [ ] Meta description is exactly the spec string (156 characters) and still contains `AI automation agency`
- [ ] Organization description matches the spec and still contains `AI automation agency`

**Verification:**
- [ ] Build succeeds: `npm run build`
- [ ] `grep -o '<meta name="description" content="[^"]*"' dist/index.html` shows the new string; a `node -e` length check prints 156
- [ ] Copy gates print nothing on `dist`
- [ ] Manual check: hero reads correctly at 375px, nothing wraps oddly

**Dependencies:** Task 1

**Files likely touched:** `src/pages/index.astro`

**Estimated scope:** XS

### Task 7: Services page

**Description:** Spec items 92, 93, 94. Change the hero subline, the featured entry of the `engineering` array (`name`, `tagline`, four `points`), and the `description` prop of `<Layout>`. The ItemList JSON-LD is generated from the array and updates itself. The title stays `Services · Solox Tek`.

**Acceptance criteria:**
- [ ] Featured card is titled `AI Agents and Automation` with the spec's tagline and four points; the `See how we work` link is still there
- [ ] Hero subline starts with `Custom AI agents and automation are our core.`
- [ ] Meta description is the spec's 152 character string; ItemList's first item is named `AI Agents and Automation`

**Verification:**
- [ ] Build succeeds: `npm run build`
- [ ] `grep -c 'AI Agents and Automation' dist/services/index.html` prints at least 2 (card and JSON-LD)
- [ ] Copy gates print nothing on `dist`
- [ ] Manual check: `/services/` in the preview at desktop and 375px, tick marks and card layout unchanged

**Dependencies:** Task 1

**Files likely touched:** `src/pages/services.astro`

**Estimated scope:** XS

### Task 8: llms.txt

**Description:** Spec item 95. Replace `public/llms.txt` with the version in the spec. It needs the final wording of the Teams cards (Task 3), the nine FAQ questions (Task 5), and the service name (Task 7), which is why it comes after them. Blog post lines are carried over unchanged.

**Acceptance criteria:**
- [ ] Summary line names custom AI agents, integrations, and process improvement
- [ ] A `## Who we build agents for` section lists the four teams, and every one of the nine homepage FAQ questions has a short form under `## Frequently asked questions`
- [ ] No dash, no arrow glyph, no hyphenated compound in the file

**Verification:**
- [ ] `grep -n -e '—' -e '–' public/llms.txt` prints nothing
- [ ] Mirror check: for each `q:` in the `faqs` array, its question text (or the shortened form the spec gives) appears in `llms.txt`; count is 9
- [ ] `npm run build` and `grep -c 'Who we build agents for' dist/llms.txt` prints 1

**Dependencies:** Tasks 3, 5, 7

**Files likely touched:** `public/llms.txt`

**Estimated scope:** XS

### Checkpoint C: Decision free work complete

- [ ] `npm run build` clean
- [ ] All three copy gates print nothing on `dist` and `public/llms.txt`
- [ ] `validator.schema.org` clean for `/` (Organization, WebSite, FAQPage with nine) and `/services/` (BreadcrumbList, ItemList with the new first name)
- [ ] Browser pass on `/` and `/services/` at desktop and 375px, console clean, Cal popup from nav, hero, and closing CTA
- [ ] Seven commits so far, one per task

### Decision gate before Phase D

The owner answers, in one line each:

1. H1: Option A (`Custom AI agents that survive production.`) or keep the current H1.
2. Title: Option A (`Solox Tek · Custom AI agents that survive production.`, 53 characters) or keep the current title.
3. Share image: is the design source for `og.png` available, or do we render a new one from the repo palette (Task 10, ask first)?

If the answer to 1 is Option A, Tasks 9 and 10 both run; the H1 does not change without the image. If the answer is keep, Phase D is skipped and the spec's decision log records it. If no answer arrives before Task 11, the PR opens with Phase D listed as pending.

### Task 9: H1 and title

**Description:** Spec item 83 and the title in item 82, Option A. Change the H1 to `Custom AI agents that<br><span ...>survive production.</span>` keeping the existing span styling, and the `title` prop of `<Layout>` to the 53 character Option A string. Nothing else in the hero moves.

**Acceptance criteria:**
- [ ] H1 renders on two lines at desktop with `survive production.` in bold, and wraps cleanly at 375px
- [ ] `<title>` is exactly the spec string and under 60 characters
- [ ] `AI automation agency` still appears in the meta description, Organization description, and the Why us paragraph

**Verification:**
- [ ] Build succeeds: `npm run build`
- [ ] `grep -o '<title>[^<]*</title>' dist/index.html` shows the new title; a `node -e` length check prints 53
- [ ] `grep -c 'AI automation agency' dist/index.html` prints at least 3
- [ ] Manual check: hero at desktop and 375px in the preview

**Dependencies:** Decision gate (Option A)

**Files likely touched:** `src/pages/index.astro`

**Estimated scope:** XS

### Task 10: Share image regeneration (ask first)

**Description:** Spec item 96. Only with Option A. Two routes, the owner picks at the decision gate. Route A: the owner exports a new `og.png` from the original design file with headline `Custom AI agents that survive production.` and subline `Custom AI agents you own. Reliable, secure, built to scale.`; we verify dimensions and size and commit it. Route B: add `cards/og.html`, a 1200 by 630 template that imports `cards/base.css` and reproduces the current layout (logo lockup top left, two line headline with the second line in the accent gradient, dim subline), render it with the same headless Chrome call `cards/render.sh` uses but with `--window-size=1200,630 --screenshot=public/og.png`, then quantize to an 8 bit palette so the file stays small. Compare side by side with the old image before replacing it; the owner approves the comparison before the commit.

**Acceptance criteria:**
- [ ] `public/og.png` is 1200 by 630, under 300KB (target under 150KB), same palette and type as before, new headline and subline, no hyphenated compound in the text
- [ ] Route B only: `cards/og.html` is committed with a one line comment giving the render command, and `assets.css` and PNG outputs stay gitignored
- [ ] The owner has approved the side by side before the file is replaced

**Verification:**
- [ ] `file public/og.png` reports `1200 x 630`; `ls -l public/og.png` under 307200 bytes
- [ ] Build succeeds: `npm run build`; `dist/og.png` is the new file
- [ ] Manual check: open the PNG and the old one side by side (git stash or `git show main:public/og.png > /tmp/old-og.png`)

**Dependencies:** Task 9, owner approval

**Files likely touched:** `public/og.png`, `cards/og.html` (Route B), `SPEC-ai-agents.md` (Project Structure amendment, Route B)

**Estimated scope:** S

### Checkpoint D: Hero decision landed

- [ ] Title under 60 characters, H1 and og.png say the same thing
- [ ] After deploy: one LinkedIn and one X share preview of the homepage show the new image and title

### Task 11: Final gates and PR

**Description:** Run every gate from the spec's Testing Strategy on the finished branch, tick the spec's Success Criteria in `tasks/todo.md`, and open the PR to `main`. The PR description links the spec items each commit implements and lists Phase D as done or pending. The owner tests the branch locally with `npm run dev` before merging. After the Cloudflare deploy, verify the live homepage, services page, and `llms.txt`, and run the share previews.

**Acceptance criteria:**
- [ ] Every command in the spec's Copy gates and Structure gates prints the expected result
- [ ] Every line of the spec's Success Criteria is ticked, or marked pending with the reason (Phase D)
- [ ] PR open against `main` from `feat/ai-agents-positioning`, no direct push to `main`

**Verification:**
- [ ] Build succeeds: `npm run build`
- [ ] Copy gates: the three grep commands from the spec print nothing
- [ ] Structure gates: 9, 9, 1, and the title length line from the spec
- [ ] Browser pass on `/` and `/services/` at desktop and 375px, console clean, Cal popup opens from nav, hero, and closing CTA
- [ ] After deploy: live `/`, `/services/`, and `/llms.txt` match `dist`; share previews checked

**Dependencies:** Tasks 1 to 8, plus 9 and 10 if released

**Files likely touched:** `tasks/todo.md`

**Estimated scope:** XS

### Checkpoint E: Complete

- [ ] All acceptance criteria met
- [ ] Owner tested locally and approved
- [ ] PR merged, deploy verified live

## Risks and Mitigations

| Risk | Impact | Mitigation |
|------|--------|------------|
| Teams grid renders three plus one at desktop | Medium | Use `minmax(min(100%,420px),1fr)` as the spec pins; check computed track count at desktop and 375px in Task 3 |
| Owner reads the Engineering or Marketing and sales examples as shipped client work | Medium | The lead sentence frames them as places we usually find the payoff; Checkpoint B invites the owner to skim; spec Open Question 3 stays open until answered |
| og.png rebuilt from the palette does not match the original closely enough | Medium | Side by side comparison with the old PNG, owner approves before commit; fallback is keeping the current H1 (Option B) so image and page agree |
| Phase D held for a decision while the PR is open | Low | PR description lists Phase D as pending; it lands as a follow up commit on the same branch before merge |
| New FAQ strings break the JSON-LD | Low | `JSON.stringify` escapes everything; the validator check in Task 5 confirms |
| Copy gate false positive from the em dash in the frontmatter comment of `index.astro` | Low | Gates run on `dist` HTML, where comments do not ship; the `src/pages` gate only looks for the hyphenated compounds |
| Longer homepage slows the page | Low | Only static text is added, no images or scripts; the section uses the same reveal mechanism as the rest |
| Section order shift breaks an anchor | Low | No id changes; the hero button targets `#process`, which is untouched |

## Parallelization

Single session, sequential. Tasks 2 to 7 are independent and could be split across sessions, but they edit two files on one branch and the whole batch is small, so the merge risk is not worth it.

## Spec amendments to make during the build

- Record the decision gate answers in a Decision Log section of `SPEC-ai-agents.md` (Open Questions 1, 2, 4, 7).
- If Task 10 takes Route B, add `cards/og.html` to the spec's Project Structure and remove `cards/` from the untouched list.
- If the owner cuts the FAQ to eight (Open Question 4), update item 90, Task 5's counts, and the `llms.txt` mirror.

## Open Questions

Carried from the spec, with the default this plan assumes.

1. H1 Option A. Default: yes.
2. Title Option A. Default: yes.
3. Team examples confirmed. Default: as drafted; swap on request.
4. FAQ count nine. Default: nine.
5. A measured client number. Default: none, copy stays qualitative.
6. Dedicated `/ai-agents/` page. Default: no, out of scope.
7. Share image source. Default: Route B, rendered from the repo palette, only after approval.
