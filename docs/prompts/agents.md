# Prompt: Generate AGENTS.md

## Purpose

Generate or update the `AGENTS.md` file in the project root.
`AGENTS.md` is the primary orientation document for AI agents (Claude, Copilot, etc.) — it tells them
what this repository is, how it is structured, what commands are available, and what conventions to follow.

## Prerequisites

Before asking questions, check if `docs/context/project.md` exists and read it.
Use any already-known facts silently — do not ask for information that is already there.

## Questions to ask

Ask the user only what is not already known from `docs/context/project.md`:

1. **Repository type** — What kind of project is this?
   (e.g. backend API, frontend SPA, monorepo, CLI tool, library, docs-only, fullstack)

2. **Source layout** — What are the top-level directories and what does each contain?
   (e.g. `src/`, `packages/`, `apps/`, `libs/`, `tests/`)

3. **Available commands** — What commands does a developer run day-to-day?
   Ask for: install, build, test, lint, format, type-check, dev server, migration, release.
   Accept "none yet" or "not applicable" as valid answers.

4. **Tech stack specifics** — What language(s), frameworks, and major libraries are used?
   (Only ask if not already in project context.)

5. **Special conventions** — Any project-specific rules an agent must know?
   (e.g. "never edit generated files in `src/generated/`", "always run migrations before tests")

6. **Agent restrictions** — Anything agents should never do in this repo?
   (e.g. "do not modify `pnpm-lock.yaml` manually", "do not create files outside `src/`")

## Output

Generate `AGENTS.md` in the project root with the following sections:

```
# AGENTS Guide

## What this repository is
## Repository map
## Available commands
## Conventions agents must follow
## Tooling and workflows
## Architecture and integration notes
## Agent operating guidance
```

Rules for the output:

- Be concrete and specific — use actual file paths, command names, directory names.
- Keep each bullet to one clear fact. No vague statements like "follow best practices".
- "Available commands" must list the exact commands with short descriptions.
- "Agent operating guidance" must include at least one DO and one DO NOT per concern.
- Write in English.
- Respect `.editorconfig`: UTF-8, LF, 4-space indent, final newline, max 120 chars per line.

## After completion

1. Mark `agents.md` as done in `docs/checklists/new-project.md`.
2. Append an entry to `docs/context/decisions.md` describing any non-obvious choices made
   while writing the file (e.g. why certain restrictions were added).
