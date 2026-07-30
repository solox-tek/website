---
title: "Fixed price vs time and materials for a small software build"
description: "Both models are fine. The question is who carries the risk of what nobody knows yet, and there is a third option most comparisons skip."
publishDate: 2026-07-30
tags: ["pricing", "engagement models", "software development"]
draft: false
---

Search this question and you will find a hundred posts with the same table. Fixed price is predictable but rigid. Time and materials is flexible but open ended. Pick based on how clear your requirements are.

That advice is not wrong, it is just not useful, because it hands the hard part back to you. If you knew how clear your requirements were, you would not be asking. Here is the version that actually helps.

## What you are really choosing

Neither model changes how much work the build takes. Both models decide **who absorbs the cost when reality differs from the plan.**

Under fixed price, the vendor absorbs it. They quote a number, and if the work runs long, that is their problem. Under time and materials, you absorb it. You pay for hours as they happen, and if the work runs long, that is your problem.

Everything else follows from that one sentence. Fixed price quotes carry a risk premium, because a vendor pricing unknown work has to protect themselves against the version where it goes badly. Time and materials has no premium, which is exactly why it has no ceiling.

So the question is not which model is better. It is how much is genuinely unknown, and who is better positioned to carry that specific unknown.

## When fixed price is the right call

Fixed price works when the unknowns are small enough to price.

That means the scope is written down in a form both sides read the same way. Not a wish but an actual description. These screens, these integrations, this data flowing from here to there, and what done means. If you can hand that document to two vendors and get comparable quotes, you have something priceable.

It also means the integrations are known quantities. Connecting to a documented API is priceable. Connecting to a fifteen year old internal system nobody has credentials for is not, no matter how confidently someone quotes it.

The real benefit is not the price. It is that fixed price forces the scope conversation to happen before anyone writes code, when changing your mind is still cheap. Under time and materials that conversation can be postponed indefinitely, and postponing it is expensive in a way that does not show up until month four.

## When time and materials is the right call

Time and materials is the honest answer when the work is genuinely exploratory.

Research projects where the goal is to find out whether something is possible. Long running product development where you expect to change direction based on what users do. Ongoing maintenance and support, where the whole point is that you cannot predict what next month brings. In all of those, a fixed price would be a guess wearing a suit, and you would pay the risk premium for a number that stops meaning anything the first time priorities shift.

Time and materials is also the right call when you have the internal capacity to manage it. Someone on your side has to review the work, prioritize the backlog, and notice when the burn rate stops matching the progress. If nobody owns that, an open ended contract drifts.

## Where fixed price genuinely goes wrong

This is the part the comparison tables tend to soften.

A fixed price quote on unclear scope is not protection, it is a fight scheduled for later. The vendor priced a version of the project. The moment your understanding of the project changes, and it will, you are in a change request conversation. Those conversations are adversarial by construction. Every clarification you ask for costs the vendor money, so their incentive is to argue it was never in scope, and yours is to argue it always was. Nobody is behaving badly. The contract set it up that way.

The second failure mode is quieter. A vendor who underquoted still has to deliver something for the agreed number, and the pressure lands on the parts you cannot see. Test coverage, error handling, documentation, the boring work that decides whether the thing survives its first bad day in production. You get your deliverable on budget and discover the cost eighteen months later.

Both failures have the same root. Somebody priced work that was not understood yet.

## The step that makes fixed price safe

If the problem is that scope was unknown at quote time, the fix is not to change the pricing model. It is to remove the unknown before pricing anything.

That is why we start with a short paid audit rather than a quote. We map the actual workflow, find where the real complexity sits, confirm what the integrations will and will not do, and write down what done means in language both sides read the same way. Then we price the build, fixed scope and fixed price, because by that point it is a known quantity rather than a guess.

Paying for that step feels like an extra line item. It is the opposite. It is the cheapest place in the whole engagement to discover that the integration you assumed was simple is not, or that the process you wanted automated has an exception nobody mentioned. Discovering it during the build costs more, and discovering it after launch costs the most.

It also gives you something worth having on its own. If the audit concludes the automation is not worth building, that conclusion is yours to keep, and you have spent a small amount to avoid a large mistake.

## What to ask before you sign anything

Ask the same four questions whichever model you end up with, and whoever you are talking to.

What exactly happens when we discover something the plan did not account for? A vendor with a real answer will describe a process. A vendor without one will tell you it does not happen.

What is explicitly out of scope? A quote that only lists inclusions is not a scope, it is a sales document.

Who owns the result? The code, the infrastructure, the credentials, the documentation. If any of it stays tied to the vendor, you have bought a subscription and been shown a project price.

What did the estimate assume? The assumptions are where the risk lives, and a vendor who cannot list them has not thought about them.

If you are weighing this for a specific build and want a straight read on which model fits and what the unknowns actually are, a short discovery call is the fastest way to get one.
