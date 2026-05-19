# ADR-0009: Documentation Structure

**Status:** Accepted
**Date:** 2026-05-11

---

## Context

Every software project accumulates documentation in different forms: architectural decisions,
guides, templates, and increasingly — records of AI-assisted work. Without a deliberate
structure, documentation becomes scattered, hard to find, and hard to maintain.

This template needs a structure that:

- Separates different types of documentation by purpose
- Is easy to navigate for both humans and AI agents
- Supports project memory across sessions (especially for AI agents)
- Scales from small to large projects without restructuring

## Decision

Use the following directory structure under `docs/`:

```text
docs/
    adr/          ← Architecture Decision Records
    air/          ← Architecture Issue Records (ADR conflicts)
    aid/          ← AI Interaction Documents
    architecture/ ← System overview, components, modules
    checklists/   ← Setup and process checklists (Claude updates these)
    context/      ← Project memory (persists across AI sessions)
    guides/       ← How-to guides for recurring processes
    prompts/      ← Claude prompts for generating project-specific docs
```

## Considered Options

### Flat structure (all docs in `docs/`)

**Pros:** Simple, no nesting.
**Cons:** Becomes unnavigable quickly. No separation by purpose or audience.
**Verdict:** Rejected.

### Wiki-style (docs/wiki/)

**Pros:** Familiar to GitHub users.
**Cons:** No enforced structure; tends toward prose accumulation without templates.
**Verdict:** Rejected.

### Structured by type ✅ Chosen

**Pros:** Each directory has a clear purpose and README. Easy to add new document types.
Types with their own lifecycle (ADR, AIR, AID) get dedicated directories with INDEX files.
**Cons:** More directories to navigate initially.
**Verdict:** Accepted.

## Rationale for each directory

### `docs/adr/` — Architecture Decision Records

Captures significant architectural and technical decisions with full context, alternatives
considered, and consequences. Uses numbered files (`ADR-XXXX`) with an `INDEX.md`.
Superseded ADRs move to `archive/` rather than being deleted.

### `docs/air/` — Architecture Issue Records

Captures conflicts between ADRs. Separate from ADRs because they are temporary by nature —
the goal is always to resolve the conflict and update the affected ADRs.
Open AIRs use `air-00N-` prefix; resolved use `done-air-00N-`.

### `docs/aid/` — AI Interaction Documents

Captures significant AI interactions: what was asked, what was produced, what was adopted.
Serves as an audit trail and learning resource. See [ADR-0010](ADR-0010-ai-assisted-development.md).

### `docs/architecture/`

Three fixed documents: `overview.md`, `components.md`, `modules.md`.
Generated from the architecture prompt; updated as the system evolves.

### `docs/checklists/`

Structured checklists for setup and process verification. Claude updates these
automatically after completing tasks. The primary checklist is `new-project.md`.

### `docs/context/`

Project memory that persists across Claude sessions:

- `project.md` — core facts (stack, team, environments)
- `decisions.md` — append-only log of decisions below ADR threshold
- `sessions/` — optional per-session summaries

Claude reads `project.md` at the start of every session to avoid re-asking known facts.

### `docs/guides/`

How-to guides for recurring processes: git workflow, release flow, dependency updates, etc.
Generic guides live here permanently. Project-specific guides are generated from prompts.

### `docs/prompts/`

Claude prompts — one per document type. Running a prompt generates the corresponding
document. The `onboarding.md` prompt is always run first and populates `docs/context/project.md`.

## Language support

For multilingual projects, language-specific docs live in subdirectories:

```text
docs/
    en/
        guides/
        adr/
    uk/
        guides/
        adr/
```

Language-neutral directories (`context/`, `prompts/`, `checklists/`) stay at the root level.

## Consequences

### Positive

- Clear separation of concerns — each directory has one purpose
- AI agents can find project context predictably at `docs/context/project.md`
- New document types can be added without restructuring
- `archive/` subdirectories preserve history without cluttering active directories

### Negative

- More directories than a flat structure
- Developers must learn the structure conventions

### Neutral

- Each directory with lifecycle management has its own `README.md` and `INDEX.md`
- Prompts are first-class artifacts, versioned alongside the docs they generate

## Related ADRs

- [ADR-0010](ADR-0010-ai-assisted-development.md) — AI-assisted development and AID records
