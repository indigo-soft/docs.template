# AGENTS Guide

## What this repository is

This is a **documentation and tooling template** for software projects.
It provides a ready-to-use structure for: commit conventions, release flow, git hooks,
documentation guides, ADR/AIR/AID processes, AI-assisted onboarding prompts, and project memory.

The goal: clone this repo, run the onboarding prompt, and have a new project with consistent
conventions and documentation from day one — without writing 20 documents from scratch.

## Repository map

```text
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
        air.md          ← guides creation of a single AIR (ADR conflict)
        aid.md          ← guides creation of a single AID (AI interaction)
    checklists/
        new-project.md  ← master checklist; Claude updates it after each step
    adr/                ← Architecture Decision Records (ADR-XXXX)
        template/
        archive/
    air/                ← Architecture Issue Records — ADR conflicts only
        template/
    aid/                ← AI Interaction Documents (AID-XXXX)
        template/
        archive/
    architecture/       ← overview.md, components.md, modules.md
    guides/             ← git-workflow, release-flow, git-config, naming-conventions,
                           updating-dependencies

scripts/
    release/            ← release automation scripts
    libs/               ← shared shell utilities

src/                    ← placeholder; not used in this template repo

AGENTS.md               ← this file
CONTRIBUTING.md         ← contribution guide and git workflow summary
commitlint.config.mjs   ← commit message and branch name validation rules
lefthook.yml            ← git hooks: pre-commit, commit-msg, pre-push
package.json            ← scripts and dev dependencies
.editorconfig           ← formatting contract for all files
```

## Available commands

| Command                 | Description                                                      |
| ----------------------- | ---------------------------------------------------------------- |
| `pnpm install`          | Install dev dependencies (lefthook)                              |
| `pnpm run init`         | Install lefthook git hooks + make scripts executable             |
| `pnpm lint`             | Run markdownlint on all markdown files                           |
| `pnpm lint:fix`         | Auto-fix markdownlint issues                                     |
| `pnpm format`           | Format all files with Prettier                                   |
| `pnpm format:check`     | Check formatting without making changes                          |
| `npm run release:dry`   | Dry-run release — shows what would happen without making changes |
| `npm run release:patch` | Release a patch version bump                                     |
| `npm run release:minor` | Release a minor version bump                                     |
| `npm run release:major` | Release a major version bump                                     |

> Use `npm run` for release commands (not `pnpm run`) to avoid ELIFECYCLE noise.

## Global tools required

Due to pnpm's isolated linker behavior on WSL2, the following tools must be installed
globally via npm. They are NOT in `devDependencies` — installing them locally via pnpm
produces text redirect files instead of real symlinks, which Node.js cannot resolve
in git hook subprocess context.

```bash
npm install -g commitlint @commitlint/cli @commitlint/config-conventional
npm install -g release-it @release-it/conventional-changelog
npm install -g prettier markdownlint-cli2
```

> ⚠️ This is a WSL2 + pnpm v11 specific workaround. On native Linux or macOS with pnpm,
> local installation may work correctly.

## Conventions agents must follow

- **Formatting:** respect `.editorconfig` globally — UTF-8, LF endings, final newline,
  trailing whitespace trimmed, 4-space indent (2-space for shell and JSON files), max 120 chars/line.
- **Commit format:** `<type>(<scope>): <description>` — scope is required, type must be from
  the allowed list in `commitlint.config.mjs`.
- **Branch format:** `<type>/<issue-number>-<description>` — issue number is required,
  minimum 4 digits (e.g. `feature/0001-setup-docs`).
- **Documentation lives in `docs/`** — do not create documentation files in the project root.
- **Prompts live in `docs/prompts/`** — one file per document type, English only.
- **Context files are append-only** — never delete or rewrite existing entries in `decisions.md`.
- **Checklists are updated after work** — mark items done in `docs/checklists/new-project.md`
  after completing the corresponding task.
- **AID documents capture AI work** — after a significant AI interaction, create an AID in `docs/aid/`.

## Tooling and workflows

- **Lefthook** manages git hooks — configured in `lefthook.yml`:
  - `pre-commit`: formats staged files with Prettier, lints markdown with markdownlint
  - `commit-msg`: runs commitlint to validate message format
  - `pre-push`: runs lint + format check
- **commitlint** validates commit messages and branch names — config in `commitlint.config.mjs`.
- **release-it** handles versioning and changelog — config in `scripts/.release-it.json`.
- **markdownlint-cli2** lints all markdown files — config in `.markdownlint.jsonc`.
- **Prettier** formats all files — config in `.prettierrc`.

## Architecture and integration notes

- This repo has no runtime application — it is a template, not a service.
- `src/` is a placeholder for when this template is used as a base for an app repo.
- No database, no API, no external service integrations in this repo itself.

## Agent operating guidance

**DO:**

- Read `docs/context/project.md` at the start of any session involving a real project built from this template.
- Append to `docs/context/decisions.md` after making any non-obvious choice.
- Update `docs/checklists/new-project.md` after completing a task.
- Use prompts in `docs/prompts/` as the source of truth for how to generate each document type.
- Ask for the project's onboarding context before generating any project-specific document.
- Install global tools (see above) before running git hooks or release scripts.
- Create an AID in `docs/aid/` after any significant AI interaction.

**DO NOT:**

- Rewrite or delete existing entries in `docs/context/decisions.md`.
- Create documentation files outside of `docs/`.
- Modify `pnpm-lock.yaml` manually.
- Invent commit scopes — use only the scopes defined in `commitlint.config.mjs`.
- Add commitlint, release-it, or prettier to `devDependencies` — they must be global.
- Run `pnpm setup` to install hooks — use `pnpm run init` instead.
- Confuse AIR (ADR conflicts) with AID (AI interactions) — they are different document types.
