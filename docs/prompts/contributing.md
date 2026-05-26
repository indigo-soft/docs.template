# Prompt: Generate CONTRIBUTING.md

## Purpose

Generate or update `CONTRIBUTING.md` in the project root with project-specific
contribution guidelines. The template version is generic — this prompt produces
a version tailored to the actual stack, scopes, and workflow of the project.

## Prerequisites

Read `docs/context/project.md` silently before asking anything.
Use all known facts without re-asking them — especially commit scopes, stack,
package manager, and CI/CD platform.

## Questions to ask

Ask only what is not already known from project context:

1. **Contribution scope** — who is this guide for?
   (e.g. internal team only, open source contributors, both)

2. **Setup complexity** — is local setup covered by `pnpm run init` alone,
   or are there additional steps (database, services, secrets)?

3. **PR merge strategy** — Squash and Merge / Rebase / Merge commit?

4. **Review requirements** — how many approvals before merge?
   Is CI required to pass before merge?

5. **Issue requirement** — is a GitHub Issue required before opening a PR?
   Or are small PRs allowed without one?

6. **Project-specific rules** — any contribution rules specific to this project?
   (e.g. "all new API endpoints must have an ADR", "UI changes require screenshots")

## Output

Generate `CONTRIBUTING.md` with the following sections (skip what doesn't apply):

```markdown
# Contributing Guide

{One sentence: who this is for and what the project is}

## Before you start

{Prerequisites: read the workflow guide, set up local environment, review CoC}

## Local setup

{Setup steps specific to this project}

## Branching and commits

{Branch format, commit format, scopes — pulled from project context}

## Opening a pull request

{PR checklist, merge strategy, review requirements}

## Adding documentation

{Where different doc types go, when an ADR is needed}

## Reporting bugs

{How to open an issue, what to include}

## Security vulnerabilities

{Short section pointing to SECURITY.md}

## License

{License acknowledgment}
```

## Rules

- Pull commit scopes from `docs/context/project.md` — do not invent or omit them
- Reference `docs/guides/git-workflow.md` rather than duplicating its content
- Keep it short — CONTRIBUTING.md is an entry point, not a complete guide
- Write in English
- Respect `.editorconfig` formatting rules

## Glossary linking

After generating, scan for terms defined in `docs/glossary.md` and link the first
occurrence of each: `[ADR](docs/glossary.md#adr)`, `[RFC](docs/glossary.md#rfc)`, etc.

## After completion

Append to `docs/context/decisions.md`:

```markdown
## {YYYY-MM-DD} — CONTRIBUTING.md generated

**Audience:** {internal / open source / both}
**Merge strategy:** {squash / rebase / merge commit}
**Key rules:** {any project-specific rules worth noting}
```
