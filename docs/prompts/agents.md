# Prompt: Generate AGENTS.md

## Purpose

Generate or update the `AGENTS.md` file in the project root.
`AGENTS.md` is the primary orientation document for AI agents (Claude, Copilot, etc.) — it tells them
what this repository is, how it is structured, what commands are available, and what conventions to follow.

## Prerequisites

1. Read `docs/context/project.md` — use all known facts silently, do not re-ask them.
2. Check if `AGENTS.md` already exists in the project root:
   - **If yes** — read it fully. Identify any project-specific sections (custom rules, non-standard
     patterns, domain-specific restrictions). These must be preserved and integrated into the new file.
     Use the docs.template structure as the base; merge existing content into it.
   - **If no** — generate from scratch using the structure below.

## Questions to ask

Ask the user only what is not already known from `docs/context/project.md` or the existing `AGENTS.md`:

1. **Repository type** — What kind of project is this?
   (e.g. backend API, frontend SPA, monorepo, CLI tool, library, docs-only, fullstack)

2. **Source layout** — What are the top-level directories and what does each contain?
   (e.g. `src/`, `packages/`, `apps/`, `libs/`, `tests/`)

3. **Available commands** — What commands does a developer run day-to-day?
   Ask for: install, build, test, lint, format, type-check, dev server, migration, release.
   Accept "none yet" or "not applicable" as valid answers.
   **Always include Node.js/pnpm commands** (see Node.js tooling note below).

4. **Tech stack specifics** — What language(s), frameworks, and major libraries are used?
   (Only ask if not already in project context.)

5. **Special conventions** — Any project-specific rules an agent must know?
   (e.g. "never edit generated files in `src/generated/`", "always run migrations before tests")

6. **Agent restrictions** — Anything agents should never do in this repo?
   (e.g. "do not modify `pnpm-lock.yaml` manually", "do not create files outside `src/`")

## Node.js tooling — always included

Every project uses Node.js dev tooling regardless of the primary language (PHP, Python, Go, etc.).
The following pnpm commands are always present in `AGENTS.md`:

| Command              | Description                                                         |
| -------------------- | ------------------------------------------------------------------- |
| `pnpm install`       | Install Node.js dev dependencies (commitlint, lefthook, release-it) |
| `pnpm prepare`       | Install lefthook git hooks                                          |
| `pnpm release:dry`   | Preview release — no changes made                                   |
| `pnpm release:patch` | Release a patch version bump                                        |
| `pnpm release:minor` | Release a minor version bump                                        |
| `pnpm release:major` | Release a major version bump                                        |

If `package.json` does not yet exist in the project, add a note:

> ⚠️ `package.json` is not yet present — run the Node.js tooling setup first.

## Output

Generate `AGENTS.md` in the project root with the following sections:

```text
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
- "Available commands" must list the exact commands with short descriptions,
  grouped by toolchain (e.g. PHP / Composer, Node.js / pnpm, Console).
- "Agent operating guidance" must include at least one DO and one DO NOT per concern.
- Project-specific sections from an existing `AGENTS.md` must be preserved — integrate them
  into the appropriate section, or keep as a named subsection if they don't fit elsewhere.
- Write in English.
- Respect `.editorconfig`: UTF-8, LF, 4-space indent, final newline, max 120 chars per line.

## After completion

1. Mark `agents.md` as done in `docs/checklists/new-project.md`.
2. Append an entry to `docs/context/decisions.md` describing any non-obvious choices made
   while writing the file (e.g. why certain restrictions were added, what was preserved from
   the existing file and why).
