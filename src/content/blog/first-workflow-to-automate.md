---
title: "How to pick the first workflow to automate"
description: "A practical filter for choosing your first automation project: where to look, what to skip, and why the boring workflow usually wins."
publishDate: 2026-07-30
tags: ["ai automation", "process"]
draft: false
---

Most automation projects that fail do not fail in the build. They fail earlier, at selection. Someone picks the most visible problem, or the most exciting one, and six weeks later there is a demo that impresses everyone and a workflow that nobody trusts with real work.

Picking the first workflow is a filtering problem, and the filter is not "what would be coolest to automate." It is "where do repetition, structure, and cost line up." Here is the filter we use.

## Three tests before anything else

Run every candidate workflow through these three questions.

**Does it happen often?** Automation pays back per execution. A task that eats twenty minutes and happens forty times a month is a better first target than a task that eats a full day and happens twice a year. Frequency also means you find out quickly whether the automation actually works, because it gets exercised every day instead of every quarter.

**Are the rules known?** If two people at the company would do the task the same way, it has rules, and rules can be encoded. If every case turns into a judgment call, you are not looking at an automation candidate. You are looking at a job. AI has widened what counts as "rules," because a model can now read a messy email or an invoice PDF and pull out the structure. But the decision about what happens next still needs to be one you can write down.

**Is a mistake visible and cheap?** Your first automation will make mistakes. That is not pessimism, it is planning. Pick a workflow where a wrong output is caught in review before it costs anything: an internal document, a draft reply, a categorized expense. Do not pick the workflow where a mistake goes straight to a customer or a tax authority.

A workflow that passes all three is a good first project. A workflow that passes two can work with guardrails. A workflow that passes one is a trap.

## Where the good candidates hide

The best first workflows are almost never the ones people complain about in meetings. They are the ones nobody mentions because everyone has accepted them as furniture. Look in three places.

**Data that gets typed twice.** Anything that moves between two systems through a human keyboard: orders into the accounting tool, form submissions into the CRM, invoice lines into a spreadsheet. This is the classic case because the correct behavior is fully defined by the source data.

**Questions answered from documents.** If someone spends part of their week answering the same questions about pricing, availability, or policy, and the answers live in documents or spreadsheets that already exist, that is a strong candidate. The knowledge is already written down. The work is retrieval, and retrieval is what these systems are good at.

**Bookkeeping and admin around every job.** Every business has a paperwork shadow behind each unit of real work: the confirmation, the record, the status update, the filing. Individually these are two-minute tasks. Multiplied across every job in a month they are often the largest untracked cost in the company.

## What to skip the first time

Some workflows are fine second or third projects and terrible first ones.

Skip anything fully customer-facing on day one. An AI agent talking to your customers with no human in the loop is a reputation decision, not a tooling decision, and you want operational experience before you make it. Start with the internal version: the agent drafts, a person approves.

Skip the rare catastrophe. The task that is painful twice a year feels urgent precisely because it is painful, but you get two chances a year to learn whether the automation works. That is a slow feedback loop for a first project.

Skip anything where the team disagrees about what a correct result looks like. Automation freezes a process in code. Freezing a process people still argue about turns a disagreement into a system.

## Count the payoff honestly

The honest math is simple: time per execution, times executions per month, times the loaded cost of the person doing it. Then add the error cost of the manual version, because humans doing repetitive transfer work make mistakes too, and those mistakes have a price that nobody logs.

Then subtract the part people forget: review time. If a person still needs to check every output, count that. An automation that turns twenty minutes of work into two minutes of review is a great result. Pretending it is zero minutes is how trust in the numbers dies.

If the math only works when the automation runs unsupervised from day one, the math does not work yet.

## Write the workflow down before you automate it

The single most useful step costs nothing: write down, in plain sentences, what actually happens today. Who receives what, what they look at, what they decide, where it goes. Nearly every workflow we have mapped this way contained a step that existed only because of a constraint that no longer applies, or an exception nobody had mentioned.

Sometimes the writing is the whole payoff. A step that exists for no reason should be deleted, not automated. Automating waste just produces waste faster.

This mapping step is exactly what our paid audit is: we map the workflow, find where the payoff actually is, and put a fixed price on building it. If the audit shows automation is not worth it, that conclusion is yours to keep too.

If you have a workflow in mind and want a second opinion on whether it passes the filter, that is what the discovery call is for.
