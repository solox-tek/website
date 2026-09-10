# Spec: Custom AI agents positioning

Status: draft, awaiting owner approval. Nothing here is implemented. Companion to `SPEC.md` (Phase 1, shipped), which holds the copy rules every item below inherits, and to the three blog specs. None of those files is modified by this one. Work items continue the shared numbering from 82 so cross references stay unique across all five specs.

Written September 10, 2026 from the owner's brief, given in Serbian and paraphrased here. We build agents for companies. We improve how their work runs, whether that is software development or marketing and sales, and even at the leadership level. We raise productivity. We build custom agents with integrations.

## Objective

Make the site say, in the first screen and in every place a machine reads it, that Solox Tek builds custom AI agents for companies, wires them into the tools the company already uses, and improves the process around the agent, for any team including leadership. Today the live site sells "automation". The word agent appears once on the homepage, inside the Limo Mont case study, and once on the services page as a bullet. A visitor who wants an agent built has to infer that this is what an automation agency does.

### Who this is for

- Cold visitors deciding whether to book the free discovery call. Founders, operations leads, heads of sales or marketing, engineering leads, and executives at small and mid sized companies. They arrive from search, LinkedIn, or a shared link.
- AI answer engines and crawlers that read `llms.txt`, the meta tags, and the JSON-LD. When someone asks a model who builds custom AI agents for a company, the site must answer that question about itself.
- The owner, who sends the homepage to prospects mid conversation and needs it to match what they say on the call.

### What success looks like

- Someone who reads only the hero knows Solox Tek builds custom AI agents with integrations and improves the process around them.
- Someone who scrolls one more screen finds their own team named, whether engineering, marketing and sales, operations, or leadership, with a concrete example of what an agent does for that team.
- Nothing new states or implies a number the company cannot back. Productivity is described, not quantified, until the owner supplies a measured result.
- The "AI automation agency" term that `SPEC.md` placed in the meta description, the Organization JSON-LD, and the Why us paragraph is still there, so nothing already ranking is thrown away.
- The Limo Mont case study reads as proof of the new claims without a word of it changing.

### Traceability, owner's brief to work items

| Owner's point | Where it lands |
| --- | --- |
| We build agents for companies | 82, 83, 84, 86, 88, 90, 92, 93, 95 |
| We improve their work process | 84, 86, 89, 90, 93, 95 |
| Software development, marketing and sales, any function | 84, 85, 87, 90, 95 |
| Even the leadership level | 84, 85, 87, 90, 95 |
| We raise productivity | 84, 86, 89, 90 |
| Custom agents with integrations | 82, 84, 86, 90, 93, 95 |

## Positioning decisions

What stays. The "survives production" brand line. "You own what we build." The engagement model, free discovery call first, then a paid audit and a fixed price. The Limo Mont case study, word for word. The "AI automation agency" term in the meta description, the Organization JSON-LD, and the Why us paragraph.

What changes. The agent becomes the headline noun and automation becomes the work around it. Process improvement, which the owner sells but the site never names, becomes explicit. Teams get named. Integrations are described as the thing that makes an agent useful rather than as a feature bullet.

Vocabulary, used consistently.

- "custom AI agents", every time. Not "AI agent solutions", not "agentic", not "autonomous agents".
- "wired into the tools you already use" for integrations. Concrete tool categories when there is room. CRM, email, documents, databases, internal APIs, chat.
- "the process around it" for process improvement.
- "leadership team" or "executives" for the owner's "C level". The site never publishes hyphenated compounds, and the hyphenated form of that phrase is one, so it does not appear anywhere.
- "more done with the same people" for productivity. No percentage, no multiplier.
- Banned words in this work: agentic, transform, supercharge, unlock, revolutionize, copilot, 10x, seamless, cutting edge.

## Tech Stack

Unchanged. Astro 4 static output on Cloudflare Pages, inline styles plus small `is:global` blocks, self hosted Sora and Manrope, Cal.com popup for booking. No dependency is added by this spec.

## Commands

- Dev server: `npm run dev` (port 4321; the in app browser preview in `.claude/launch.json` uses 4325)
- Build: `npm run build` (must pass before every commit)
- Preview built output: `npm run preview`
- Copy gates run on the build output and must print nothing. The full set is in Testing Strategy.

## Project Structure

Files this spec touches, nothing else.

```
src/pages/index.astro          Hero, problem paragraph, What we do cards, new Teams section, Why us paragraph, What you get list, FAQ array, title and description, Organization JSON-LD description
src/pages/services.astro       Hero subline, featured card data, meta description (ItemList JSON-LD updates itself from the data)
public/llms.txt                Summary, page lines, new section on teams, FAQ mirror
public/og.png                  Only if the H1 changes (item 96, ask first)
tasks/plan.md, tasks/todo.md   Rewritten by the Plan phase for this spec; the Phase 1 versions are complete and live on in git history
```

Not touched: `src/pages/paid-media.astro`, `src/components/Nav.astro`, `src/components/Footer.astro`, `src/layouts/Layout.astro`, everything under `src/content/blog/`, `astro.config.mjs`, `cards/`.

## Code Style

Match the existing idiom exactly. Semantic tag, inline style attribute, `data-reveal` on anything that should animate in, hover rules in the page's `is:global` block keyed by short class names. The new Teams cards copy the What we do card markup with two differences. They are `div` elements, not links, because there is no team specific page to land on, and they carry no hover class for the same reason. The grid uses `min(100%,420px)` so four cards sit two by two on desktop and stack to one column on a 375px screen without horizontal overflow.

```astro
<div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(min(100%,420px),1fr));gap:20px;">
  <div data-reveal style="border-radius:24px;border:1px solid rgba(150,180,215,0.12);background:linear-gradient(120deg,rgba(20,42,68,0.45),rgba(10,22,38,0.2));padding:clamp(30px,3.5vw,44px);">
    <div style="display:flex;gap:5px;margin-bottom:24px;">
      <span style="width:11px;height:11px;border-radius:3px;background:var(--sx-accent,#36A9E6);"></span>
      <span style="width:11px;height:11px;border-radius:3px;background:rgba(143,224,255,0.45);"></span>
      <span style="width:11px;height:11px;border-radius:3px;background:rgba(143,224,255,0.2);"></span>
    </div>
    <h3 style="font-family:'Sora Variable',sans-serif;font-weight:600;font-size:clamp(21px,2.1vw,28px);letter-spacing:-0.01em;margin:0 0 14px;color:#F5FAFE;">Engineering</h3>
    <p style="font-family:'Manrope Variable',sans-serif;font-size:clamp(15.5px,1.3vw,18px);line-height:1.68;color:#A6BCD6;margin:0;">Agents that triage incoming bugs, ...</p>
  </div>
</div>
```

FAQ convention, unchanged from Phase 1. The `faqs` array in the frontmatter of `index.astro` is the single source. The accordion renders it and the FAQPage JSON-LD maps it, so visible text and structured data cannot drift.

Copy rules, inherited from `SPEC.md` and binding on every string below. No em dashes, no en dashes, no hyphen used as an aside, no hyphenated compounds (reword instead). No sentence ending in a colon followed by comma separated items. No arrow glyphs or other ornamental markers after link text. US English. Sentence case headings. Hero and section headings end with a period, with the second half of the line inside the bold span. No invented numbers, clients, or credentials. Never state or imply team size.

## Work Items

The wording under each item is final draft copy. The owner approves or edits it in place. Every business or capability claim is marked where it needs a yes.

### A. Homepage hero and metadata (`src/pages/index.astro`)

82. Title, meta description, Organization JSON-LD description.

    Title, Option A (recommended, 53 characters): `Solox Tek · Custom AI agents that survive production.`
    Title, Option B: keep the current title unchanged. Both phrases do not fit in one title under 60 characters, so the choice is which one leads in search results. Option A puts agents in the title and leaves "AI automation agency" to the description, JSON-LD, and body, where it also lives today. See Open Question 2.

    Meta description (156 characters): `Senior AI automation agency. We build custom AI agents for companies, wire them into the tools you use, and fix the process around them. You own the result.`

    Organization JSON-LD `description`: `Solox Tek is a senior AI automation agency that builds custom AI agents for companies, wires them into the tools they already use, and improves the process around them. Reliable, secure, owned by the client, with over a decade in production.`

83. H1. Option A (recommended): `Custom AI agents that<br><span>survive production.</span>` with the existing span styling. Option B: leave the H1 as it is and let the subheadline carry the agents message. Option A triggers item 96. See Open Question 1.

84. Hero subheadline, replaces the current paragraph in full:

    `A senior engineering team that builds custom AI agents for companies and wires them into the tools you already use. We fix the process around the agent too, so engineering, marketing, sales, and leadership get more done with the same people. Reliable, secure, and yours.`

    The two trust chips ("10+ years in production", "You own what we build") and both buttons stay as they are.

### B. Homepage body

85. Problem section paragraph. Keep the current two sentences and append:

    `And it is not only the back office. Engineers lose their week to triage and status updates, marketing to reporting, sales to keeping the CRM honest, and the leadership team to chasing numbers nobody has in one place.`

86. What we do section (`#what`). Retitle, replace both card texts, fix the link line. Markup and hover classes unchanged; the cards keep linking to `/services`.

    H2: `Custom AI agents and automation that <span>hold up in production.</span>`

    Card 1, h3: `Custom AI agents with integrations`
    Card 1, p: `Agents that read, decide, and act inside the tools you already use. CRM, email, documents, databases, internal APIs, and the chat tool your people live in. You set the rules, a person approves the steps that matter, and the agent does the rest.`

    Card 2, h3: `Process improvement and automation`
    Card 2, p: `We map the process before we automate it and remove the steps that only exist because nobody questioned them. What remains gets automated, wired into your stack, and monitored, so your team gets more done with the same people and the agent runs inside a process that makes sense.`

    Line under the grid: `Built like real software. Owned end to end, and made to scale.` followed by the link text `See all AI agent and automation services` pointing to `/services`.

    Owner confirms: "a person approves the steps that matter" describes how agents are built for clients, meaning an approval step for consequential actions.

87. New Teams section, `id="teams"`, inserted between `#why` and `#work` so the case study follows it as proof. Same section padding and header treatment as `#what`. One lead sentence under the H2, then four cards per the Code Style snippet.

    H2: `Any team, <span>one bottleneck at a time.</span>`
    Lead: `The first agent goes where the payoff is biggest. These are the places we usually find it.`

    Card, h3 `Engineering`: `Agents that triage incoming bugs, draft the first pass of a review, write release notes from what actually merged, and keep the tickets in sync with what shipped. Your engineers spend the week on engineering.`

    Card, h3 `Marketing and sales`: `Agents that qualify and enrich inbound leads, draft the follow up in your voice, keep the CRM honest without anyone typing into it, and turn campaign data into a report someone will actually read.`

    Card, h3 `Operations`: `Agents that read the invoice, the order, or the message from the field and act on it inside your systems. Stock updates itself, approvals that used to wait in an inbox run on their own, and a person is asked only when a case is unusual.`

    Card, h3 `Leadership`: `Agents that answer the question you would otherwise ask three people, straight from your own data. Which jobs made money last quarter, what is stuck and why, what changed since Monday. A briefing instead of a hunt through dashboards.`

    Owner confirms every example. The Operations and Leadership cards describe Limo Mont work that is live. The Engineering and Marketing and sales cards describe what Solox Tek offers to build; if any example is not something the team wants to sell, it is swapped, not softened. See Open Question 3.

88. Why us paragraph. One sentence changes, and the colon list it carried goes with it:

    `Most AI automation out there is held together with duct tape and falls apart under load. We're a senior AI automation agency that builds agents the way a software team builds software, with real error handling, monitoring, and testing before anything touches your business. Everything we ship is documented, maintainable, and fully yours.`

    The three numbered points (Reliability, Security, You own the code) stay.

89. What you get list. Item one becomes `Agents and workflows that run reliably`. A sixth item is added at the end: `A process that makes sense, not just a faster version of the old one`. The bottom border moves from the fifth item to the sixth so the last row still closes the list the way it does now. The other four items are unchanged.

90. FAQ. Edit one answer and add three questions to the `faqs` array. Final order of the nine entries, with new or changed ones marked:

    1. (changed answer) `What does an AI automation agency do?` `An AI automation agency connects your tools, automates repetitive processes, and adds AI where it removes real work. At Solox Tek that usually means a custom AI agent that reads, decides, and acts inside your systems. We build it, integrate it, and run it as engineers, and you own it.`
    2. (new) `What is a custom AI agent, and how is it different from a chatbot?` `A chatbot answers questions. An agent does work. It reads what comes in, decides against rules you set, acts inside your systems, and asks a person when a case is unusual. Custom means it is built around your process and your tools, not a generic assistant with your logo on it.`
    3. (new) `Which teams do you build agents for?` `Any team with a repeatable process and a bottleneck. We have built for operations and the back office, and we build for engineering, marketing, sales, and leadership teams as well. The first agent goes wherever the payoff is biggest, and the free discovery call is where we find that.`
    4. `How much does an AI automation project cost?` unchanged
    5. `How long until something is live?` unchanged
    6. `Is our data safe if AI touches it?` unchanged
    7. (new) `Do you improve the process, or only automate what we already do?` `Both, and the process comes first. Automating a broken process gives you a faster broken process. We map how the work actually flows, cut the steps that exist only out of habit, and automate what remains. That is usually where the productivity gain comes from.`
    8. `Do we need our own developers to maintain it?` unchanged
    9. `What actually happens on the discovery call?` unchanged

    The FAQPage JSON-LD follows the array and needs no separate edit. See Open Question 4 on the count.

91. Closing CTA (`#contact`) is unchanged. "Let's find one process worth automating." still describes the call correctly and the owner's brief did not ask to move the conversion language.

### C. Services hub (`src/pages/services.astro`)

92. Hero subline: `Custom AI agents and automation are our core. Around them we bring the full engineering stack to ship and operate real systems, plus paid media to grow them.`

93. Featured card data in the `engineering` array:
    - `name`: `AI Agents and Automation`
    - `tagline`: `Custom AI agents wired into your tools, plus the automation and process work around them. Built to survive production, owned by you.`
    - `points`: `Custom AI agents with integrations`, `Process mapping and workflow automation`, `Systems and API integration`, `Reliability, monitoring, and approval steps built in`

    The ItemList JSON-LD on the page is generated from `name` and `tagline`, so it updates itself. The "See how we work" link on the card stays.

94. Meta description (152 characters): `AI agents, automation, product engineering, DevOps, and Web3, plus paid media. A senior engineering team that ships and runs real systems in production.` The title stays `Services · Solox Tek`.

### D. Machine readable (`public/llms.txt`)

95. Replace the file with the version below. The blog post lines are carried over unchanged and new posts keep being appended there.

```
# Solox Tek

> Solox Tek is a senior AI automation agency that builds custom AI agents for companies, wires them into the tools they already use, and improves the process around them. Reliable, secure, owned by the client, with over a decade in production. Alongside agents and automation we offer product engineering, DevOps, Web3 development, and paid media management. Booking a free discovery call is the primary way to start.

## Pages

- [Home](https://solox-tek.com/): Custom AI agents and automation, the teams we build for (engineering, marketing and sales, operations, leadership), how an engagement runs (free discovery call, then a paid audit with a fixed price plan), and answers to common questions about agents, cost, timelines, data safety, and code ownership.
- [Services](https://solox-tek.com/services/): The full service catalog. AI agents and automation, product engineering, DevOps and infrastructure, Web3, and paid media.
- [Paid Media](https://solox-tek.com/paid-media/): Performance marketing on a transparent monthly retainer, from 1,300 to 3,300 EUR per month by ad spend tier, month to month, cancel anytime. Meta certified, covering Meta, Google, and TikTok.
- [Blog](https://solox-tek.com/blog/): Practical writing on AI automation, workflows, and engineering.

## Who we build agents for

- Engineering teams get agents that triage incoming bugs, draft the first pass of a review, write release notes from merged work, and keep tickets in sync with what shipped.
- Marketing and sales teams get agents that qualify and enrich leads, draft follow ups, keep the CRM current without manual entry, and turn campaign data into readable reports.
- Operations teams get agents that read invoices, orders, and messages from the field and act on them inside existing systems, with a person asked only when a case is unusual.
- Leadership teams get agents that answer questions straight from company data, such as which jobs made money, what is stuck, and what changed this week.

## Blog posts

- [How to pick the first workflow to automate](https://solox-tek.com/blog/first-workflow-to-automate/): A practical filter for choosing your first automation project. Where to look, what to skip, and why the boring workflow usually wins.
- [Fixed price vs time and materials for a small software build](https://solox-tek.com/blog/fixed-price-vs-time-and-materials/): Both models are fine. The real question is who carries the risk of what nobody knows yet, and why a short paid audit before pricing removes it.
- [How a construction company automated its warehouse stock tracking](https://solox-tek.com/blog/warehouse-stock-tracking-automation/): Tradesmen at Limo Mont send a message when they take something from the warehouse. Stock updates itself, and low items trigger a reorder email.
- [Profitable overall, blind on every individual job](https://solox-tek.com/blog/per-project-profitability/): Limo Mont priced by instinct, and it worked. Now the invoice, the material, and the hours meet in one place, and every job has a number.

## Frequently asked questions

- What does an AI automation agency do? We connect your tools, automate repetitive processes, and add AI where it removes real work, usually as a custom AI agent that reads, decides, and acts inside the client's systems. Everything we build is owned by the client.
- What is a custom AI agent, and how is it different from a chatbot? A chatbot answers questions. An agent does work inside your systems, follows rules you set, and asks a person when a case is unusual. Custom means it is built around your process and your tools.
- Which teams do you build agents for? Any team with a repeatable process and a bottleneck. Operations and the back office, engineering, marketing, sales, and leadership.
- How much does an AI automation project cost? Every build is fixed scope and fixed price, set after a short paid audit. The free discovery call comes first.
- How long until something is live? A first workflow is usually in production within a few weeks.
- Is client data safe? Data stays in the client's accounts and a model receives only the minimum it needs.
- Do you improve the process or only automate it? Both, and the process comes first. We map how the work flows, cut the steps that exist out of habit, and automate what remains.
- Who maintains what is built? Solox Tek monitors and supports its builds, and hands over clean documented code.
- What happens on the discovery call? A free 30 minute call to map your workflows and pick the process with the biggest payoff. If automation is not the right fix yet, Solox Tek says so.

## Contact

- [Book a free discovery call](https://cal.com/solox-tek)
- [Email](mailto:contact@solox-tek.com)
```

### E. Conditional

96. Share image, only if Option A is chosen for the H1 (item 83). `public/og.png` reads "AI automation that survives production." with a subline that says "Production-grade automation you own. Reliable, secure, built to scale." Once the page says agents, every LinkedIn and X preview would contradict the page it links to, and the subline carries a hyphenated compound the site no longer allows. Regenerate at 1200 by 630, under 300KB, same layout and palette, headline `Custom AI agents that survive production.` and subline `Custom AI agents you own. Reliable, secure, built to scale.` Ask first, since it is a design asset, and the source file for the current image is not in the repo (Open Question 7).

## Testing Strategy

No test framework, as in `SPEC.md`. Gates instead, every one of them run before the PR is opened.

Build gate.

```bash
npm run build
```

Copy gates on the build output and the machine readable file. Every command must print nothing.

```bash
grep -rn -e '—' -e '–' dist --include='*.html'; grep -n -e '—' -e '–' public/llms.txt
grep -rn -e '→' -e '↗' -e '➜' -e '⟶' -e '›' dist --include='*.html'
grep -rni -e 'c-level' -e 'c-suite' -e 'agentic' -e 'production-grade' src/pages public/llms.txt
```

Structure gates.

```bash
grep -o '"@type":"Question"' dist/index.html | wc -l     # 9
grep -c '<details' dist/index.html                       # 9
grep -c 'id="teams"' dist/index.html                     # 1
grep -o '<title>[^<]*</title>' dist/index.html           # under 60 characters if Option A
```

Browser pass, desktop and 375px, on `/` and `/services/`. The Teams grid renders two by two on desktop and one column on mobile with no horizontal scroll. The reveal animation fires on the new section (the page script observes every `data-reveal` element at load, so no script change is expected; confirm it). All nine FAQ items open and close. The Cal popup opens from the nav, the hero, and the closing CTA. Console clean.

Structured data. Paste the built `dist/index.html` into the schema.org validator. FAQPage with nine questions whose text matches the visible accordion, Organization with the new description, no errors. On `/services/` the ItemList's first item reads "AI Agents and Automation".

Mirror check. Every FAQ question in `index.astro` has a short form in `llms.txt`, and the four team lines in `llms.txt` match the four cards in meaning.

After deploy. Open the live homepage and services page, run one LinkedIn and one X share preview. If item 96 shipped, the preview shows the new headline.

## Boundaries

- Always: run the build before every commit; apply every copy rule in the Code Style section to every string, including alt text and JSON-LD; keep the `faqs` array as the single source for the accordion and the FAQPage markup; keep "AI automation agency" in the meta description, the Organization JSON-LD, and the Why us paragraph; keep productivity language qualitative; get the owner's yes on every capability example before merge; preserve the visual language, colors, type, and inline style idiom; work on a feature branch (`feat/ai-agents-positioning`) and open a PR after the owner has tested locally, the way Phase 1 and the blog shipped.
- Ask first: adding a page or route; touching the nav or footer; regenerating `og.png` (item 96); changing any wording about price, the paid audit, or the free call; naming a client, tool vendor, or partner beyond Limo Mont; adding a dependency; editing `astro.config.mjs`; pushing directly to main; editing `paid-media.astro`, the blog, or `Layout.astro`.
- Never: invent metrics, percentages, hours saved, client names, testimonials, logos, or certifications; state or imply how many people work at Solox Tek; publish the hyphenated form of "C level" or the word "agentic"; introduce a dash or an arrow glyph; remove the email fallback or the `data-cal-link` attributes from any CTA; commit secrets.

## Success Criteria

- The built homepage contains the exact phrase "custom AI agents" in the hero (H1 or subheadline) and in the title or meta description.
- The words engineering, marketing, sales, and leadership each appear in visible homepage copy, in the Teams section and the hero subheadline.
- The homepage has nine FAQ entries and its FAQPage JSON-LD lists nine questions with identical text.
- The services featured card is named "AI Agents and Automation" and its ItemList JSON-LD says the same.
- `llms.txt` names custom AI agents, lists the four teams, and mirrors all nine FAQ questions.
- "AI automation agency" still appears in the homepage meta description, Organization JSON-LD, and the Why us paragraph.
- The only percentage on the homepage is the existing "20%+" audit observation; no new number appears anywhere in this spec's copy.
- All copy gates print nothing; the build passes; both pages pass the browser pass at desktop and 375px.
- The owner has answered Open Questions 1 through 4 and confirmed every capability example in items 86, 87, and 90 before the PR is opened.

## Open Questions

1. H1. Option A `Custom AI agents that survive production.` (recommended, it is what the brief asks the site to say first) or Option B, keep the current H1. Option A also means item 96.
2. Title tag. Option A `Solox Tek · Custom AI agents that survive production.` (recommended) or keep the current title. Only one phrase fits under 60 characters.
3. Team examples in item 87. Confirm each, or name the ones to swap. The Engineering and Marketing and sales examples describe what the team offers to build, not shipped client work; if that framing is wrong, say which are real.
4. FAQ count. Nine entries as drafted, or eight. If cutting one, cut "Which teams do you build agents for?", because the Teams section already answers it on the page and `llms.txt` keeps the short form.
5. A measured result. Is there one real number from Limo Mont or any client (hours saved per week, response time, error rate)? If yes it goes in the case study strip and nowhere else. If no, everything stays qualitative, which is the standing rule.
6. Dedicated page. Recommended no for now. A `/ai-agents/` landing page only earns its keep if the owner plans to send LinkedIn or paid traffic to one URL about agents. It would be a separate spec.
7. Share image source. Is the design file for `og.png` available? If not, item 96 is rebuilt from the palette and type in `cards/base.css`.

## Out of Scope

A blog post about custom agents (the blog workflow and its backlog handle that separately). LinkedIn and X posts announcing the change (manual, per the social publishing playbook). Any change to the paid media page, pricing, the engagement model, the nav, analytics, or dependencies. A dedicated agents landing page (Open Question 6).

## Assumptions

Stated so they can be corrected before anything is built.

1. "Agents for companies" means custom agents built and delivered as a service, running in the client's own tools and accounts. Not a hosted product Solox Tek sells per seat.
2. This is an addition to the current positioning, so "survives production", ownership, and the fixed price after a paid audit stay as they are.
3. Operations is named as a fourth team next to the three in the brief (engineering, marketing and sales, leadership), because the live case study is operations work and it grounds the claims.
4. "C level" is published as "leadership" or "executives" because of the site's rule against hyphenated compounds.
5. All changes live on existing pages. No new route.
6. Productivity is described without numbers until the owner supplies a measured one.
7. This spec is saved as `SPEC-ai-agents.md` rather than replacing `SPEC.md`, because `SPEC.md` holds the copy rules that `cards/README.md`, `cards/POSTED.md`, the blog specs, and the n8n prompt point at.
