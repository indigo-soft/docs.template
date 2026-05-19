# Prompt: Create an AI Interaction Document (AID)

## Purpose

Help the user write a well-structured AID and save it to `docs/aid/`.

An AID documents a significant AI interaction — what was asked, what was produced,
how it was evaluated, and what was adopted or rejected. AIDs serve as an audit trail
of AI-assisted work and a learning resource for future interactions.

AID is distinct from:

- **ADR** — documents an architectural decision (what + why)
- **AIR** — documents a conflict between ADRs
- **AID** — documents the AI collaboration process itself (how the work was done with AI)

## Prerequisites

Read `docs/context/project.md` and `docs/aid/INDEX.md` before asking anything.
Use known facts silently. Determine the next AID number from the index.

## Questions to ask

1. **What was the AI interaction about?**
   Ask for a short title (3–5 words, becomes the filename and heading).

2. **What AI system and model was used?**
   (e.g. Claude Sonnet 4.6, GPT-4o, GitHub Copilot)

3. **What was the goal?**
   What problem or task prompted this interaction?

4. **What was the prompt or task given to the AI?**
   Summarize or paste the key parts. If a prompt file in `docs/prompts/` was used, link to it.

5. **What did the AI produce?**
   Describe the output: code, document, decision, analysis, design, etc.

6. **How was the output evaluated?**
   What criteria were used? Was it reviewed manually, tested, compared to alternatives?

7. **What was adopted, modified, or rejected — and why?**
   Be specific: "Used as-is", "Used with changes (describe)", "Rejected because...".

8. **What changed in the project as a result?**
   Link to affected files, ADRs, or other AIDs.

9. **What was learned?**
   - What prompting strategies worked well?
   - What would you do differently next time?
   - Strengths or limitations of the AI for this type of task?

## Output

Determine the next AID number from `docs/aid/INDEX.md`.
Use zero-padded 4-digit numbers (`0001`, `0042`).

Create `docs/aid/AID-{NUMBER}-{kebab-case-title}.md` using
`docs/aid/template/AID-TEMPLATE.md` as the base.

After creating the file, add an entry to `docs/aid/INDEX.md`:

```markdown
| [AID-{NUMBER}](AID-{NUMBER}-{title}.md) | {Short description} | {AI system} | Accepted | {date} |
```

Rules:

- Be honest about what was rejected and why — AIDs are a learning record, not a success log.
- Write in English.
- Respect `.editorconfig` formatting rules.

## After completion

Append to `docs/context/decisions.md`:

```markdown
## {YYYY-MM-DD} — AID-{NUMBER}: {Title}

**Summary:** {one sentence on what was done and what was adopted}
**Full record:** docs/aid/AID-{NUMBER}-{kebab-case-title}.md
```
