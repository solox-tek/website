# Spec: Solox Tek Blog

Status: approved scope, implementation in progress. Companion to `SPEC.md` (Phase 1, shipped). That file is not modified by this one. Work items here continue its numbering from 41 so cross references stay unique across both files.

Scope change, July 30, 2026: the original draft of this spec included an n8n workflow distributing each post to LinkedIn and X with a Telegram approval gate. The owner cut that: distribution to LinkedIn and X is manual, and the owner is building their own n8n workflow separately in another session. This spec now covers only the website side. The machine readable feed (bucket L) stays, because it is the clean interface for any current or future n8n workflow and costs zero dependencies.

## Objective

Give Solox Tek a blog on solox-tek.com as an SEO and credibility surface for the single conversion action `SPEC.md` already defines: booking a free discovery call via Cal.com. Every post ends in that CTA.

Authoring happens in the repo: Claude Code drafts a post as markdown, the owner edits and merges it, Cloudflare Pages deploys it. Authoring is a git workflow. Distribution of each post to LinkedIn and X is done manually by the owner, from the published post.

## Assumptions

1. **The blog lives on solox-tek.com, not on the portfolio.** The portfolio repo has no blog specced and its spec forbids a CMS. This spec touches only this repo.
2. **Authoring is a Claude Code plus git workflow.** Nothing external ever writes to the repo.
3. **Posts are plain markdown, not MDX.** Astro 4 content collections are built into `astro:content` and need zero new dependencies. `@astrojs/mdx` and `@astrojs/rss` would each be new dependencies, and adding a dependency is Ask first in `SPEC.md`. This spec avoids both.
4. **Text only.** No generated images, no OG image per post. The site's existing `/og.png` is reused for every post.
5. **Cadence is set by the SEO research summarized in the Cadence section below**, not by tooling capacity. The bottleneck is owner review time, and the research says quality and query choice beat frequency.

## Tech Stack

No new dependencies. Current stack unchanged:

- Astro 4 (static output, no framework runtime), deployed on Cloudflare Pages
- `@astrojs/sitemap`, `@fontsource-variable/sora`, `@fontsource-variable/manrope`
- Astro content collections via built in `astro:content` (zero new packages)
- Static endpoint for the machine readable feed (zero new packages)

## Commands

Unchanged from `SPEC.md`:

- Dev server: `npm run dev` (port 4321, or the `astro-dev` launch config)
- Build: `npm run build` (must pass before every commit)
- Preview built output: `npm run preview`

New verification commands introduced by this spec:

- Dash gate on rendered blog output: `grep -rlP '[\x{2014}\x{2013}]' dist/blog/` must return nothing
- Feed sanity: `npx astro build && cat dist/blog/feed.json | python3 -m json.tool`

## Project Structure

```
src/content/blog/            NEW: one markdown file per post, filename is the slug
src/content/config.ts        NEW: zod schema for the blog collection
src/pages/blog/index.astro   NEW: post index at /blog/
src/pages/blog/[slug].astro  NEW: post page at /blog/<slug>/
src/pages/blog/feed.json.ts  NEW: static JSON feed for machine consumers (n8n, future tooling)
src/layouts/Layout.astro      MODIFIED: optional article metadata props
src/components/Nav.astro      MODIFIED: Blog link
src/components/Footer.astro   MODIFIED: Blog link
public/llms.txt               MODIFIED: one line per post, per existing obligation
```

## Code Style

Match the existing idiom: semantic tag, inline style attribute, hover rules and media queries in `is:global` blocks keyed by short class names.

**One necessary exception, and it is the only styling deviation in this spec.** Markdown renders to bare `h2`, `p`, `ul`, `li`, `pre`, `code`, `blockquote`, `a` tags that cannot carry inline style attributes, and this repo has no base element rules for any of them. Rendered post bodies therefore need a real CSS block. It goes in a single `is:global` block keyed by one short class name `.px`, in the same escape hatch the existing `.hx0` through `.hx5`, `.card`, `.tier`, `.faq` rules already use. Every value in it comes from the existing palette and type scale. No new colors, no new fonts, no stylesheet file, no framework.

Content collection schema follows the existing content as data convention: copy lives in typed frontmatter and is read once, then mirrored into both the rendered DOM and the JSON-LD from the same source, exactly as `index.astro` already does for `faqs`.

Copy rules from `SPEC.md` apply unchanged and bind post bodies: no em dashes, no en dashes, no hyphens used as asides in visible text. US English. This is the rule most likely to be violated by generated text, so the dash grep gate over `dist/` is mandatory before every commit that touches content.

## Work Items

### J. Blog foundation

41. Create `src/content/config.ts` defining a `blog` collection with a zod schema: `title` (string, max 70 for SERP), `description` (string, max 160), `publishDate` (date), `updatedDate` (date, optional), `tags` (array of string), `draft` (boolean, default true), `author` (string, default "Solox Tek").
42. Create `src/content/blog/` and one real seed post authored by Claude Code and approved by the owner before deploy. Not lorem, not a placeholder. Subject drawn from work the owner can speak to honestly, with zero invented metrics, clients, or claims.
43. Add optional article props to `src/layouts/Layout.astro`: `ogType` (default `'website'`), `publishedTime`, `modifiedTime`, `author`. Keep the current signature and defaults so `index.astro`, `services.astro` and `paid-media.astro` render byte identical heads apart from intended additions. `og:type` becomes `{ogType}`, and `article:published_time`, `article:modified_time`, `article:author` render only when their prop is set.
44. Create `src/pages/blog/index.astro`: `/blog/` index, filters out `draft: true`, sorts by `publishDate` descending, renders title, description, date and tags per post in the existing card grid idiom. Renders through Layout with `path="/blog/"`. Ends in the standard Cal.com CTA.
45. Create `src/pages/blog/[slug].astro` with `getStaticPaths()` over non draft entries. Renders through Layout with `ogType="article"`, the post's `publishDate` as `publishedTime`, and `path={"/blog/" + slug + "/"}` so canonical and og:url match the sitemap trailing slash form exactly.
46. Add the `.px` prose block from Code Style, covering `h2`, `h3`, `p`, `ul`, `ol`, `li`, `strong`, `a`, `blockquote`, `code`, `pre`, `hr`, `img`. Reading measure capped at 70ch. All values from the existing palette and scale.

### K. Presentation and SEO

47. Emit `BlogPosting` JSON-LD on each post page via the existing per page `<script type="application/ld+json" is:inline slot="head" set:html={JSON.stringify(...)} />` pattern: `headline`, `description`, `datePublished`, `dateModified`, `author` as the existing Organization `@id` `https://solox-tek.com/#organization`, `mainEntityOfPage`, `image` `/og.png`, plus a `BreadcrumbList` Home to Blog to post.
48. Emit `Blog` plus `BreadcrumbList` JSON-LD on `/blog/`.
49. Add a `Blog` link to `src/components/Nav.astro` and `src/components/Footer.astro`. Adding a route is Ask first per `SPEC.md`, and this spec is that ask, approved by the owner on July 30, 2026.
50. Update `public/llms.txt` with a `/blog/` line and one line per published post. This is a standing obligation from `SPEC.md` Success Criteria. The sitemap is generated by `@astrojs/sitemap` and needs no change.
51. Verify the dash gate over the new output: `grep -rlP '[\x{2014}\x{2013}]' dist/blog/` returns nothing.

### L. Machine readable feed

52. Create `src/pages/blog/feed.json.ts` as a static endpoint exporting `GET`, emitting non draft posts sorted by `publishDate` descending, each with `slug`, `title`, `description`, `url` (absolute, trailing slash), `publishDate` (ISO 8601), `tags`, and `bodyExcerpt` (first roughly 1200 characters of the raw markdown body, enough for an LLM to draft social copy from without fetching and parsing HTML). Cap the array at the 20 most recent posts.
53. Confirm the feed is present in `dist/blog/feed.json` after build and is valid JSON.

## Out of scope

- Any n8n workflow. The owner builds distribution automation separately in another session. If that workflow needs a trigger, `/blog/feed.json` is the intended interface.
- LinkedIn and X API setup, credentials, and posting. Distribution is manual.
- Post scheduling, comment systems, newsletters, RSS, MDX, analytics.

## Cadence

Conclusion of a July 30, 2026 research pass over Google Search Central documentation, 2025 to 2026 AI Overviews click data (Pew, Seer, Semrush, Ahrefs), publishing frequency studies (Orbit Media 2025, inblog longitudinal dataset, HubSpot), and generative engine optimization research.

**The headline: publishing frequency is not a Google ranking factor.** Search Central documentation says so explicitly, and no official minimum exists. The cadence number is set by library building economics and human trust, not algorithm appeasement.

- **Minimum viable: 1 post per month.** Two conditions: every post is bottom funnel or case study content, and the commitment holds for 12+ months. Below this the blog never reaches useful mass, visibly reads as abandoned to prospects, and the effort is wasted. If 1 reviewed post per month is not sustainable, the honest move is no blog at all.
- **Recommended: 2 posts per month sustained**, with an optional 3 month launch sprint at 4 per month to seed the first 10 to 12 posts. This is the highest cadence at which a solo owner can apply real review rigor. The binding constraint is owner review quality, not drafting cost: the moment review gets skipped to hit the calendar, the cadence is too high.
- **Timeline honesty:** first long tail movement months 3 to 6, measurable discovery call bookings months 9 to 18, competitive commercial keywords 12 to 24 months. Judge the blog at month 9, on calls booked and prospects who mention a post, not on traffic at month 3.
- **What the first posts should be:** 2 to 3 tight clusters of bottom funnel content. Comparison and decision posts (freelancer vs agency, fixed price vs time and materials), cost and pricing posts, case study writeups (expand the Limo Mont strip into a full narrative, with the owner supplying real numbers), and 1 to 2 named author opinion pieces dense with concrete facts, which also serve LLM citation. Skip generic informational how tos: AI Overviews absorb 50 to 60 percent of those clicks while commercial and transactional queries retain roughly 69 percent clickout.
- **Blunt context the research insists on:** for a near zero authority one person agency, the blog is not the primary lead lever. Directory listings (Clutch, GoodFirms), referral partnerships, the owner's own LinkedIn presence, and consistent entity data drive both leads and LLM recommendations faster. The blog is a compounding side bet worth making because drafting cost is near zero, but an hour of owner time on a directory profile or a referral conversation beats an hour reviewing post number eleven.

## Testing Strategy

No test framework exists in this repo, there are zero devDependencies, and none is warranted. Verification gates instead, in the style `SPEC.md` already established:

1. `npm run build` passes with zero errors and zero new warnings before every commit.
2. Browser verification after every change batch: `/blog/` and one post page render at desktop and 375px, console clean, Cal popup opens from the post CTA, nav and footer Blog links work from all pages.
3. Head diff: view source of `/`, `/services/` and `/paid-media/` before and after the Layout change. Only intended differences may appear. This is the regression risk of item 43 and it is checked directly.
4. `BlogPosting` and `Blog` JSON-LD validated against schema.org, with visible text and markup matching.
5. Dash gate: `grep -rlP '[\x{2014}\x{2013}]' dist/blog/` returns nothing.
6. Feed gate: `dist/blog/feed.json` exists, is valid JSON, contains no draft posts, and every `url` matches the sitemap trailing slash form.
7. Contrast spot check on the `.px` prose colors, 4.5:1 minimum for body text.
8. After deploy: verify live canonical, sitemap entry, and one X share preview for a post URL.

## Boundaries

- **Always:** run the build before committing; keep the zero dash rule in all visible copy; preserve the existing visual design and inline style idiom, with `.px` as the single documented exception; render every new page through the shared Layout; keep the three existing pages' heads unchanged apart from intended additions; verify in the browser before declaring done.
- **Ask first:** adding any dependency, including `@astrojs/mdx` and `@astrojs/rss`; publishing any client name, logo, or metric in a post beyond what the site already states publicly; changing `astro.config.mjs`; anything touching the Cloudflare dashboard.
- **Never:** invent metrics, clients, sources, or certifications in a post; deploy a post the owner has not read in full; commit secrets or tokens; introduce em or en dashes into copy; remove the email or cal.com href fallback from any CTA.

## Success Criteria

1. `npm run build` passes with zero errors and zero new warnings.
2. `/blog/` lists every non draft post, newest first, and no draft post appears anywhere in `dist/`.
3. Every post page has exactly one `h1`, a `main` landmark, ordered `h2`/`h3`, and canonical plus `og:url` matching its sitemap URL form exactly.
4. `grep -rlP '[\x{2014}\x{2013}]' dist/` returns nothing.
5. The heads of `/`, `/services/` and `/paid-media/` are unchanged by the Layout modification, verified by build output diff.
6. `dist/blog/feed.json` is valid JSON, excludes drafts, and every entry carries an absolute trailing slash URL.
7. `public/llms.txt` lists `/blog/` and every published post.
8. Every post page emits valid `BlogPosting` JSON-LD whose `headline` and `description` match the visible text.
9. At least one real post is authored, approved by the owner, and published to the site.

## Decision Log (July 30, 2026)

1. **Authoring stays in the repo, not in any external tool.** Keeps the owner's editor, git history, and review gate.
2. **Plain markdown, not MDX.** Content collections are built into Astro 4. MDX and RSS are both new dependencies and therefore Ask first, and neither is needed for the goal.
3. **Distribution automation cut from scope by the owner.** LinkedIn and X posting is manual. The owner is building their own n8n workflow in a separate session. The JSON feed stays as the interface for it.
4. **Text only, no per post OG images.** The existing `/og.png` is reused. Revisit only if share CTRs ever matter enough to measure.
5. **`.px` prose block accepted as the single styling exception.** Markdown output cannot carry inline styles and this repo has no base element rules. It uses the same short class `is:global` escape hatch the codebase already relies on, and every value comes from the existing palette and scale.
6. **Zero dash rule enforced by grep gate over `dist/`** before every content commit, because generated text violates it by default.

## Open Questions

1. **First post topic approval.** The seed post is drafted from claims the site already makes publicly (process, engagement model, the Limo Mont strip). The owner must read and approve it before deploy. Blocks Success Criterion 9.
2. **Cadence.** Filled in by the research pass, then owner confirms the number they can actually sustain.
