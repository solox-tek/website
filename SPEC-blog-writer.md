# Spec: Blog Writer topic validation

Status: implemented and verified by manual execution on July 30, 2026. Workflow remains unpublished pending owner canvas review. Length targets in the original draft were wrong and have been corrected against measured behavior; see Measured behavior.

Third spec in the series. `SPEC.md` covers the shipped site (Phase 1). `SPEC-blog.md` covers the blog pages, the seed post, and the JSON feed. This one covers the n8n **Blog Writer** workflow, which `SPEC-blog.md` declared out of scope before the owner brought it back in. Work items continue from 53 so numbering stays unique across all three files.

## Objective

Add a live web check to the Blog Writer workflow so the owner never approves a topic blind.

Today the workflow drafts a post from a backlog row and sends it to Telegram. Nothing in that path knows whether anyone searches the topic, who already ranks for it, or whether an AI Overview eats the click. The topics currently in the backlog came from a research pass that recommended the **category** (bottom funnel comparison and pricing posts) with evidence, but named the specific phrasings only as examples. The category is grounded. The exact query is a guess.

Success looks like: the same twice-a-month Telegram message the owner already gets, with a short SERP assessment above the draft. The owner reads the assessment first, then the draft, then decides. One approval, same as now.

## Assumptions

Correcting any of these changes the work.

1. **The owner accepts a non-zero but negligible cost.** This is not free. See Cost below. The owner ruled out paid keyword tools; this is roughly 300 times cheaper than the cheapest one, but it is not zero, and approving this spec means approving that.
2. **Validation informs, it does not gate.** The assessment reaches the owner alongside the draft. It never skips a topic on its own. Gating would add a failure mode (a bad read silently drops a good topic) to solve a problem the human approval gate already solves.
3. **The n8n Anthropic node's `webSearch` option works with `claude-sonnet-5`.** Unverified. The `temperature` failure on July 30 proved this node's option set can conflict with the model at runtime, so this assumption gets tested by execution before anything is wired in, not assumed. See item 58 and Rollback.
4. **Web search is enabled for the org in the Claude Console.** It is on by default, but an admin can disable it, in which case every request 400s. Also verified by the same test run.
5. **The assessment is qualitative, not quantitative.** Web search returns pages, not search volumes. It can tell the owner who ranks and how crowded a query looks. It cannot say how many people search it monthly. Anyone expecting real numbers should read Boundaries.

## Cost

Honest accounting, because the owner's stated constraint was "not if it costs money."

Anthropic bills the server side web search tool at **$10 per 1,000 searches** ($0.01 each), plus standard token cost for the search results, which enter the request as input tokens. Verified against the Claude platform docs on July 30, 2026.

At the configured cadence of two runs per month and `maxUses: 5`:

| Item | Monthly |
| --- | --- |
| Search fees, 10 searches at $0.01 | $0.10 |
| Input tokens from search results | $0.10 to $0.30 |
| **Total** | **roughly $0.20 to $0.40** |

Call it under $6 per year. For comparison, the cheapest Ahrefs plan the owner rejected is about $129 per month. The token range is wide because it depends on how much page content each search pulls in; `claude-sonnet-5` supports dynamic filtering, which runs the results through a filter before they hit the context window, so the real figure should land at the low end.

Two things that keep this from drifting:

- `maxUses: 5` is a hard per request cap. The model cannot spend more than five searches no matter what.
- Cadence is two runs per month. Raising cadence raises this linearly and is already Ask first in `SPEC-blog.md`.

If the owner wants literal zero, the honest answer is option 1 from the July 30 discussion: check the query in Google by hand before adding a row to the backlog. Five minutes per topic, no spec needed.

## Tech Stack

No new credentials, no new nodes, no new n8n objects.

- Existing workflow: `Blog Writer: Draft and Approve`, id `go8KiydmyCph3Qzi`, personal project `lytV17yPbb2nQXcs`, currently unpublished
- Existing data table: `Blog Topics Backlog`, id `eyXx0dXDBYcu6NpL`
- One new node of a type already in the workflow: `@n8n/n8n-nodes-langchain.anthropic` v1, resource `text`, operation `message`
- Existing credential reused: `anthropicApi`, id `bcJwL6aS8FhcwfCd`
- Model `claude-sonnet-5`, matching the existing draft node. Supports the server side web search tool and dynamic filtering.

## Commands

n8n has no local build. Verification runs through the MCP tools:

- Validate before writing: `validate_workflow` on the full SDK code
- Apply: `update_workflow` with operation objects, never a blind full replace
- Test: `execute_workflow` with `executionMode: "manual"`
- Inspect: `search_executions` then `get_execution` with `includeData: true`

Website side commands are unchanged and live in `SPEC-blog.md`.

## Project Structure

Nothing in this repo changes. The spec lives here because the repo is where the owner's specs live and the feed at `/blog/feed.json` is the seam between the two systems.

Node graph after the change, new node in bold:

```
Schedule (1st and 15th, 09:00)
  → Pick Next Topic            dataTable get, oldest queued
  → Backlog Has a Topic?       if
      false → Notify Empty Backlog
      true  → Fetch Blog Feed              httpRequest, onError continue
            → Validate Topic               NEW: anthropic + webSearch
            → Draft Post with Claude       anthropic
            → Sanitize Draft               set, strips em and en dashes
            → Markdown to File             convertToFile toText
            → Send Draft File              telegram sendDocument
            → Ask for Approval             telegram sendAndWait, 12h
            → Was It Approved?             if
                true  → Mark Topic Drafted → Confirm Next Steps
                false → Mark Topic Skipped → Confirm Skip
```

`Validate Topic` sits after `Fetch Blog Feed` and before `Draft Post with Claude`. It reads the topic from `Pick Next Topic`, not from `$json`, because the immediate predecessor is the feed.

## Code Style

Match the workflow's existing idiom:

- SDK code, validated with `validate_workflow` before any write. Parameter names come from `get_node_types`, never from memory.
- No code comments. The SDK forbids them; canvas documentation goes in `sticky()` notes.
- Expressions reference upstream nodes explicitly with `$("Node Name").item.json.field` wherever the immediate predecessor is not the source. `$json` is only for the node directly upstream.
- Every node carries sample `output` data.
- The zero dash rule binds the assessment text too. The assessment is not sanitized by the `Sanitize Draft` node, which only touches the post body, so the constraint is carried in the validation system prompt and is checked by eye on the first run.

Assessment output shape:

```
Competition: <who ranks and how strong>
AI Overview: <whether the query looks AI Overview heavy, and why>
Angle: <the angle most likely to survive, including any narrowing>
Verdict: worth writing | narrow it | skip
```

The `Verdict` line is a strict enum, enforced by an explicit prompt rule, because its whole purpose is a one glance signal. Qualifications belong on the `Angle` line. Total length is **not** enforceable by prompt; see Measured behavior.

## Measured behavior

Three verification runs produced assessments of 799, 1110, and 1589 characters. Each time the prompt was tightened, the output got **longer**, not shorter. The conclusion after three attempts: on `claude-sonnet-5` a character budget in the system prompt is advisory at best for this task, and adding more rules to enforce it increases output length rather than reducing it.

What this changed in the design:

- The prompt still states a budget, as a nudge. It is not treated as a guarantee.
- Enforcement is a deterministic `slice(0, 2500)` in the approval message expression. That is what actually protects the Telegram 4096 character limit.
- The guard is not cosmetic. With `maxTokens: 1024` an assessment can reach roughly 4000 characters, which combined with the rest of the approval text would exceed 4096 and **fail the Telegram send outright**. This was found by the second verification run, not by reasoning ahead.
- The model also inserts an unlabeled summary sentence before `Competition:` despite a rule forbidding preamble. Accepted: it reads fine and carries information.

Assessments land around 800 to 1600 characters, which is three short paragraphs on a phone. That is readable and the content earns the space, so the original 700 character target was the wrong requirement rather than an unmet one.

## Work Items

### P. Topic validation

54. Add node **`Validate Topic`**, type `@n8n/n8n-nodes-langchain.anthropic` v1, `resource: 'text'`, `operation: 'message'`, model `claude-sonnet-5`, credential `bcJwL6aS8FhcwfCd`. Options: `webSearch: true`, `maxUses: 5`, `includeMergedResponse: true`, `maxTokens: 1024`. No `temperature`, which the model rejects.
55. System prompt for that node: assess a proposed blog topic for a one person senior dev agency on a low authority domain. Search the live web for the query and near variants. Report the four lines from Code Style, with `Verdict` restricted to exactly one of three strings. No em or en dashes, no invented search volumes or difficulty scores, no verbatim reproduction of competitor page copy. State plainly when the search results are inconclusive rather than guessing. A length budget is stated but not relied on; see Measured behavior.
56. User message for that node: the topic and notes from `$("Pick Next Topic")`, plus the instruction to search now.
57. Rewire: `Fetch Blog Feed → Validate Topic → Draft Post with Claude`, replacing the direct `Fetch Blog Feed → Draft Post with Claude` connection. `Draft Post with Claude` already reads its inputs via `$("Pick Next Topic")` and `$("Fetch Blog Feed")`, so inserting a node between them changes no existing expression.
58. Set `onError: 'continueRegularOutput'` on `Validate Topic`. A failed or refused search must never block the draft. When it fails the assessment line reads as unavailable and the owner falls back to judging the draft alone, which is exactly today's behavior.
59. Extend the `Ask for Approval` message: the assessment goes above the draft reference, under a `SERP CHECK` heading, read via `$("Validate Topic").item.json.merged_response`. Use a `??` fallback string so a failed validation node cannot produce an empty or broken message, and a `slice(0, 2500)` guard so a long assessment cannot push the message past Telegram's 4096 character limit.
60. Add a `sticky()` note covering what validation does, what it cannot do (no search volumes), and the per run cost.

### Q. Verification

61. Every `update_workflow` call returns zero `validationWarnings`. **Done.** Operations based updates are checked this way; `validate_workflow` applies to SDK code, which this change does not use.
62. One manual execution end to end. This is the real test of Assumption 3 and 4: if the node cannot do web search on this model, or the org has it disabled, the run fails here and nothing has been committed to the schedule. **Done, executions 428, 429, 430, all reached the approval gate.**
63. Read the execution data for `Validate Topic` and confirm the assessment is present, carries the four labeled lines, holds `Verdict` to the enum, contains zero em and en dashes, and reports actual search use rather than an answer written from the model's memory. **Done.** Search use is evidenced by `server_tool_use` and `citations` in the node output, and by six competitor domains the model could not have invented. The length criterion was dropped; see Measured behavior.
64. Confirm the Telegram approval message renders both the assessment and the draft, and stays under the 4096 character Telegram limit. **Done, roughly 1940 of 4096 on the longest run, with a hard guard at about 2850.**
65. Record real cost from the Anthropic console after one full cycle, replacing the estimate in Cost. **Open.** Per node token usage is not exposed in the execution data because `simplify: true` strips it, so the console is the only source. Today's three verification runs used up to 15 searches, roughly $0.15 in search fees plus tokens.

## Rollback

If item 62 fails because the node cannot run web search with this model, in order of preference:

1. Try `claude-opus-5` on the validation node only. Different model, same node, one parameter change.
2. Replace the node with an `httpRequest` node calling the Anthropic Messages API directly with an explicit `web_search_20250305` tool block and `allowed_callers: ["direct"]`. More work, full control over the tool version, uses an existing credential type.
3. Abandon the step and delete the node. The workflow returns to exactly its current shape, and the owner does option 1 from the July 30 discussion: a manual Google check per topic. Nothing else in the workflow depends on validation.

## Testing Strategy

No test framework, same as the rest of this project. Gates instead.

1. `validate_workflow` passes before the update is applied.
2. One manual execution, inspected via `get_execution` with `includeData: true`, before the workflow is ever published.
3. The assessment is read by eye on the first run for shape, length, and dashes.
4. The existing path is regression checked in the same run: the draft still generates, the frontmatter still matches the zod schema in `src/content/config.ts`, the backlog row still updates on approval.
5. Cost is checked against the Anthropic console after the first run and the real figure is written back into this spec, replacing the estimate.

## Boundaries

- **Always:** validate SDK code before writing it; reference upstream nodes explicitly in expressions; keep `maxUses` capped; keep the zero dash rule in every piece of generated text; test by manual execution before publishing; leave the workflow unpublished for the owner to review.
- **Ask first:** raising `maxUses` above 5; raising the schedule cadence; switching the validation model; adding any node that spends money per execution; publishing the workflow; anything that would make validation gate the draft rather than inform it.
- **Never:** present the assessment as keyword data; let a validation failure block the draft; invent search volumes, difficulty scores, or competitor names the search did not return; hardcode a credential id that is not already on the instance; touch the `X Seen Posts` data table or the existing X reply workflow.

## Success Criteria

1. Every update applies with zero `validationWarnings`. **Met.**
2. A manual execution completes end to end with the validation node reporting a real search. **Met, three times.**
3. The Telegram approval message carries the labeled assessment above the draft, with `Verdict` holding to the enum and zero em and en dashes. **Met.** The original wording added "under 700 characters"; that target was wrong and is replaced by the guard described in Measured behavior.
4. A long assessment cannot push the approval message past Telegram's 4096 character limit. **Met by the `slice` guard.** This criterion did not exist in the original draft and was added after the risk surfaced during verification.
5. Disabling or failing the validation node still produces a draft and a working approval message. **Designed for via `onError: 'continueRegularOutput'` and the `??` fallback. Not yet exercised by a deliberately failed run.**
6. The existing draft, sanitize, file, approval, and backlog update path is unchanged in behavior. **Met, verified across all three runs.**
7. Real measured cost for one run is recorded in this spec, replacing the estimate. **Open, see item 65.**
8. The workflow remains unpublished until the owner reviews the canvas. **Met.**

## Decision Log (July 30, 2026)

1. **Anthropic's built in web search over a keyword API.** No new credential, no new node type, no monthly subscription. The tradeoff is qualitative assessment instead of real numbers, which is stated in Boundaries rather than hidden.
2. **Inform, do not gate.** The owner's approval gate already exists. A second automated gate could silently drop a good topic and would need its own failure handling for no added benefit.
3. **`maxUses: 5`.** A hard cap the model cannot exceed. It is the node default and bounds the per run cost at five cents in search fees.
4. **Assessment carried as plain text, not JSON.** A four line text block cannot fail to parse. Structured output would add a parsing failure mode to a step whose whole output is one short paragraph a human reads.
5. **`onError: 'continueRegularOutput'`.** Validation is an enhancement to a workflow that already works. It must degrade to the current behavior, never break it.
6. **Same model as the drafting node.** Consistency, and `claude-sonnet-5` supports web search with dynamic filtering. `claude-opus-5` is the first rollback step if assessment quality disappoints.
7. **Cost surfaced in the spec rather than buried.** The owner set a cost constraint. A change that violates it, even by cents, is the owner's call to make with the number in front of them. Approved by the owner on July 30, 2026 with the numbers in front of them.
8. **Length enforced in code, not in the prompt.** Added after three verification runs showed the prompt budget being ignored and output growing as rules were added. The prompt keeps an advisory budget; correctness rests on a deterministic guard. Generalizes to a rule for this project: when an LLM output feeds a system with a hard limit, the limit is enforced outside the model.
9. **Length target dropped rather than chased.** The 700 character goal was invented before any output existed. The measured 800 to 1600 character assessments carry more useful information than a terser version would, so the spec moved to match the system instead of the system being bent to match a guessed number.

## Open Questions

1. **Does the owner accept roughly $0.20 to $0.40 per month?** This is the only question that blocks everything. A no means deleting this spec and doing manual checks instead.
2. **Is a qualitative read useful enough without search volumes?** The assessment can say "three agencies with real authority rank for this, and the AI Overview answers it directly." It cannot say "40 searches per month." If the owner needs the number, only a paid tool provides it and this spec is the wrong solution.
3. **Should the assessment ever reach the backlog table?** Writing the verdict back to a new column would build a record over time. Not in this spec: it adds a column and a write, and the Telegram history already keeps the assessments. Worth revisiting after a few runs.
