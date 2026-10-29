---
title: "Chatbot, automation, or AI agent: what are you buying?"
description: "Need an answer, a repeatable process, or a system that can work out the next step? Here is how to choose."
publishDate: 2026-10-29
tags: ["ai agents", "ai automation"]
draft: false
---

Your team copies invoice details into a spreadsheet every morning. A vendor pitches an AI agent to fix it.

A few fixed steps might do the whole job. Before comparing quotes, get clear on what the system needs to do.

## Start with the job

<figure class="px-compare" aria-labelledby="choose-caption">
  <figcaption id="choose-caption">Three ways to get the work done</figcaption>
  <dl>
    <div>
      <dt><a href="#need-an-answer">Chatbot</a></dt>
      <dd><strong>Answer a question.</strong><span>Find the return policy.</span></dd>
    </div>
    <div>
      <dt><a href="#know-the-steps">Automation</a></dt>
      <dd><strong>Run steps you define.</strong><span>Record an invoice.</span></dd>
    </div>
    <div>
      <dt><a href="#need-to-work-out-the-steps">AI agent</a></dt>
      <dd><strong>Work out the next step.</strong><span>Investigate a bug.</span></dd>
    </div>
  </dl>
</figure>

These can overlap. A chat window can sit in front of an automation or an agent. What matters is how the work happens behind it.

## Need an answer?

"What is our return policy?" A chatbot finds the policy and explains it. A good one can search documents, read current data, and hand a question to a person when it cannot answer.

For common questions about products or internal policies, try an existing product before paying for a custom build. Check it against your own questions and documents, including cases where the answer is missing.

**If a useful answer finishes the job, that may be all you need.**

If somebody then has to open another tool and copy the answer into it, there is still work to automate.

## Know the steps?

An invoice arrives. Read the supplier and amount. Create a record. Ask for approval if the amount is above an agreed limit.

That is an automation. Its steps and possible branches are defined in advance. AI might read the PDF, but it does not get to invent a new payment process.

An AI step can still misread a number or return a different result on another run. **Fixed steps make the process easier to inspect. They do not make every result correct.**

Use this approach for work you can describe clearly, such as moving data between tools, routing approvals, or preparing a regular report.

## Need to work out the steps?

A bug report arrives. The logs might explain it. Or the investigation might need recent code changes, an older ticket, and a check of which team owns the affected feature.

An agent can choose what to inspect next based on what it finds. It gets a goal, tools it is allowed to use, and limits. It can then hand a person its findings and a suggested owner.

**Use an agent when the route is hard to write down in advance.** If you already know the route, fixed steps are usually a better starting point.

This is the distinction [Anthropic makes between workflows and agents](https://www.anthropic.com/engineering/building-effective-agents). Extra flexibility can mean more model calls, higher costs, and mistakes that carry into later steps. It needs testing and supervision.

## Buy the simplest thing that works

An agent is not automatically an upgrade. For the invoice job, a fixed process with a check on extracted amounts may be enough. For the bug investigation, choosing the next step may be the useful part.

You can combine them. Let fixed steps handle routine work, give an agent a specific investigation, and require approval before an expensive action.

Ask what work comes off your team's plate, and how you will check that it was done correctly.

That is also why we [start by choosing one process worth fixing](/blog/first-workflow-to-automate/). Automating an unnecessary step still leaves you with an unnecessary step.

## Five questions before you sign

A polished demo shows what works. Ask to see what happens when it does not.

1. **Who chooses the next step?** Ask to see the fixed steps, or how the model chooses its tools and when it stops.
2. **What can it read or change?** Get specific permissions and agree which actions need a person's approval.
3. **What happens when it cannot finish?** Try a missing answer, a bad document, or an unavailable tool. Who gets notified?
4. **Can we see what happened?** Ask for a record of inputs, actions, failures, and approvals that your team can inspect.
5. **What do we own, and what keeps costing money?** Clarify access to code, prompts, accounts, and data, plus ongoing usage and support costs.

These are requirements for a good system. The word agent guarantees none of them.

## Bring one task

Pick something your team keeps doing by hand. We will help you work out whether it needs a chatbot, an automation, an agent, or just fewer steps.

The discovery call is free and takes 30 minutes, before any paid audit or quote. If an existing product does the job, we will say so.
