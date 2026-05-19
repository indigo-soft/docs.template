# ADR-0010: AI-Assisted Development and AID Records

**Status:** Accepted
**Date:** 2026-05-18

---

## Context

AI coding assistants (Claude, GitHub Copilot, GPT-4, etc.) are increasingly used for
generating documentation, code, architectural decisions, and project setup. This creates
a new category of work that is not captured by existing document types:

- **ADRs** capture decisions, not the process of making them
- **Guides** capture how to do things, not who or what helped
- There is no standard way to record that a significant artifact was AI-generated,
  how it was evaluated, what was changed, and what was learned

Without a record, the team loses:

- Audit trail ("why is this document written this way?")
- Prompting knowledge ("what prompt produced this result?")
- Learning ("what did the AI get wrong, and how was it corrected?")

## Decision

Introduce **AI Interaction Documents (AID)** as a first-class document type,
stored in `docs/aid/` with `AID-XXXX` numbering, a template, an index, and
a dedicated Claude prompt in `docs/prompts/aid.md`.

## What AID captures

| Section         | Content                                                           |
| --------------- | ----------------------------------------------------------------- |
| Goal            | What problem or task prompted the interaction                     |
| Prompt summary  | What was asked (link to prompt file or paste key text)            |
| AI output       | What was produced (type + key content + links to generated files) |
| Evaluation      | How the output was assessed and by whom                           |
| Outcome         | What was adopted / modified / rejected and why                    |
| Project impact  | What changed in the project as a result                           |
| Lessons learned | Prompting strategies, AI strengths/limitations, surprises         |

## AID vs ADR vs AIR

| Document | Captures                                    | Lifecycle                   |
| -------- | ------------------------------------------- | --------------------------- |
| ADR      | An architectural or technical decision      | Accepted → Superseded       |
| AIR      | A conflict between two ADRs                 | Open → Resolved             |
| AID      | A significant AI interaction and its impact | Draft → Accepted → Archived |

## When to create an AID

Create an AID when an AI interaction:

- Generated a significant artifact that was adopted (document, code, architecture, guide)
- Produced a decision that shaped the project direction
- Failed in an instructive way worth documenting
- Introduced a prompting strategy worth repeating
- Touched multiple areas at once (multi-document generation sessions)

Do not create an AID for trivial autocomplete, minor edits, or fully discarded output.

## Considered Options

### No formal record (ad hoc notes)

**Pros:** Zero overhead.
**Cons:** Knowledge is lost immediately. No audit trail. No way to learn from failures.
**Verdict:** Rejected.

### Extend ADR format

**Pros:** Reuse existing tooling and conventions.
**Cons:** ADRs focus on decisions, not process. Mixing them creates confusion.
**Verdict:** Rejected.

### New document type (AID) ✅ Chosen

**Pros:** Clean separation of concerns. Dedicated template with AI-specific sections.
Searchable index. First-class status signals that AI collaboration is intentional and tracked.
**Cons:** Another document type to maintain.
**Verdict:** Accepted.

## Consequences

### Positive

- Complete audit trail of AI-assisted work in the project
- Prompting knowledge is preserved and reusable
- Failures are documented, not silently discarded
- New team members can understand how and why AI was used
- AIDs surface patterns in AI strengths and limitations for specific tasks

### Negative

- Discipline required — it is easy to skip writing an AID after the work is done
- Adds another directory and document type to learn

### Neutral

- AID numbering follows the same convention as ADR (4-digit, zero-padded)
- Template and prompt are provided to minimize friction

## Related ADRs

- [ADR-0009](ADR-0009-documentation-structure.md) — documentation structure that includes `docs/aid/`
