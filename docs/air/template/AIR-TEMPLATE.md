# AIR-00N: [Short conflict description]

<!--
File name:  air-00N-short-conflict-description.md
After resolution rename to:  done-air-00N-short-conflict-description.md

Title examples:
  AIR-002: Redis cluster requirement conflicts with single-node policy from ADR-003
  AIR-003: Log retention requirement conflicts with privacy rules from ADR-004
-->

## Status

<!-- Open | Resolved | Deferred -->

Open

## Affected ADRs

<!--
List all ADRs involved in the conflict. Use relative paths
(AIR files live in air/, ADRs are one level up in adr/).
-->

| ADR                                            | Title            | Status after resolution                      |
|------------------------------------------------|------------------|----------------------------------------------|
| [ADR-XXXX](../adr/ADR-XXXX-first-decision.md)  | First ADR title  | Accepted — unchanged / clarified             |
| [ADR-YYYY](../adr/ADR-YYYY-second-decision.md) | Second ADR title | Accepted — updated to account for constraint |

## Conflict Description

<!--
Explain:
- What ADR-XXXX requires or forbids
- What ADR-YYYY requires or does
- Where exactly they intersect and why this is a problem
- Why the conflict cannot simply be ignored

Be specific — quote or paraphrase the exact requirements from each ADR.
-->

**ADR-XXXX** requires: ...

**ADR-YYYY** requires: ...

**Point of conflict:** ...

## Severity

<!--
Critical  — blocks implementation; one decision cannot be applied without changing the other
Moderate  — both can be applied, but an explicit exception or clarification is needed
Low       — mostly theoretical tension; minimal practical impact
-->

**Level:** Moderate

[Explain why — 1–2 sentences]

## Resolution Paths

<!--
Describe at least 2 options. For each, list pros, cons, and status.
Be honest — the goal is to document the analysis, not to sell the chosen option.
-->

### Path A: [Option name]

**Pros:**

- ✅ ...

**Cons:**

- ❌ ...

**Status:** [✅ Chosen | ❌ Rejected | ⏳ Deferred]

### Path B: [Option name]

**Pros:**

- ✅ ...

**Cons:**

- ❌ ...

**Status:** [✅ Chosen | ❌ Rejected | ⏳ Deferred]

### Path C: [Option name] *(optional)*

**Pros:**

- ✅ ...

**Cons:**

- ❌ ...

**Status:** [✅ Chosen | ❌ Rejected | ⏳ Deferred]

## Decision Taken

<!--
Leave empty while status is Open.
Fill in after discussion, then change status to Resolved.

Structure:
1. Which path was chosen and why
2. What is clarified in each affected ADR
3. Whether this sets a precedent for similar future situations
-->

*Decision not yet made.*

## Consequences

<!--
Fill in after resolution.
What changes for each affected ADR and for the team.
-->

### For ADR-XXXX

[What changes or is clarified]

### For ADR-YYYY

[What changes or is clarified]

### For the team

- [ ] [Specific action to take]
- [ ] [Document to update]

## Action Checklist

<!--
Actions to complete after resolution. Leave checkboxes open until done.
-->

- [ ] Update ADR-XXXX — add `Conflict resolved by: [AIR-00N](../air/done-air-00N-....md)`
- [ ] Update ADR-YYYY — add `Conflict resolved by: [AIR-00N](../air/done-air-00N-....md)`
- [ ] Update [INDEX.md](INDEX.md) — move to Resolved table
- [ ] Rename file: `air-00N-...md` → `done-air-00N-...md`

## Date Opened

YYYY-MM-DD

## Date Resolved

<!-- Fill in after resolution -->

YYYY-MM-DD

## Tags

<!-- Examples: architecture-conflict, docker, security, performance, infrastructure -->

`architecture-conflict` `[tag-1]` `[tag-2]`
