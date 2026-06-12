# Prompt: Generate System Design Guide

## Purpose

Generate `docs/guides/system-design.md` — a high-level description of how the system
is built: major parts, how they communicate, where data lives, and how the system
behaves under failure. It complements `docs/architecture/` (which describes structure
in detail) by focusing on the **runtime view** and design reasoning.

## Prerequisites

Read first:

- `docs/context/project.md` — stack, infrastructure, environments
- `docs/guides/requirements.md` — if it exists, design must trace back to requirements
- `docs/architecture/overview.md` — if it exists, avoid duplicating its content

If `project.md` is not filled in, run `docs/prompts/onboarding.md` before this prompt.

## Questions to ask

Ask one group at a time. Skip anything already known from project files.

### Group 1 — Runtime shape

1. **Deployment units** — what actually runs? (single CLI process, API + worker,
   monolith, set of services)
2. **Communication** — how do the parts talk? (function calls, HTTP, queue, events)
3. **External dependencies** — which third-party services or APIs does the system call?

### Group 2 — Data

4. **Data stores** — what is stored where? (database, files, cache, object storage)
5. **Data flow** — what is the path of the main entity from input to output?
6. **Data lifecycle** — retention, backups, migrations?

### Group 3 — Cross-cutting concerns

7. **Failure handling** — what happens when a dependency is down or input is invalid?
8. **Observability** — logging, metrics, tracing — what exists or is planned?
9. **Scaling** — what is the expected load, and which part hits its limit first?

## Output

Create or overwrite `docs/guides/system-design.md`:

```markdown
# System Design

> Last updated: {YYYY-MM-DD}. Update when the runtime shape changes.

One-paragraph summary of what the system is and the key design idea.

## Runtime view

{deployment units, how they communicate — a simple text diagram is welcome}

## Data

{stores, main data flow, lifecycle}

## Failure handling

{what fails how, and what the system does about it}

## Observability

{logs / metrics / tracing — current state and gaps}

## Scaling considerations

{expected load, first bottleneck, planned mitigation}

## Design decisions

Significant decisions live in `docs/adr/` — this section only links the most relevant ones:

- [ADR-XXXX](../adr/ADR-XXXX-....md) — {one-line summary}
```

Rules:

- Write in the documentation language defined in `docs/context/project.md`.
- Keep it high-level — detailed component structure belongs in `docs/architecture/`.
- Every non-obvious design choice should reference an ADR (create one via
  `docs/prompts/adr.md` if it does not exist yet).
- Respect `.editorconfig` formatting rules.

## After completion

1. Check off the corresponding item in `docs/checklists/new-project.md` (if present).
2. Append to `docs/context/decisions.md`:

```markdown
## {YYYY-MM-DD} — System design guide generated

**Summary:** {one sentence — runtime shape and key design idea}
**Full document:** docs/guides/system-design.md
```
