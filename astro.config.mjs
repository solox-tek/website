import { defineConfig } from 'astro/config';
import sitemap from '@astrojs/sitemap';

// https://astro.build/config
export default defineConfig({
  // Production domain so OG image / sitemap URLs are absolute:
  site: 'https://solox-tek.com',
  integrations: [sitemap()],
});
