# Solox Tek Website

Marketing site for **Solox Tek**, built with [Astro](https://astro.build).
Static output, no client framework: HTML, inline CSS, and a small vanilla JS
script for the animated hero (node network plus grid), scroll reveals, and the
counter.

## Develop

```bash
npm install
npm run dev      # http://localhost:4321
```

## Build

```bash
npm run build    # static site in ./dist
npm run preview  # preview the production build locally
```

## Project structure

```
src/pages/index.astro         Homepage: hero, services, case study, FAQ, CTA
src/pages/services.astro      Services hub
src/pages/paid-media.astro    Paid media pricing page
src/layouts/Layout.astro      Shared head, global reset, fonts, Cal.com loader
src/components/Nav.astro      Shared nav (fixed overlay on the homepage, sticky elsewhere)
src/components/Footer.astro   Shared footer
public/                       Favicon, logos, og.png, robots.txt, llms.txt
astro.config.mjs              `site` domain for absolute OG and sitemap URLs
SPEC.md, tasks/               Improvement spec and task plan
```

## Editing content

Copy and styling live in the page files as plain HTML with inline styles, so any
text can be edited directly. Shared head tags (canonical, OG, Twitter) and the
Cal.com booking loader live in `src/layouts/Layout.astro`. The hero background
animation and scroll effects are in the script at the bottom of `index.astro`.

## Deploy

Deployed on Cloudflare Pages: build command `npm run build`, output directory
`dist`. Any static host works with the same settings.
