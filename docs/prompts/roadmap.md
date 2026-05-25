# Prompt: Generate ROADMAP.md

## Purpose

Generate or update the `ROADMAP.md` file in the project root.
A roadmap communicates what the project is working toward — for contributors,
stakeholders, and the team itself. It is intentionally high-level; detailed
task tracking belongs in GitHub Issues or a project board.

## Prerequisites

Read `docs/context/project.md` silently before asking anything.
Use all known facts without re-asking them.

## Questions to ask

Ask only what is not already known from project context:

1. **Current version and status** — what is the current version and is it stable?
2. **Next milestone** — what is the next planned release and roughly when?
3. **Top 3–5 planned features or improvements** for the next milestone.
4. **Backlog items** — any ideas or requests that are not yet prioritized?
5. **Known limitations** — anything the project explicitly does NOT plan to support?
6. **Contribution** — are external contributions welcome for roadmap items?

## ROADMAP structure

Generate `ROADMAP.md` with the following sections:

```markdown
# Roadmap

{One sentence on the project's direction}

---

## Current — vX.Y (status: stable / beta / alpha)

{What the current version covers — 3–5 bullets}

---

## Next — vX.Y

{Target: Q{quarter} {year} or "when ready"}

- [ ] {Feature or improvement}
- [ ] {Feature or improvement}
- [ ] {Feature or improvement}

---

## Backlog

- [ ] {Idea not yet scheduled}
- [ ] {Idea not yet scheduled}

---

## Out of scope

{What this project explicitly will NOT do — helps set expectations}

---

## Contributing

{One sentence on how to contribute to the roadmap — e.g. open an issue, discussion}
```

## Rules

- Keep milestones high-level — no implementation details.
- Use checkboxes `- [ ]` for planned items so they can be checked off when done.
- Do not include specific dates unless they are firm commitments.
- "Out of scope" is optional but valuable — it prevents recurring feature requests.
- Write in English.
- Respect `.editorconfig`: max 120 chars per line.

## After completion

Append to `docs/context/decisions.md`:

```markdown
## {YYYY-MM-DD} — ROADMAP.md generated

**Next milestone:** {version and focus}
**Key decisions:** {anything non-obvious about scope or priorities}
```
