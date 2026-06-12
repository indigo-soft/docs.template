# AIR-XXXX: [Short conflict description]

<!--
File name:  AIR-XXXX-short-conflict-description.md  (4-digit zero-padded number, same as ADR/AID/RFC)
After copying out of template/, fix the INDEX link (the template lives one level deeper):
  sed -i 's|](\.\./INDEX\.md)|](INDEX.md)|' docs/air/AIR-XXXX-short-conflict-description.md
After resolution move the file to:  archive/AIR-XXXX-short-conflict-description.md
(adjust relative links inside — ADR links become ../../adr/..., INDEX becomes ../INDEX.md)

Title examples:
  AIR-0002: Redis cluster requirement conflicts with single-node policy from ADR-0003
  AIR-0003: Log retention requirement conflicts with privacy rules from ADR-0004
-->

## Status

<!-- Open | Resolved | Deferred -->

Open

## Affected ADRs

<!--
List all ADRs involved in the conflict. Use relative paths
(open AIR files live in air/, ADRs live in the sibling adr/ directory — use ../adr/...).
Replace ADR-XXXX and ADR-YYYY with real links once known.
-->

| ADR      | Title            | Status after resolution                      |
| -------- | ---------------- | -------------------------------------------- |
| ADR-XXXX | First ADR title  | Accepted — unchanged / clarified             |
| ADR-YYYY | Second ADR title | Accepted — updated to account for constraint |

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

### Path C: [Option name] _(optional)_

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

_Decision not yet made._

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

- [ ] Update ADR-XXXX — add `Conflict resolved by: AIR-XXXX` to Related ADRs section
- [ ] Update ADR-YYYY — add `Conflict resolved by: AIR-XXXX` to Related ADRs section
- [ ] Update [INDEX.md](../INDEX.md) — move the entry to the Resolved table
      <!-- after copying out of template/, this link must point to INDEX.md (see header comment) -->
- [ ] Move the file to archive: `mv docs/air/AIR-XXXX-...md docs/air/archive/`
- [ ] Adjust relative links inside the moved file (`../adr/...` → `../../adr/...`)

## Date Opened

YYYY-MM-DD

## Date Resolved

<!-- Fill in after resolution -->

YYYY-MM-DD

## Tags

<!-- Examples: architecture-conflict, docker, security, performance, infrastructure -->

`architecture-conflict` `[tag-1]` `[tag-2]`
