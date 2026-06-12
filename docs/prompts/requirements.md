# Prompt: Generate Requirements Guide

## Purpose

Generate `docs/guides/requirements.md` — a document that captures what the project must do
(functional requirements) and the qualities it must have (non-functional requirements).
It is the reference point for scoping features and evaluating trade-offs.

## Prerequisites

Read `docs/context/project.md` first. If it does not exist or is not filled in,
run `docs/prompts/onboarding.md` before this prompt.

## Questions to ask

Ask one group at a time. Skip anything already known from `docs/context/project.md`
or other project files.

### Group 1 — Functional requirements

1. **Core capabilities** — what are the 3–7 things the system must do?
   (e.g. "sort music files by metadata", "process payments", "generate reports")
2. **Primary users / actors** — who or what interacts with the system?
   (people, other services, scheduled jobs)
3. **Key user flows** — for each core capability, what does the happy path look like?
4. **Explicit non-goals** — what is deliberately out of scope?

### Group 2 — Non-functional requirements

5. **Performance** — any latency, throughput, or volume expectations?
   ("handles 10k files per run", "API responds under 200 ms")
6. **Reliability** — acceptable downtime, data loss tolerance, recovery expectations?
7. **Security & privacy** — authentication, authorization, sensitive data, compliance?
8. **Compatibility** — OS, browsers, runtime versions, integration constraints?

### Group 3 — Constraints

9. **Hard constraints** — budget, deadlines, mandated technologies, legal requirements?
10. **Assumptions** — what is assumed to be true that, if false, would change the requirements?

## Output

Create or overwrite `docs/guides/requirements.md`:

```markdown
# Requirements

> Last updated: {YYYY-MM-DD}. Update when scope or constraints change.

Short intro: what the project does and for whom (1–2 sentences from project.md).

## Functional requirements

| ID   | Requirement  | Priority              | Notes |
| ---- | ------------ | --------------------- | ----- |
| FR-1 | {capability} | Must / Should / Could | ...   |

## Non-goals

- {explicitly out of scope item}

## Non-functional requirements

| ID    | Category    | Requirement              |
| ----- | ----------- | ------------------------ |
| NFR-1 | Performance | {measurable expectation} |
| NFR-2 | Security    | {requirement}            |

## Constraints

- {hard constraint}

## Assumptions

- {assumption and what happens if it breaks}
```

Rules:

- Write in the documentation language defined in `docs/context/project.md`.
- Make requirements **testable** — prefer measurable statements over vague ones.
- Use MoSCoW priorities (Must / Should / Could) for functional requirements.
- Respect `.editorconfig` formatting rules.

## After completion

1. Check off the corresponding item in `docs/checklists/new-project.md` (if present).
2. Append to `docs/context/decisions.md`:

```markdown
## {YYYY-MM-DD} — Requirements guide generated

**Summary:** {one sentence — core scope and the most important constraint}
**Full document:** docs/guides/requirements.md
```
