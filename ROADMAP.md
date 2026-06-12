# Roadmap

A documentation and tooling template that keeps getting better with each real project that uses it.

---

## Current — v1.0 (released; latest v1.0.3)

Template is functional and battle-tested on music.local (PHP CLI tool). Core workflow works:
clone → `pnpm run init` → onboarding prompt → docs generation → release cycle.

- ✅ 14 ADRs covering all major tooling and process decisions
- ✅ ADR / AIR / AID / RFC document types with templates, indexes, real examples, and archive
- ✅ `pnpm run init` — full project initialization wizard
- ✅ `pnpm start` — project status wizard with checklist progress
- ✅ release-it + Conventional Commits release automation
- ✅ Lefthook git hooks (pre-commit, commit-msg, pre-push)
- ✅ GitHub Actions CI — separate workflows: lint, format, link check
- ✅ Claude prompts for all major document types (including security, contributing, readme)
- ✅ Checklists for new project, code review, release, new feature (human + AI combined)
- ✅ Glossary with direct anchor links in `docs/glossary/`
- ✅ Guides: git workflow, onboarding, code review, release flow, docs style guide
- ✅ AGENTS.md reflects full v1.0 structure

---

## Next — v1.1

- [ ] All prompts verified on a TypeScript/Node.js project
- [ ] All prompts verified on a Python project
- [x] `docs/prompts/roadmap.md` — prompt for generating ROADMAP.md
- [x] `docs/prompts/requirements.md` and `docs/prompts/system-design.md` — prompts for the optional guides
- [x] `renovate.json` — Renovate configuration matching ADR-0007 (was documented but missing)
- [x] AIR process aligned with ADR/AID/RFC — 4-digit numbering, `archive/` folder instead of `done-` prefix

---

## Backlog

- [ ] GitHub Actions automated release workflow (push tag → release PR → merge = release)
- [ ] `pnpm run init` installs global tools in CI — replace manual `npm install -g` in workflows
- [ ] Multi-language docs support (e.g. `docs/en/`, `docs/uk/`)
- [ ] Example repository using docs.template as a reference implementation
- [ ] Script for auto-generating INDEX.md files (ADR, AIR, AID, RFC)

---

## Out of scope

- Runtime application code — this is a docs/tooling template, not an app starter
- Framework-specific scaffolding (use framework CLIs for that)
- Automated testing of documentation content

---

## Contributing

Open a GitHub Issue to suggest roadmap items or discuss priorities.
