# Prompt: Create an AI Interaction Record (AIR)

## Purpose

Help the user write a well-structured AIR and save it to `docs/air/`.

An AIR documents a significant interaction with an AI system that produced a decision,
artifact, or insight worth preserving — capturing what was asked, what the AI produced,
how it was evaluated, and whether it was adopted.

AIRs are not about the AI tool itself (that belongs in an ADR) — they are about
a specific AI-assisted outcome and its impact on the project.

## Prerequisites

Read `docs/context/project.md` and `docs/air/INDEX.md` (if it exists) to understand
project context and the next available AIR number.

## Questions to ask

1. **What was the AI interaction about?**
   Ask for a short title (will become the filename and heading).

2. **What AI system and model was used?**
   (e.g. Claude Sonnet 4.5, GPT-4o, Gemini 1.5 Pro, GitHub Copilot)

3. **What was the goal of the interaction?**
   What problem were you trying to solve, or what were you trying to generate?

4. **What was the prompt or task given to the AI?**
   Summarize or paste the key parts of the prompt. Full prompt optional.

5. **What did the AI produce?**
   Describe the output: code, document, decision, analysis, design, etc.

6. **How was the output evaluated?**
   What criteria were used? Was it reviewed manually, tested, compared to alternatives?

7. **What was adopted, modified, or rejected — and why?**
   Be specific: "Used as-is", "Used with changes (describe)", "Rejected because...".

8. **What is the impact on the project?**
   What changed as a result of this interaction?

9. **What was learned?**
   Insights about the AI's strengths or limitations for this type of task.
   Prompting strategies that worked or didn't.

## Output

Determine the next AIR number from `docs/air/INDEX.md` or by listing `docs/air/`.
Use zero-padded 4-digit numbers (e.g. `0001`, `0042`).

Create the file `docs/air/AIR-{NUMBER}-{kebab-case-title}.md` using the template
from `docs/air/template/AIR-TEMPLATE.md` if it exists, otherwise use this structure:

```markdown
# AIR-{NUMBER}: {Title}

**Status:** {draft / accepted / archived}
**Date:** {YYYY-MM-DD}
**AI System:** {model name and version}
**Author:** {who ran the interaction}

## Goal

{What problem or task this interaction was meant to address}

## Prompt Summary

{Summary of what was asked. Include full prompt in a code block if relevant.}

## AI Output Summary

{What the AI produced — describe type and key content}

## Evaluation

{How the output was assessed and by whom}

## Outcome

{What was adopted / modified / rejected and why}

## Project Impact

{What changed in the project as a result}

## Lessons Learned

{What was learned about using AI for this type of task}

## Related

- Related ADR: ADR-{NUMBER} (if applicable)
- Related AIR: AIR-{NUMBER} (if applicable)
```

After creating the file, add an entry to `docs/air/INDEX.md`:

```
| AIR-{NUMBER} | {Title} | {status} | {date} | {AI system} |
```

Rules:

- Write in English (unless the project has a different language policy in `docs/context/project.md`).
- Respect `.editorconfig` formatting rules.
- Be honest about what was rejected and why — AIRs are a learning record, not a success log.

## After completion

Append to `docs/context/decisions.md`:

```
## {YYYY-MM-DD} — AIR-{NUMBER}: {Title}
**Summary:** {one sentence on what was done and adopted}
**Full record:** docs/air/AIR-{NUMBER}-{kebab-case-title}.md
```
