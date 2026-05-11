# Session: 2026-05-11 — Initial docs.template build

## What was done

### Structure created

- `docs/context/` — project memory (project.md, decisions.md, sessions/, README.md)
- `docs/prompts/` — Claude prompts for generating project-specific documents
- `docs/checklists/` — new-project.md master checklist
- `.gitkeep` added to all empty tracked directories

### Prompts written (`docs/prompts/`)

- `onboarding.md` — 4 question groups, saves to `docs/context/project.md`, run first
- `agents.md`, `architecture.md`, `coding-standards.md`, `deployment.md`, `testing.md`
- `adr.md`, `air.md` — guide through creating a single record, auto-update INDEX + decisions.md

### Guides written (`docs/guides/`)

- `git-workflow.md` — GitHub Flow + Conventional Commits; scopes reference `context/project.md`
- `git-config.md` — one-time local setup
- `release-flow.md` — release-it workflow, commands, troubleshooting
- `naming-conventions.md` — git, TypeScript, files, DB, API, tests
- `updating-dependencies.md` — Renovate + Dependabot workflow

Intentionally left as prompts (too project-specific): `coding-standards`, `deployment`, `testing`.

### ADRs written (`docs/adr/`) — ADR-0001 through ADR-0007

- ADR-0001 Git Workflow and Branching Strategy
- ADR-0002 Package Manager (pnpm)
- ADR-0003 Native Development without Docker
- ADR-0004 Security Strategy
- ADR-0005 Git Hooks (Lefthook) — starts with Lefthook directly, no Husky migration
- ADR-0006 Changelog Automation (release-it)
- ADR-0007 Automated Dependency Management (Renovate + Dependabot)

Plus: `INDEX.md`, `README.md`, `template/ADR-TEMPLATE.md` filled in.

### AIR documentation (`docs/air/`)

- `README.md` — what AIRs are, lifecycle, naming, how to create and resolve
- `INDEX.md` — empty index with Open / Resolved tables
- `template/AIR-TEMPLATE.md` — full annotated template (EN)

### AGENTS.md

- Fully rewritten to reflect the actual project state

## What is next

- Test the prompts on a real project (onboarding → agents → architecture)
- Verify the checklists work as expected
- Potentially add an `air.md` prompt to `docs/prompts/` (currently only `adr.md` exists)

## Key decisions made this session

See `docs/context/decisions.md` for the full log.
