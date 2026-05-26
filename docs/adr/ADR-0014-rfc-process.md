# ADR-0014: RFC Process for Pre-Decision Proposals

**Status:** Accepted
**Date:** 2026-05-26

---

## Context

The project already has three document types for capturing different aspects of work:

- **ADR** — a decision that has been made, with context and consequences
- **AIR** — a conflict between existing ADRs
- **AID** — a record of a significant AI interaction

What was missing was a place for ideas and proposals **before** a decision is made.
In practice this led to one of two outcomes: either a half-formed idea was immediately
written as an ADR (forcing a premature decision), or it was lost entirely — discussed
verbally, noted informally, or forgotten between sessions.

Specific situations that prompted this:

- An idea worth exploring that isn't ready to commit to
- A change with significant trade-offs that benefits from written alternatives before deciding
- A topic parked for later — "we should think about this, but not now"
- A decision that needs team input before being locked in

## Decision

Introduce **RFC (Request for Comments)** as a pre-decision document type stored in
`docs/rfc/` with `RFC-XXXX` numbering, a template, an index, and archive.

An RFC is open and mutable — it can be revised, discussed, and closed without producing
a decision. When a decision is reached, the RFC is closed (Accepted or Rejected),
the outcome is noted, and the RFC moves to `archive/`. If a decision is significant
enough, a corresponding ADR or AID is created and linked.

## Considered Options

### Option 1: Use ADRs for everything ❌

Write a "Proposed" ADR for every idea and update its status later.

**Pros:** No new document type to learn.

**Cons:** ADRs are meant to capture decisions that have been made — a "Proposed" ADR
with unresolved trade-offs is a misuse of the format. The ADR index becomes polluted
with half-formed ideas. Deleting or rejecting an ADR feels wrong; archiving it creates
confusion with deprecated ADRs.

**Verdict:** Rejected.

### Option 2: Use GitHub Issues ❌

Track proposals as GitHub Issues labeled "rfc" or "proposal".

**Pros:** Built-in comment threads, notifications, and close/reopen lifecycle.

**Cons:** Issues are ephemeral and hard to search across time. They are not part of
the repository documentation — a developer onboarding a year later won't find them.
Proposals and bug reports mixed together in one issue tracker.

**Verdict:** Rejected.

### Option 3: Informal notes (no structure) ❌

Keep ideas in a scratch file, a Notion page, or chat history.

**Pros:** Zero friction.

**Cons:** Ideas are lost between sessions and between team members. No shared visibility.
Contradicts the project's principle of keeping decisions and context in the repository.

**Verdict:** Rejected.

### Option 4: RFC as a separate document type ✅ Chosen

A lightweight document type with a clear lifecycle: Draft → Under Review → Accepted /
Rejected / Parked → Archived.

**Pros:** Ideas are captured without forcing a premature decision. The RFC index provides
a shared view of what is being considered. Closed RFCs become a historical record of
what was explored and why some directions were not taken. The "Parked" status allows
ideas to be preserved without blocking action.

**Cons:** Another document type and directory to maintain.

**Verdict:** Accepted.

## Rationale

The key distinction between an RFC and an ADR is **mutability and commitment**.
An ADR is written after the decision — it is a record, not a debate. An RFC is written
before the decision — it is an exploration. Keeping them separate prevents the ADR index
from accumulating noise and preserves the ADR format's signal value.

The "Parked" status deserves special mention: it allows capturing an idea that is good
but premature — "we should revisit this when the project grows" — without creating
pressure to decide now or risk losing the idea entirely.

## Consequences

### Positive

- ✅ Ideas are captured without forcing premature decisions
- ✅ Shared written record of what is being considered
- ✅ Closed RFCs document explored-but-rejected directions
- ✅ "Parked" status handles the "not now but don't forget" case
- ✅ Consistent with the repository-first approach to project memory

### Negative

- ⚠️ Another document type to explain during onboarding
- ⚠️ Requires discipline to close and archive RFCs after decisions are made

### Neutral

- ℹ️ RFCs use the same 4-digit zero-padded numbering as ADR, AIR, and AID
- ℹ️ RFC archive serves a different purpose than ADR archive — rejected RFCs are
  valuable as a record of explored alternatives, not just superseded decisions

## Related ADRs

- [ADR-0009](ADR-0009-documentation-structure.md) — documentation structure extended with `docs/rfc/`
- [ADR-0010](ADR-0010-ai-assisted-development.md) — AID document type (similar pre-existing pattern)
