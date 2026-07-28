import { defineConfig } from 'astro/config';
import sitemap from '@astrojs/sitemap';

// https://astro.build/config
export default defineConfig({
  // Production domain so OG image / sitemap URLs are absolute:
  site: 'https://solox-tek.com',
  integrations: [sitemap()],
  vite: {
    build: {
      // Never inline assets into the blocking CSS. Without this, Vite
      // base64-inlines small font subsets (e.g. cyrillic-ext) that
      // unicode-range would otherwise let the browser skip entirely.
      assetsInlineLimit: 0,
    },
  },
});
