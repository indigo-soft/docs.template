# Prompt: Create an Architecture Issue Record (AIR)

## Purpose

Help the user write a well-structured AIR and save it to `docs/air/`.

An AIR documents a **conflict between ADRs** — when a new decision contradicts an existing one,
or when two existing ADRs conflict when applied together.

AIR is distinct from:

- **ADR** — documents an architectural decision
- **AID** — documents an AI interaction (what Claude/Copilot produced and what was adopted)
- **AIR** — documents a conflict between ADRs that requires explicit resolution

## Prerequisites

Read `docs/context/project.md` and `docs/air/INDEX.md` (if it exists) before asking anything.

## Questions to ask

1. **What conflict needs to be documented?**
   Ask for a short title (will become the filename and heading).

2. **Which ADRs are in conflict?**
   List them with a one-line description of what each requires.

3. **What is the exact point of conflict?**
   Where do the two ADRs contradict each other in practice?

4. **What is the severity?**
   - **Critical** — blocks implementation; one cannot be applied without changing the other
   - **Moderate** — both can be applied, but an explicit exception or clarification is needed
   - **Low** — mostly theoretical; minimal practical impact

5. **What resolution paths exist?**
   Describe at least 2 options with pros and cons.

6. **What was decided?**
   Which path was chosen and why?

## Output

Create `docs/air/air-00N-short-conflict-description.md` using
`docs/air/template/AIR-TEMPLATE.md` as the base.

File naming rules:

- Open AIRs: `air-00N-short-conflict-description.md`
- Resolved AIRs: `done-air-00N-short-conflict-description.md`

After creating the file, add an entry to `docs/air/INDEX.md`.

After resolution:

1. Fill in the **Decision taken** section.
2. Update each affected ADR — add to its Related section:

   ```markdown
   - Conflict resolved by: [AIR-00N](../air/done-air-00N-....md)
   ```

3. Change status to `Resolved` and rename file with `done-` prefix.
4. Update `docs/air/INDEX.md`.

Rules:

- Write in English.
- Respect `.editorconfig` formatting rules.

## After completion

Append to `docs/context/decisions.md`:

```markdown
## {YYYY-MM-DD} — AIR-00N: {Title}

**Summary:** {one sentence on the conflict and how it was resolved}
**Full record:** docs/air/air-00N-{title}.md
```
