# Architecture Decision Records (ADR)

This directory contains Architecture Decision Records — documents that capture significant
architectural and technical decisions, why they were made, and what their consequences are.

**Navigation:**

- 📋 [INDEX.md](INDEX.md) — full list of all ADRs
- ⚡ [air/](../air/) — AI Interaction Records

---

## What is an ADR?

An ADR captures:

- **What** was decided
- **Why** this decision and not the alternatives
- **What** the consequences are

### When to create an ADR

Create an ADR when making decisions about:

- 🏗️ **Architecture** — framework choice, project structure, patterns
- 🛠️ **Technology** — database, queue, logging, package manager
- 📐 **Process** — git workflow, testing strategy, deployment approach
- 🔒 **Constraints** — security policies, performance requirements
- 🔄 **Migrations** — switching from one technology to another

### When NOT to create an ADR

❌ Small implementation details (which date formatting library to use)
❌ Obvious decisions
❌ Temporary workarounds
❌ Code style (use ESLint config for that)

---

## How to create a new ADR

### 1. Find the next number

```bash
ls docs/adr/*.md | sort | tail -1
```

### 2. Copy the template

```bash
cp docs/adr/template/ADR-TEMPLATE.md docs/adr/ADR-0008-your-decision.md
```

### 3. Fill in the sections

- **Status**: start with `Proposed`
- **Context**: why did this question arise?
- **Decision**: what was decided?
- **Considered Options**: what alternatives were evaluated and why were they rejected?
- **Rationale**: why this specific decision?
- **Consequences**: what changes (positive, negative, neutral)?

### 4. Check for conflicts

Does the new decision conflict with an existing ADR?
If yes — create an AIR first. See `docs/air/README.md`.

### 5. Add to the index

Update the table in [INDEX.md](INDEX.md).

---

## ADR Lifecycle

```text
Proposed → Accepted → Deprecated → Superseded
           ↓
         Rejected
```

| Status         | Meaning                                 |
| -------------- | --------------------------------------- |
| **Proposed**   | Under discussion, decision not yet made |
| **Accepted**   | Decision made and in effect             |
| **Deprecated** | Outdated but still used in code         |
| **Superseded** | Replaced by another ADR (link to it)    |
| **Rejected**   | Rejected (explain why in the ADR)       |

---

## Archiving superseded ADRs

When an ADR is **Superseded**, move it to `archive/`:

1. Update its status: `Superseded by [ADR-XXXX](../XXXX-new-decision.md)`
2. Move the file: `mv docs/adr/ADR-0001-old.md docs/adr/archive/`
3. Update `INDEX.md`: set status to `Superseded`, update path
4. In the new ADR: add `Supersedes: [ADR-0001](archive/ADR-0001-old.md)`

Files in `archive/` are never deleted — only moved.

---

## File naming

```text
ADR-XXXX-short-descriptive-title.md
```

- `XXXX` — zero-padded 4-digit number (0001, 0042, 0100)
- `short-descriptive-title` — kebab-case, English

---

## Best practices

✅ Write ADRs **when** you make the decision, not months later
✅ Be honest about downsides
✅ Describe the alternatives you considered
✅ Use specific examples and data
✅ Keep it concise (1–3 pages)
✅ Check for conflicts with existing ADRs

❌ Don't write ADRs a month after the decision
❌ Don't ignore downsides
❌ Don't skip alternatives ("we just chose X")
❌ Don't write 10-page essays
