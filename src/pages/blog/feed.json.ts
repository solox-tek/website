// Machine readable blog feed at /blog/feed.json, generated at build time.
// Consumed by external tooling (e.g. an n8n distribution workflow) so it
// carries a raw markdown excerpt: enough to draft social copy from without
// fetching and parsing the rendered HTML.
import { getCollection } from 'astro:content';

export async function GET() {
  const posts = (await getCollection('blog', ({ data }) => !data.draft))
    .sort((a, b) => b.data.publishDate.valueOf() - a.data.publishDate.valueOf())
    .slice(0, 20)
    .map((p) => ({
      slug: p.slug,
      title: p.data.title,
      description: p.data.description,
      url: 'https://solox-tek.com/blog/' + p.slug + '/',
      publishDate: p.data.publishDate.toISOString(),
      tags: p.data.tags,
      bodyExcerpt: p.body.trim().slice(0, 1200),
    }));

  return new Response(JSON.stringify({ posts }, null, 2), {
    headers: { 'Content-Type': 'application/json' },
  });
}
