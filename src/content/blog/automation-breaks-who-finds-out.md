---
title: "When an automation breaks, who finds out?"
description: "The costly failure is rarely the error message. It is the run that never happened, or the wrong number nobody checked. Here is how to catch both."
publishDate: 2026-11-20
tags: ["ai automation", "process"]
draft: false
---

An automation that crashes is annoying. An automation that quietly stops is expensive, because nobody notices until a customer or a supplier does.

Most teams set up an automation, watch it work for a week, and move on. That is a reasonable instinct. It is also how a broken process ends up running unnoticed for a month.

## Two ways an automation breaks

Some failures are loud. A password expires, a connected app changes how it works, or a service goes down for an hour. The run stops and an error appears somewhere.

Loud failures are the easy kind, as long as somebody sees the error. Often it lands in the inbox of whoever built the automation, or in a dashboard nobody opens.

Other failures are quiet. Nothing errors. The automation keeps running and produces the wrong result, or it stops being triggered at all. Either way, no alarm goes off.

- A supplier changes the layout of its invoices, and the step that reads them now picks up the tax amount instead of the total.
- Someone renames a field in the CRM, and new leads arrive without a company name.
- A website update breaks the contact form's connection to the automation. No new requests come in, and nothing looks wrong.
- An AI step that sorts support emails starts filing a new kind of request in the wrong place.

**The quiet failures do the damage, because the first person to notice is often outside your company.**

## Watch for what did not happen

Most automation tools can tell you when a run fails. Turn that on, and send it to a person rather than a shared inbox.

But a failure alert cannot fire for a run that never started. So add the opposite check. If invoices arrive every weekday, you should hear about it when a weekday passes with none. If the contact form usually brings in a few requests a day, two empty days are worth a message.

This check is easy to forget, because while everything works, it never makes a sound.

## Check the result, not just the run

A run that finishes is not the same as a run that did the right thing. For anything that moves money or reaches a customer, compare the output with what you expect.

An invoice total should match the sum of its lines. An amount far above the usual range should wait for a person. A record missing a required field should stop instead of going through.

This matters more once AI is involved. [An AI step can misread a number](/blog/chatbot-automation-or-ai-agent/) or return a different result on another run, and it will not raise an error when it does.

A short daily summary helps as well. A message like "Yesterday we recorded 14 invoices and sent 2 for approval" takes seconds to read. When that number suddenly drops to zero or doubles, someone notices the same morning.

## Give every automation an owner

An alert is only useful if a specific person is expected to act on it. Decide who that is before the automation goes live, and who covers when they are away.

Write down what they should do when it breaks. The answer is usually simple. Pause the automation, handle the day's cases by hand, and call whoever maintains it.

Keep a record of every run that the owner can read without opening the automation tool. When something goes wrong, the first questions are what happened and since when. A readable record answers both in minutes. Without one, it takes an afternoon of guessing.

## Questions to ask before you accept it

None of this shows up in a demo. It shows up in the second month. Whether you build it yourself or buy it, ask these before the automation goes live.

1. **What happens when a run fails?** Who is told, and how quickly?
2. **What happens when nothing runs?** Is there a check for work that should have arrived and did not?
3. **How is the output checked?** Which results are compared with expected values, and which wait for a person?
4. **Who fixes it, and how fast?** Is support part of the agreement, or a new quote every time?

## Bring the one you worry about

Error handling and monitoring are part of how we build, and we keep monitoring and supporting what we ship after it goes live.

If you already have automations running and are not sure what would happen if one stopped tonight, bring it to a discovery call. It is free, takes 30 minutes, and comes before any paid audit or quote. If it turns out to be fine as it is, we will say so.
