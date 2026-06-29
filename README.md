# Solox Tek — Website

One-page marketing site for **Solox Tek**, built with [Astro](https://astro.build).
Static output, no client framework: just HTML, inline CSS, and a small vanilla-JS
script for the animated hero (node network + grid), scroll reveals, and the counter.

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
src/pages/index.astro    the whole page: markup + styles + script
public/logo-icon.png     logo mark (also used as the favicon)
public/og.png            social-share image (1200x630)
astro.config.mjs         set `site` to your domain for absolute OG / sitemap URLs
```

## Editing content

All copy and styling live in `src/pages/index.astro`. It is plain HTML with inline
styles, so you can edit any text directly. The hero background animation and scroll
effects are in the `<script>` at the bottom of that file. Theme values (accent color,
section padding, grid/aurora on-off) are CSS variables set on the root `#sb-root`
element near the top of the page.

## Deploy

The build output is just static files in `dist/`, so any static host works:

- **Vercel / Netlify**: import the GitHub repo. Astro is auto-detected, no config needed.
- **Cloudflare Pages**: build command `npm run build`, output directory `dist`.
- **GitHub Pages**: use the official `withastro/action`, or build and publish `dist/`.
  If you serve from a sub-path, set `site` and `base` in `astro.config.mjs`.

## Push to your GitHub

From inside this folder:

```bash
git init
git add .
git commit -m "Solox Tek website"
git branch -M main
git remote add origin https://github.com/YOUR-USERNAME/soloxtek-website.git
git push -u origin main
```

(Create the empty `soloxtek-website` repo on github.com first.)

Or, with the GitHub CLI in one step:

```bash
gh repo create soloxtek-website --private --source=. --remote=origin --push
```
