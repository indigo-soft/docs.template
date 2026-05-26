# Prompt: Generate README.md

## Purpose

Generate or update the `README.md` file in the project root.
`README.md` is the first thing a developer sees when they open the repository.
It must answer three questions immediately: what is this, how do I start, what can I do with it.

## Prerequisites

Read `docs/context/project.md` silently before asking anything.
Use all known facts without re-asking them.

## Questions to ask

Ask only what is not already known from project context:

1. **Project stage** — is this a new project (no existing README) or an update?
2. **Primary audience** — who will read this README?
   (e.g. new team members, open source contributors, internal developers only)
3. **Installation complexity** — is setup simple (one command) or multi-step?
4. **Key commands** — what are the 3–5 most important commands a developer runs day-to-day?
5. **Badges** — should the README include CI/CD status badges, version badges, license badge?
6. **Screenshots or demo** — does the project have a UI or CLI output worth showing?
7. **Contributing** — link to `CONTRIBUTING.md` or inline instructions?

## README structure

Generate `README.md` with the following sections (skip sections that don't apply):

```markdown
# {Project Name}

{One sentence description}

{Badges if requested}

---

## What is this

{2–3 sentences: what the project does, who it is for, what problem it solves}

## Quick start

{Minimal steps to get from zero to running — install, configure, run}

## Commands

{Table of the most important commands}

## Architecture

{Optional: 2–3 sentences on how it works, link to docs/architecture/overview.md}

## Documentation

{Table linking to key docs files}

## Contributing

{Short section or link to CONTRIBUTING.md}

## License

{License name + link to LICENSE.md}
```

## Rules

- Keep it short — a README is a door, not a room. Detailed docs go in `docs/`.
- Use a table for commands — easier to scan than a list.
- Use code blocks for all commands.
- Do not duplicate content from `CONTRIBUTING.md` or `docs/guides/` — link to them instead.
- Write in English.
- Respect `.editorconfig`: max 120 chars per line.

## Glossary linking

After generating the README, scan it for terms defined in `docs/glossary/glossary.md`.

For each term found:

- Link its **first occurrence** in the file using a relative path to the glossary anchor.
  Example: `[ADR](docs/glossary/glossary.md#adr)`, `[RFC](docs/glossary/glossary.md#rfc)`.
- Leave subsequent occurrences of the same term unlinked.
- If the term is inside a code block or a heading, do not link it.

After linking, check whether any terms used in the README are missing from `docs/glossary/glossary.md`.
If yes, add them to the glossary before committing (correct alphabetical section, `###` heading).

## After completion

Append to `docs/context/decisions.md`:

```markdown
## {YYYY-MM-DD} — README.md generated

**Audience:** {who it is for}
**Key decisions:** {anything non-obvious about structure or content}
**Glossary terms linked:** {list of terms linked, or "none"}
**Glossary terms added:** {list of new terms added to glossary, or "none"}
```
