# AGENTS Guide

## What this repository is

This is a **documentation and tooling template** for software projects.
It provides a ready-to-use structure for: commit conventions, release flow, git hooks,
documentation guides, ADR/AIR processes, AI-assisted onboarding prompts, and project memory.

The goal: clone this repo, run the onboarding prompt, and have a new project with consistent
conventions and documentation from day one — without writing 20 documents from scratch.

## Repository map

```
docs/
    context/            ← project memory (Claude reads this; humans browse it)
        project.md      ← core project facts from onboarding
        decisions.md    ← append-only log of decisions (ADR-level and below)
        sessions/       ← optional per-session summaries
    prompts/            ← Claude prompts for generating project-specific documents
        onboarding.md   ← run this first; fills docs/context/project.md
        agents.md       ← generates AGENTS.md
        architecture.md ← generates docs/architecture/*
        coding-standards.md
        deployment.md
        testing.md
        adr.md          ← guides creation of a single ADR
        air.md          ← guides creation of a single AIR
    checklists/
        new-project.md  ← master checklist; Claude updates it after each step
    adr/                ← Architecture Decision Records
        template/
        archive/
    air/                ← AI Interaction Records
        template/
    architecture/       ← overview.md, components.md, modules.md
    guides/             ← git-workflow, coding-standards, deployment, testing, etc.

scripts/
    release/            ← release automation scripts
    libs/               ← shared shell utilities

src/                    ← placeholder; not used in this template repo

AGENTS.md               ← this file
CONTRIBUTING.md         ← contribution guide and git workflow summary
commitlint.config.js    ← commit message and branch name validation rules
lefthook.yml            ← git hooks: pre-commit, commit-msg, pre-push
package.json            ← release scripts and dev dependencies
.editorconfig           ← formatting contract for all files
```

## Available commands

| Command              | Description                                                      |
|----------------------|------------------------------------------------------------------|
| `pnpm install`       | Install dev dependencies (commitlint, lefthook, release-it)      |
| `pnpm prepare`       | Install lefthook git hooks + make scripts executable             |
| `pnpm release`       | Interactive release (auto-detects bump type from commits)        |
| `pnpm release:dry`   | Dry-run release — shows what would happen without making changes |
| `pnpm release:patch` | Release a patch version bump                                     |
| `pnpm release:minor` | Release a minor version bump                                     |
| `pnpm release:major` | Release a major version bump                                     |

## Conventions agents must follow

- **Formatting:** respect `.editorconfig` globally — UTF-8, LF endings, final newline,
  trailing whitespace trimmed, 4-space indent (2-space for shell and JSON files), max 120 chars/line.
- **Commit format:** `<type>(<scope>): <description>` — scope is required, type must be from
  the allowed list in `commitlint.config.js`.
- **Branch format:** `<type>/<issue-number>-<description>` — issue number is required,
  minimum 4 digits (e.g. `feature/0001-setup-docs`).
- **Documentation lives in `docs/`** — do not create documentation files in the project root.
- **Prompts live in `docs/prompts/`** — one file per document type, English only.
- **Context files are append-only** — never delete or rewrite existing entries in `decisions.md`.
- **Checklists are updated after work** — mark items done in `docs/checklists/new-project.md`
  after completing the corresponding task.

## Tooling and workflows

- **Lefthook** manages git hooks — configured in `lefthook.yml`:
    - `pre-commit`: formats and lints staged files
    - `commit-msg`: runs commitlint to validate message format
    - `pre-push`: runs typecheck and tests
- **commitlint** validates commit messages and branch names — config in `commitlint.config.js`.
- **release-it** handles versioning and changelog — config in `scripts/.release-it.json`.

## Architecture and integration notes

- This repo has no runtime application — it is a template, not a service.
- `src/` is a placeholder for when this template is used as a base for an app repo.
- No database, no API, no external service integrations in this repo itself.
- The `.idea/php.xml` file reflects IDE configuration only — do not assume PHP runtime.

## Agent operating guidance

**DO:**

- Read `docs/context/project.md` at the start of any session involving a real project built from this template.
- Append to `docs/context/decisions.md` after making any non-obvious choice.
- Update `docs/checklists/new-project.md` after completing a task.
- Use prompts in `docs/prompts/` as the source of truth for how to generate each document type.
- Ask for the project's onboarding context before generating any project-specific document.

**DO NOT:**

- Rewrite or delete existing entries in `docs/context/decisions.md`.
- Create documentation files outside of `docs/`.
- Modify `pnpm-lock.yaml` manually.
- Invent commit scopes — use only the scopes defined in `commitlint.config.js` or listed in `docs/context/project.md`.
- Assume this is a PHP project because `.idea/php.xml` exists — it is IDE configuration only.
