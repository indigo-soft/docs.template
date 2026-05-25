# Roadmap

A documentation and tooling template that keeps getting better with each real project that uses it.

---

## Current — v0.x (status: beta)

Template is functional and battle-tested on music-resort (PHP CLI tool). Core workflow works:
clone → `pnpm run init` → onboarding prompt → docs generation → release cycle.

- ✅ 13 ADRs covering all major tooling decisions
- ✅ ADR / AIR / AID document types with templates, indexes, and prompts
- ✅ `pnpm run init` — full project initialization wizard
- ✅ `pnpm start` — project status wizard with checklist progress
- ✅ release-it + Conventional Commits release automation
- ✅ Lefthook git hooks (pre-commit, commit-msg, pre-push)
- ✅ GitHub Actions CI (lint + format check)

---

## Next — v1.0 (stable release)

Target: when all prompts are tested on 2+ real projects of different stacks.

- [ ] All prompts tested on a TypeScript/Node.js project
- [ ] All prompts tested on a Python project
- [ ] GitHub Actions automated release workflow (push to main → release PR → merge = release)
- [ ] Example repository using docs.template as a reference implementation
- [ ] `docs/prompts/readme.md` — prompt for generating README
- [ ] `docs/prompts/roadmap.md` — prompt for generating ROADMAP

---

## Backlog

- [ ] `pnpm run init` in CI — replace manual `npm install -g` steps in workflow
- [ ] Multi-language docs support (language subfolders: `docs/en/`, `docs/uk/`)
- [ ] PR and Issue templates for `.github/` (project-specific via prompt)
- [ ] AID examples — real interaction records from template development
- [ ] `docs/prompts/security.md` — prompt for generating SECURITY.md
- [ ] `docs/prompts/contributing.md` — prompt for generating CONTRIBUTING.md

---

## Out of scope

- Runtime application code — this is a docs/tooling template, not an app starter
- Framework-specific scaffolding (use framework CLIs for that)
- Automated testing of documentation content

---

## Contributing

Open a GitHub Issue to suggest roadmap items or discuss priorities.
