# Roadmap

A documentation and tooling template that keeps getting better with each real project that uses it.

---

## Current — v0.x (status: release candidate)

Template is functional and battle-tested on music-resort (PHP CLI tool). Core workflow works:
clone → `pnpm run init` → onboarding prompt → docs generation → release cycle.

- ✅ 13 ADRs covering all major tooling decisions
- ✅ ADR / AIR / AID / RFC document types with templates, indexes, prompts, and archive
- ✅ `pnpm run init` — full project initialization wizard
- ✅ `pnpm start` — project status wizard with checklist progress
- ✅ release-it + Conventional Commits release automation
- ✅ Lefthook git hooks (pre-commit, commit-msg, pre-push)
- ✅ GitHub Actions CI — separate workflows: lint, format, link check
- ✅ Claude prompts for all major document types
- ✅ Checklists for new project, code review, release, new feature (human + AI combined)
- ✅ Glossary with direct anchor links
- ✅ Guides: git workflow, onboarding, code review, release flow, docs style guide

---

## Next — v1.0 (stable release)

Target: feature-complete template that covers the full lifecycle of a software project.

- [ ] ADR-0014 — RFC process decision (document the decision to add RFC alongside ADR)
- [ ] `docs/prompts/security.md` — prompt for filling in SECURITY.md
- [ ] `docs/prompts/contributing.md` — prompt for generating CONTRIBUTING.md
- [ ] All existing prompts verified on a TypeScript/Node.js project
- [ ] AGENTS.md updated to reflect v1.0 state after above changes

---

## Backlog

- [ ] GitHub Actions automated release workflow (push tag → release PR → merge = release)
- [ ] `pnpm run init` installs global tools in CI — replace manual `npm install -g` in workflows
- [ ] Multi-language docs support (e.g. `docs/en/`, `docs/uk/`)
- [ ] AID examples — real interaction records from template development
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
