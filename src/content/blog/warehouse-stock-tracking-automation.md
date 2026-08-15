---
title: "How a construction company automated its warehouse stock tracking"
description: "Tradesmen at Limo Mont send a message when they take something from the warehouse. Stock updates itself, and low items trigger a reorder email."
publishDate: 2026-08-18
tags: ["case study", "ai automation", "process"]
draft: false
---

Every company with a warehouse has the same quiet problem. The people who know what left the building are not the people responsible for recording it.

Limo Mont is a family construction business in Belgrade, working in sheet metal, roofing, ventilation, insulation, and metalwork since 2007. Tools and material leave their warehouse every day in the hands of tradesmen heading out to sites. The warehouse staff were the ones expected to keep the record straight, which meant reconstructing, after the fact, what other people had taken.

There was an Excel file. There is almost always an Excel file. It existed, it was not especially good, and it was not up to date, which is the normal condition of any spreadsheet that depends on somebody remembering to open it after the work is already done.

## What happens now

A tradesman takes what he needs and sends a message. Not a form, not a login, not an app anyone had to install. A message in the tool he already uses all day, written the way he would say it out loud. I took a box of screwdrivers and a drill. A photo can come with it, and quite often the photo on its own is enough.

That message is what updates the warehouse. Fifteen tradesmen send them, across ten active sites.

The count drops by whatever he named. When an item falls under its minimum, an email goes to the secretary telling her that this one is running low, and she places the order.

That last part matters more than it looks. The system does not buy anything. It notices, and it tells a person who decides. Nobody wakes up to a delivery they did not approve.

## Why the message is the whole point

We did not remove the warehouse job. We moved the data entry to the place where the data is born.

A tradesman knows exactly what he took, because he is holding it. A warehouse clerk has to work it out afterwards from what is missing, what somebody mentioned in passing, and what turns up on a site three weeks later. One of those two people has the information at the moment it exists. The other is reconstructing it from evidence.

Almost every manual stock system asks the second person to do the recording. That is the actual defect, and no amount of discipline fixes it, because the person responsible for the record never had the information in the first place.

## It passes the filter we use

We have written before about [how to pick the first workflow to automate](/blog/first-workflow-to-automate/), using three tests. This one passes all three cleanly, which is exactly why it went first instead of something more impressive.

**It happens often.** Fifteen tradesmen, ten sites, several times a day. The payback compounds quickly, and just as usefully, problems surface within days rather than quarters.

**The rules are known.** Stock goes down by what left the building. Below a threshold, someone reorders. Two people at the company would describe that identically, which is the sign that it can be written down as rules rather than judgment.

**A mistake is visible and cheap.** If a message gets misread, the secretary sees a reorder email for something nobody needs, and she catches it before any money moves. Nothing reaches a customer, nothing reaches a tax authority.

## Everyone calls the same screw something different

One tradesman calls it a 32. Another calls it a wall screw. A third calls it the big screw. All three mean the same box, and none of them is wrong, because that is genuinely what it is called by that person on that site.

This is the hard part of reading free text written by real people, and it is what quietly kills systems like this one. A parser that silently picks the wrong item is worse than no parser at all, because now the stock number is confidently wrong and nobody has any reason to doubt it.

So the system does not guess. Where a name is ambiguous it goes back to the tradesman and asks him to confirm which item he meant. He answers, and the count moves.

Most of the naming variants were collected during testing, which is the only way to find out what people actually call things. You let people name things in their own words and you watch what comes out. The confirmation step then covers whatever the testing did not catch, which is the part you cannot enumerate in advance.

## People forget, and the system assumes it

Somebody gets busy and does not send the message. Later he sends two, one for yesterday and one for today. That case is handled rather than treated as user error, because it is going to keep happening every week for as long as the company exists.

There is also a reminder, for the days when someone was rushing or simply could not be bothered. Recording what you took has to cost almost nothing, or it stops happening, and a system that only works when everyone is disciplined is a system that does not work.

Both of these follow the same rule. The system never resolves an ambiguity by guessing. It asks the person who knows, whether that is the tradesman confirming which screw he took or the secretary deciding whether to place an order. Believable numbers are the entire point of the exercise, and a system that quietly fills in its own gaps does not produce them.

## What it runs on

Excel and n8n. That is the whole stack.

Worth saying plainly, because the word automation tends to summon something larger and more expensive than the job actually needs. The company already lived in spreadsheets. Replacing that with a warehouse management platform would have meant a migration, a subscription, and a month of people learning software they never asked for. Instead the spreadsheet stayed, and simply stopped being maintained by hand.

Everything here belongs to Limo Mont. The data is in their accounts, and none of it depends on us still being in the picture.

## What came after

Once the warehouse was steady, the same pattern moved to the website. Most incoming questions turned out to be variations of a handful, and the most common one by a wide margin is what would this cost.

That question has no single answer here. Much of the work is priced by the meter, and the rate depends on which implementation is involved, so a number means nothing until someone knows what is being built and how much of it there is. Answering it properly used to mean a person writing out the same few follow up questions, over and over, before any real reply could exist.

The site now holds that conversation itself. It asks how many meters of sheet metal the visitor thinks the job needs and what kind of implementation it is, then works toward an actual number from the company's own pricing rather than a brochure sentence.

When it does not know something, it does not improvise. The question gets flagged, a person looks at it, and the answer goes in, so the next visitor who asks the same thing gets a real one.

That is the same rule showing up a third time, now on a system that has nothing to do with the warehouse. The tradesman confirms which screw. The secretary decides whether to order. The website escalates what it cannot answer. Not one of them is permitted to guess, which is a design decision rather than a technical limit, and it is the reason people at the company believe what these systems tell them.

The larger piece is still growing. Site engineers now send progress updates the same way, which is turning into something the company never had before, a per site view of whether a job is actually making money and what a comparable job should cost next time. That one deserves its own post.

## The pattern is not about warehouses

It is about finding the point where somebody already knows something and is not being asked to record it, then making the recording take five seconds instead of five minutes.

Most companies have two or three of these. They are rarely the process people complain about in meetings, because everyone stopped seeing them years ago and now files them under the cost of doing business.

If you think you have one, that is what the discovery call is for. It is free, it takes 30 minutes, and it comes before any paid work. If the answer turns out to be that this particular workflow is not worth automating, that answer is yours to keep as well.
