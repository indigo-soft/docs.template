# Prompt: Create an Architecture Decision Record (ADR)

## Purpose

Help the user write a well-structured ADR and save it to `docs/adr/`.

An ADR documents a significant architectural or technical decision: what was decided,
why, what alternatives were considered, and what consequences are expected.

## Prerequisites

Read `docs/context/project.md` and `docs/adr/INDEX.md` (if it exists) to understand
project context and the next available ADR number.

## Questions to ask

1. **What decision needs to be documented?**
   Ask for a short title (will become the filename and heading).

2. **What is the status of this decision?**
   (proposed / accepted / deprecated / superseded)

3. **What is the context?**
   What situation, problem, or constraint led to this decision being needed?

4. **What options were considered?**
   List each option with a brief description. Ask for at least two.

5. **For each option — what are the pros and cons?**
   Go through them one by one if the user hasn't listed them already.

6. **What was decided, and why?**
   Which option was chosen, and what was the primary reason?

7. **What are the consequences?**
   Positive outcomes are expected. Negative trade-offs are accepted. Risks.

8. **Does this decision affect or supersede any previous ADR?**
   If yes, which one?

## Output

Determine the next ADR number from `docs/adr/INDEX.md` or by listing `docs/adr/`.
Use zero-padded 4-digit numbers (e.g. `0001`, `0042`).

Create the file `docs/adr/ADR-{NUMBER}-{kebab-case-title}.md` using the template
from `docs/adr/template/ADR-TEMPLATE.md` if it exists, otherwise use this structure:

```markdown
# ADR-{NUMBER}: {Title}

**Status:** {status}
**Date:** {YYYY-MM-DD}
**Deciders:** {who was involved}

## Context

{What situation led to this decision}

## Considered Options

### Option 1: {name}

{description}

**Pros:** ...
**Cons:** ...

### Option 2: {name}

...

## Decision

{What was decided and why}

## Consequences

### Positive

- ...

### Negative / Trade-offs

- ...

### Risks

- ...

## Related ADRs

- Supersedes: ADR-{NUMBER} (if applicable)
- Related to: ADR-{NUMBER} (if applicable)
```

After creating the file, add an entry to `docs/adr/INDEX.md`:

```text
| ADR-{NUMBER} | {Title} | {status} | {date} |
```

Rules:

- Write in English (unless the project has a different language policy in `docs/context/project.md`).
- Respect `.editorconfig` formatting rules.
- Be specific — avoid vague justifications like "it was simpler".

## After completion

Append to `docs/context/decisions.md`:

```text
## {YYYY-MM-DD} — ADR-{NUMBER}: {Title}
**Summary:** {one sentence decision summary}
**Full record:** docs/adr/ADR-{NUMBER}-{kebab-case-title}.md
```
