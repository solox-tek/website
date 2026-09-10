# Todo: Custom AI agents positioning

Branch: feat/ai-agents-positioning. One commit per task, message names the spec item. Details, gates, and risks in tasks/plan.md; copy in SPEC-ai-agents.md (items 82 to 96).
Status: DONE (September 10, 2026). Phases A to C shipped; Phase D skipped by owner decision (H1 and title kept, og.png unchanged); merged to main by fast forward and pushed on owner instruction, no PR.

## Phase A: Setup
- [x] Task 1: Branch and baseline
  - Acceptance: branch checked out; build passes; baseline recorded below
  - Verify: npm run build; git branch --show-current
  - Files: tasks/todo.md
  - Baseline: title length 62 characters (expect 62); Question count 6 (expect 6); details count 6 (expect 6); copy gates on current dist: all four empty
- [x] Checkpoint A: build passes on the branch, baseline filled in

## Phase B: Homepage body
- [x] Task 2: What we do section carries the agents message (item 86)
  - Acceptance: new H2, two card titles and paragraphs, link text, all verbatim from the spec; markup and hrefs unchanged
  - Verify: npm run build; grep -c 'Custom AI agents with integrations' dist/index.html = 1; copy gates empty; hover and link still work
  - Files: src/pages/index.astro
- [x] Task 3: Teams section (item 87)
  - Acceptance: one id="teams" between #why and #work with four cards; two by two at desktop, one column at 375px, no horizontal scroll; reveal works without script changes
  - Verify: npm run build; grep -c 'id="teams"' dist/index.html = 1; computed grid tracks 2 then 1 via resize_window; scrollWidth equals innerWidth at 375px
  - Files: src/pages/index.astro
- [x] Task 4: Supporting copy in problem, why us, and what you get (items 85, 88, 89)
  - Acceptance: problem paragraph names the teams in its first sentence (shortened on owner feedback, September 10, 2026); why us paragraph replaced, colon list gone; six rows in what you get with the divider moved
  - Verify: npm run build; grep -c 'a faster version of the old one' dist/index.html = 1; grep -c 'software team:' dist/index.html = 0; preview at both widths
  - Files: src/pages/index.astro
- [x] Task 5: FAQ grows to nine entries (item 90)
  - Acceptance: faqs array edited only; nine details and nine Question objects in the spec's order; new answers pass the copy rules
  - Verify: npm run build; counts 9 and 9; order printed by the node one liner in plan.md; validator.schema.org clean; open and close each new item
  - Files: src/pages/index.astro
- [x] Checkpoint B: build clean; copy gates empty on dist; homepage body checked at desktop and 375px with console clean and Cal popup working; four commits; owner skim recommended

## Phase C: Decision free remainder
- [x] Task 6: Hero subheadline, meta description, Organization description (items 84, 82 in part)
  - Acceptance: hero paragraph verbatim, chips and buttons unchanged; meta description is the 156 character string; Organization description updated; both keep "AI automation agency"
  - Verify: npm run build; grep the meta tag and check length 156; copy gates empty; hero at 375px
  - Files: src/pages/index.astro
- [x] Task 7: Services page (items 92, 93, 94)
  - Acceptance: featured card "AI Agents and Automation" with tagline and four points; hero subline; 152 character meta description; ItemList first name follows
  - Verify: npm run build; grep -c 'AI Agents and Automation' dist/services/index.html >= 2; copy gates empty; /services/ at both widths
  - Files: src/pages/services.astro
- [x] Task 8: llms.txt (item 95)
  - Acceptance: spec version in place; teams section present; nine FAQ short forms; no dash or glyph
  - Verify: dash grep on public/llms.txt empty; mirror check count 9; npm run build; grep -c 'Who we build agents for' dist/llms.txt = 1
  - Files: public/llms.txt
  - Depends on: Tasks 3, 5, 7
- [x] Checkpoint C: build clean; all copy gates empty on dist and llms.txt; JSON-LD on / and /services/ parses with FAQPage 9 and ItemList first item renamed (local check, online validator not run); browser pass both pages both widths, console clean, Cal modal opens; seven task commits

## Decision gate (owner, one line each)
- [x] 1. H1: keep the current H1 (owner, September 10, 2026)
- [x] 2. Title: keep the current title (owner, September 10, 2026)
- [x] 3. Share image: not needed, H1 unchanged
- Rule: Option A for the H1 requires the new og.png; without it the H1 stays. No answer before Task 11 means the PR opens with Phase D pending.

## Phase D: Decision gated hero (Option A)
- [x] Task 9: SKIPPED, owner kept the current H1 and title
  - Acceptance: H1 "Custom AI agents that / survive production." with existing span styling; title is the 53 character Option A string; "AI automation agency" still in meta, JSON-LD, and Why us
  - Verify: npm run build; title grep and length 53; grep -c 'AI automation agency' dist/index.html >= 3; hero at both widths
  - Files: src/pages/index.astro
  - Depends on: decision gate answer 1 and 2
- [x] Task 10: SKIPPED, not needed without an H1 change
  - Acceptance: public/og.png 1200 by 630, under 300KB, same palette and type, new headline and subline; Route B commits cards/og.html with the render command in a comment; owner approved the side by side
  - Verify: file public/og.png shows 1200 x 630; size under 307200 bytes; npm run build; visual comparison with git show main:public/og.png
  - Files: public/og.png, cards/og.html (Route B), SPEC-ai-agents.md (Project Structure amendment)
  - Depends on: Task 9, owner approval
- [x] Checkpoint D: not applicable, hero unchanged

## Phase E: Release
- [x] Task 11: Final gates green; owner approved in the preview; pushed to main directly on owner instruction, no PR (September 10, 2026)
  - Acceptance: every copy and structure gate from the spec passes; spec Success Criteria ticked below; PR open from the branch, nothing pushed to main directly
  - Verify: npm run build; three copy gates empty; structure gates 9, 9, 1, title line; browser pass / and /services/ at both widths with Cal popup; live check and share previews after deploy
  - Files: tasks/todo.md
- [x] Checkpoint E: owner approved in the preview, main pushed, live deploy checked in the session

## Spec success criteria (tick at Task 11)
- [x] "custom AI agents" appears in the hero (H1 or subheadline) and in the title or meta description
- [x] engineering, marketing, sales, and leadership each appear in visible homepage copy
- [x] nine FAQ entries, nine identical JSON-LD questions
- [x] services featured card and ItemList both say "AI Agents and Automation"
- [x] llms.txt names custom AI agents, lists four teams, mirrors nine FAQ questions
- [x] "AI automation agency" still in homepage meta description, Organization JSON-LD, and Why us
- [x] the only percentage on the homepage is the existing 20%+ observation
- [x] all copy gates empty; build passes; browser pass at desktop and 375px on both pages
- [x] Open Questions 1 to 4 answered (keep H1, keep title, examples as drafted, nine FAQ) and the branch approved as built on September 10, 2026
