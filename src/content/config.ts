import { defineCollection, z } from 'astro:content';

// Blog posts: one markdown file per post, filename is the slug.
// draft defaults to true so a half-written post can never ship by accident.
const blog = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string().max(70),
    description: z.string().max(160),
    publishDate: z.coerce.date(),
    updatedDate: z.coerce.date().optional(),
    tags: z.array(z.string()).default([]),
    draft: z.boolean().default(true),
    author: z.string().default('Solox Tek'),
  }),
});

export const collections = { blog };
