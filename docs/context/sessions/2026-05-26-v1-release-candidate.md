# Session: 2026-05-26 — v1.0 release candidate — new structure, glossary, RFC, checklists, CI split

## What was done

### New document types

- `docs/rfc/` — RFC (Request for Comments) process added: README, INDEX, template, archive
- `docs/glossary.md` — project glossary with `###` headings for direct anchor linking

### New guides (`docs/guides/`)

- `onboarding.md` — step-by-step guide for new team members
- `code-review.md` — principles and what to check during review
- `docs-style-guide.md` — tone, structure, formatting, language conventions

### New checklists (`docs/checklists/`)

- `code-review.md` — pre-approve checklist for reviewers (human-focused)
- `release.md` — combined human + AI release checklist (AI executes, human confirms blocks)
- `new-feature.md` — combined human + AI new feature checklist (5 blocks, from goal to done)

### CI split (`.github/workflows/`)

- `ci.yml` removed
- `lint.yml` — two separate jobs: markdownlint and prettier check
- `check-links.yml` — internal link checking on push/PR + weekly schedule via lychee

### ADR

- `ADR-0014-rfc-process.md` — documents the decision to add RFC alongside ADR/AIR/AID
- `ADR INDEX.md` updated with ADR-0014 and link to RFC README

### Prompts (`docs/prompts/`)

- `security.md` — prompt for filling in SECURITY.md with project-specific values
- `contributing.md` — prompt for generating CONTRIBUTING.md with real scopes and rules
- `readme.md` — updated with glossary linking step (scan, link first occurrence, add missing terms)

### AGENTS.md

- Repository map updated (RFC, new guides, new checklists, glossary)
- Two new conventions: glossary maintenance, glossary linking in READMEs
- DO/DO NOT lists updated accordingly

### README.md and ROADMAP.md

- README updated: new rows in What's included, Documentation table, CI description
- ROADMAP updated: status changed to "release candidate", completed items checked,
  v1.0 criteria revised to 3 remaining items

### Markdownlint config

- `MD040` (fenced-code-language) disabled — no language required on code blocks

## Key decisions

- RFC uses "Parked" status for ideas that are good but not yet timely
- Glossary terms use `###` headings (not bold) to enable direct anchor links
- Self-referential `### Glossary` entry removed from glossary (circular and triggers MD024)
- `### Glossary` duplicate heading issue resolved by removal, not by disabling MD024
- Checklists for release and new-feature are "human + AI combined" — AI executes steps,
  human confirms each block before proceeding
- CI split into separate files (`lint.yml`, `check-links.yml`) rather than one `ci.yml` with jobs

## State at end of session

docs.template: ready for `npm run release:major` → v1.0.0

Remaining before release:

- `pnpm lint && pnpm format` to verify clean state
- Commits for this session's changes
- `npm run release:major`

## What is next (v1.0 backlog)

- Verify all prompts on a TypeScript/Node.js project
- Add `docs/prompts/security.md` prompt testing on a real project
- GitHub Actions automated release workflow (backlog)
- Script for auto-generating INDEX.md files (backlog)
