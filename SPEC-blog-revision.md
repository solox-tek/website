# Spec: Blog revision, validation advice and first comparison post

Status: bucket R and S implemented and verified. **Bucket T cancelled** on July 30, 2026: it rested on a factual error, described below. Replaced by bucket V.

**Correction, and it invalidates part of this spec.** Every version of this document before this note described Solox Tek as a one person agency. The owner never said that. It was an assumption introduced during the July 30 SEO research, and it propagated unchallenged into two specs, the live validation prompt in n8n, and a finished draft post. The owner confirmed Solox Tek is a team, which is what the live site has said all along on three pages plus `llms.txt`.

What that cost: the entire premise of bucket T, and two drafts written against it (executions 430 and 432). What it did not cost: buckets R and S, which are about advice quality and wiring and hold regardless of headcount.

The lesson is recorded in the Decision Log as entry 7, and a rule was added to the validation prompt forbidding the node from assuming company size at all.

Fourth spec in the series. `SPEC.md` covers the shipped site. `SPEC-blog.md` covers the blog pages, feed, and seed post. `SPEC-blog-writer.md` covers the n8n Blog Writer workflow and its validation step. This one covers two coupled fixes that came out of independently verifying the validation node's first real output. Work items continue from 65.

## Objective

Two fixes that have to land together, because doing either alone makes things worse.

**Fix one, the workflow.** The validation node works and does not fabricate, but two of its recommendations are backwards. Independent verification of execution 430 found that "lead with where you lose" fails both moderators of the only rigorous study on the subject, and that the AI Overview warning points at the wrong risk. Separately, the drafting node never receives the assessment at all: its prompt reads only from `Pick Next Topic` and `Fetch Blog Feed`. So the intelligence is generated, shown to the owner, and thrown away.

Those two facts interact. Wiring the assessment into the drafting node while the advice is still backwards would make posts worse, not better. The advice quality gets fixed first, then the wire.

**Fix two, the post.** The first comparison post is mechanically clean but built on a category the search engine does not recognize. It gets rewritten on the corrected framing.

Success looks like: the assessment reaches the drafting node, its advice is sound enough to follow, and the first comparison post is one the owner can send to a prospect mid sales conversation.

## Assumptions

Surfaced because correcting any of them changes the work.

1. **The verification findings outrank the validation node's advice.** They rest on the Ein-Gar, Shiv and Tormala paper in the Journal of Consumer Research for ordering, Grow and Convert's own client conversion data for structure, the Indexed March 2026 CTR study for query resilience, and Ahrefs data on new domain ranking timelines. The validation node had one search pass; the verification had five agents and 107 checks.
2. **The third category becomes in-house, not one person agency.** Ten distinct search phrasings all collapsed into the same freelancer versus agency results, which means search does not treat "one person agency" as an entity. This changes the post title, the slug, and the backlog row.
3. **This post is not an SEO play and must not be judged as one.** 1.74 percent of pages on a domain under a year old reach the top ten within twelve months, and 72.9 percent of current top ten pages are over three years old. The SERP is held by Upwork, Arc, Lemon.io, Clutch, and Volpis. Value is sales enablement, LLM citation, and direct traffic.
4. **No new facts come from an agent.** The strongest verified recommendation was to build the post on comparable customers, cost, and ROI rather than a pros and cons inventory, because buyers ranked pros and cons lowest at 5 percent against comparable customers at 22 percent and cost at 21 percent. **That requires real client stories and real price ranges, which only the owner has.** This spec therefore scopes the post to what is already public, and records the gap as a blocked item rather than filling it with invented material. See item 74 and Open Questions.
5. **The existing draft is discarded, not edited.** Changing the third category changes the spine, so items 71 through 73 write a new post rather than patching the one from execution 430.

## Cost

No change to the running cost recorded in `SPEC-blog-writer.md`, roughly $0.20 to $0.40 per month. Item 69 adds the assessment to the drafting prompt, which adds about 1,600 characters of input per run, well under a cent. No new searches, no new nodes.

## Tech Stack

Unchanged. Astro 4 static site on Cloudflare Pages, `astro:content` collections, zero new dependencies. n8n workflow `go8KiydmyCph3Qzi` in personal project `lytV17yPbb2nQXcs`, data table `eyXx0dXDBYcu6NpL`, credential `bcJwL6aS8FhcwfCd`, model `claude-sonnet-5`.

## Commands

- Build, which must pass before every commit: `npm run build`
- Dash gate: `grep -rlP '[\x{2014}\x{2013}]' dist/` must return nothing
- Frontmatter check: the zod schema in `src/content/config.ts` enforces title max 70 and description max 160 at build time
- Workflow edits: `update_workflow` with operation objects, then `execute_workflow` with `executionMode: "manual"`, then `get_execution` with `includeData: true`

## Project Structure

```
src/content/blog/senior-freelancer-vs-agency-vs-in-house.md   NEW: the rewritten post
src/content/blog/first-workflow-to-automate.md                unchanged
public/llms.txt                                               MODIFIED: one line for the new post
```

n8n, two nodes edited, none added:

```
Validate Topic          MODIFIED: ordering advice, AIO framing, entity check
Draft Post with Claude  MODIFIED: receives the assessment
Sticky Note validation  MODIFIED: records the advice fix
Blog Topics Backlog     one row edited: topic text, notes, status back to queued
```

## Code Style

Site side unchanged from `SPEC-blog.md`: plain markdown, frontmatter typed by the zod schema, no MDX, prose rendered through the `.px` block. Post body carries no `h1`, because `[slug].astro` renders the title as the page's only `h1`.

n8n side unchanged from `SPEC-blog-writer.md`: operation based updates, no code comments, canvas documentation in sticky notes, expressions referencing upstream nodes explicitly.

The zero dash rule from `SPEC.md` binds every piece of new text, including the validation prompt and the post body.

## Work Items

### R. Validation advice quality

66. Fix the ordering advice in the `Validate Topic` system prompt. The `Angle` line must not recommend leading with weaknesses. Where honest self critique is warranted it goes after the positive case, because the blemishing effect requires negative information to follow positive and to be processed with low effort, and choosing a development vendor is neither.
67. Fix the `AI Overview` line. Trigger rate alone is the wrong signal. The line must also weigh phrasing resilience, since how to choose phrasings retain 63 to 70 percent of clicks and B2B services with local intent show the lowest AI Overview penetration of any category, and it must name the real risk for a new domain: not being among the two to five sources the answer cites at all.
68. Add an entity recognition check to the prompt. Before recommending a category framing, the node must test whether search actually treats the proposed term as a distinct thing, by searching the term and observing whether results collapse into an adjacent established category. This is the check that would have caught "one person agency" on its own.

### S. Wire the assessment into drafting

69. Extend the `Draft Post with Claude` user message to include the assessment via `$("Validate Topic").item.json.merged_response`, labeled as SERP context, with a `??` fallback so a failed validation node cannot break the prompt. Instruct the drafter to follow the `Angle` line, and to treat a `narrow it` verdict as an instruction to write the narrowed version rather than the original topic.
70. Verify by manual execution that the draft visibly reflects the assessment's angle. This is the whole point of the change and it is the one thing a passing build cannot tell us.

### T. Post rewrite, CANCELLED

Items 71 through 74 are cancelled. They specified a post positioning Solox Tek as a one person operation, with sections on bus factor of one, absence of peer review, and no bench. Solox Tek is a team, so that post would have published a false claim about the company and contradicted three pages of live site copy. The two drafts written against it are discarded. Replaced by bucket V.

71. ~~Write `senior-freelancer-vs-agency-vs-in-house.md` with Solox Tek in a redefined senior freelancer slot.~~ Cancelled, false premise.
72. ~~Structure with limits after the positive case.~~ Carried into item 78 unchanged, since the ordering rule was sound and is independent of the premise.
73. ~~Replace the subcontracted overflow mitigation.~~ Cancelled, only existed because of the solo framing.
74. ~~Soften absolute claims about the agency industry.~~ Carried into item 78.

### V. Replacement post

75. Write `src/content/blog/fixed-price-vs-time-and-materials.md`, taking the next topic from the backlog. Chosen because it is headcount neutral, so no assumption about company structure can poison it, and because it maps directly onto the one engagement claim the site already makes publicly: a short paid audit first, then fixed scope and fixed price.
76. Angle, from a live search of the query: the SERP is saturated with agency written posts that all resolve to the same pros and cons table and then hand the decision back to the reader. The unoccupied and honest position is that the choice is really about who absorbs the cost of what nobody knows yet, and that the fix for unpriceable scope is not a different pricing model but removing the unknown before pricing. That is Solox Tek's actual model, so the differentiated angle and the true one are the same thing.
77. Structure, applying the ordering rule from cancelled item 72: what the choice actually is, then when each model is right, then where fixed price genuinely fails, then the audit step that resolves it, then questions to ask, then the CTA. Limits sit in the middle and never in the lead.
78. Keep every Solox Tek claim to what is already public on solox-tek.com. The post makes exactly two: the audit comes before the quote, and the build is then fixed scope and fixed price. No invented prices, no client names, no risk premium percentages, even though search surfaced a commonly repeated figure, because it traces to vendor blogs rather than a primary source.
79. Update `public/llms.txt` with a line for the new post.

### U. Backlog

71. Write `src/content/blog/senior-freelancer-vs-agency-vs-in-house.md`. Three way frame: senior freelancer, development agency, in house hire, with Solox Tek positioned inside a redefined senior freelancer slot. Do not use "one person agency" as a category label anywhere in the post.
72. Structure, in this order: decision criteria first, then the positive case for each option, then honest limits in the middle, then fit guidance, then the Cal.com CTA. Limits belong in the post and not at the top of it.
73. Replace the subcontracted overflow mitigation. It re-creates an agency bench without agency accountability and the reader cannot verify it. Use concrete, checkable commitments instead: escrowed repository and infrastructure access, documented handover, stated response time limits, and a direct answer on what happens if the one person is unavailable.
74. Soften absolute claims about the agency industry. The line "the person who sold you the project is rarely the person who builds it" asserts a fact about every agency. Same class of defect the July 30 review found in the seed post.
75. Update `public/llms.txt` with a line for the new post, per the standing obligation in `SPEC.md`.

### U. Backlog

80. Retire the `one person agency` backlog row. **No action needed and none possible from here:** the n8n MCP surface exposes row insert but no row update or delete, and six pending approvals from testing all resolve to `Mark Topic Skipped` on their 12 hour timeout, so the row retires itself the same evening. Recorded because the absence of a row update tool is a real constraint on any future backlog maintenance.
81. **Open papercut, owner action.** The row for the fixed price topic is still `queued`, and item 75 wrote that post by hand. The next scheduled run will therefore draft a duplicate. The drafting node does receive the published feed with an instruction not to duplicate existing posts, so it will probably reframe rather than repeat, but the row should be set to `drafted` in the n8n data table UI to be certain. Cannot be done from here for the reason in item 80.

## Testing Strategy

No test framework, gates instead.

1. `npm run build` passes with zero errors and zero new warnings.
2. Dash gate over `dist/` returns nothing.
3. Frontmatter validates against the zod schema, which fails the build if title exceeds 70 or description exceeds 160.
4. Body word count lands between 900 and 1300, and the body contains no `h1`.
5. Browser check of the new post at desktop and 375px, console clean, Cal popup opens from the CTA.
6. Every `update_workflow` call returns zero `validationWarnings`.
7. One manual execution after items 66 through 69, confirming the assessment reaches the drafting prompt and the draft follows the `Angle` line.
8. An adversarial read of the finished post against the Never list, specifically hunting invented claims, absolutes about third parties, and any statement the owner could not defend on a call.

## Boundaries

- **Always:** run the build before committing; keep the zero dash rule in every new string including prompts; keep the post free of claims the owner cannot defend; fix the advice before wiring it into drafting; leave the workflow unpublished; verify workflow changes by manual execution.
- **Ask first:** adding any dependency; publishing any client name, price, or metric not already public on solox-tek.com; changing `astro.config.mjs`; publishing the workflow; raising cadence or `maxUses`.
- **Never:** invent client stories, project sizes, price ranges, or ROI figures to satisfy the comparable customers recommendation; wire the assessment into drafting while the ordering advice is still backwards; judge this post on organic ranking; deploy a post the owner has not read in full; reuse the discarded execution 430 draft.

## Success Criteria

1. The `Validate Topic` prompt no longer recommends leading with weaknesses, weighs phrasing resilience alongside trigger rate, and includes the entity recognition check.
2. A manual execution shows the assessment present in the drafting prompt and visibly reflected in the draft's angle.
3. `senior-freelancer-vs-agency-vs-in-house.md` exists, uses the three way frame with in house as the third option, places limits after the positive case, and contains no "one person agency" category label.
4. `npm run build` passes and the dash gate over `dist/` returns nothing.
5. Every claim in the post is either already public on solox-tek.com or a general industry statement the owner would defend on a call.
6. `public/llms.txt` lists the new post.
7. The backlog row reflects the corrected framing and is back to `queued`.
8. The owner has read the post in full before any deploy.

## Decision Log (July 30, 2026)

1. **Advice quality fixed before wiring.** Discovered by finding the wiring gap and the bad advice in the same pass. Connecting them in the wrong order would have shipped worse posts while looking like an improvement.
2. **In house replaces one person agency as the third category.** Ten search phrasings collapsed into the same results, so the term is not an entity search recognizes. In house is the established third leg and needs no new vocabulary taught to the reader.
3. **Limits stay in the post but move out of the lead.** The honesty is well supported for a low credibility brand; the ordering was not. Both facts are kept rather than trading one for the other.
4. **Comparable customers, cost, and ROI deliberately not attempted.** It is the strongest verified recommendation and it needs real data only the owner has. Recorded as blocked rather than satisfied with invented material, because the Never list forbids the alternative.
5. **Execution 430's draft discarded.** Changing the third category changes the spine. Patching would leave the old framing's bones visible.
6. **Post judged on sales enablement, not ranking, and this is written down.** Otherwise it looks like a failure at month six for reasons that were known and accepted at month zero.
7. **An unverified fact about the client propagated through four artifacts before anyone checked it.** "One person agency" entered as convenient shorthand in a research prompt, was never questioned, and ended up in two specs, a live production prompt, and a finished post, while the live site said the opposite on three pages the whole time. It was caught only because writing the post forced a claim about the company into visible copy. Two rules come out of it: any claim about the client that will appear in public copy gets checked against the site before it is written down anywhere, and the validation node is now forbidden from assuming company size at all, since it demonstrated it will guess.
8. **Replacement topic chosen for premise independence, not just for being next in the queue.** Fixed price versus time and materials cannot be poisoned by a wrong assumption about headcount, which is a property worth preferring while trust in the surrounding assumptions is still being rebuilt.

## Open Questions

1. **Owner action, blocking item 76:** clear the four pending Telegram approvals from testing with Skip topic. The 12 hour timeout writes `skipped`, so a later approval would be clobbered by an earlier run timing out.
2. **Blocking the strongest version of item 71:** can the owner supply one real project size, one real price range, or one client story beyond Limo Mont? Buyers rank comparable customers at 22 percent and cost at 21 percent against pros and cons at 5 percent, so this is the difference between a good post and the best available post. Without it the post ships on decision criteria and honest limits only, which is defensible but weaker.
3. **Not in this spec, flagged because verification rated it higher leverage per hour than the post itself:** a Clutch profile with real reviews. Third party reviews are trusted at 78 percent against 32 percent for vendor authored content, so a self authored comparison is discounted by default.
