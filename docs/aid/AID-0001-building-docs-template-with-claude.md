# AID-0001: Building docs.template with Claude

## Status

Accepted

## AI System

Claude Sonnet 4.6 (claude.ai)

## Date

2026-05-11 — 2026-05-25

## Author

github.com/indigo-soft

---

## Goal

Design and build a complete documentation and tooling template for software projects,
including: documentation structure, git conventions, release automation, AI-assisted
onboarding prompts, and a working release cycle — all battle-tested on a real project.

## Prompt Summary

The interaction spanned multiple sessions using the Claude chat interface (not a single prompt).
Key prompt files used:

- `docs/prompts/onboarding.md` — designed during the session, then used to onboard music-resort
- `docs/prompts/agents.md`, `architecture.md`, `coding-standards.md`, `deployment.md`, `testing.md`
- `docs/prompts/adr.md`, `air.md`, `aid.md`

The overall approach: Claude was given the repository and asked to build, test, iterate, and
document — with the human providing direction and the AI doing implementation.

## AI Output Summary

Over multiple sessions Claude produced:

- Complete `docs/` structure: ADR (13 records), AIR, AID, architecture, guides, context, prompts
- All prompt files in `docs/prompts/` (9 prompts)
- Shell scripts: `scripts/init/`, `scripts/start/`, `scripts/release/`, `scripts/libs/`
- `AGENTS.md`, `README.md`, `CONTRIBUTING.md`, `SECURITY.md`, `ROADMAP.md`, `CHANGELOG.md`
- `lefthook.yml`, `commitlint.config.mjs`, `package.json`, `.release-it.json`, `.pnpmrc`
- GitHub Actions CI workflow, Renovate config, Dependabot config
- All content was validated on music-resort (PHP CLI tool) as a real test project

## Evaluation

- All prompts tested on music-resort — onboarding through release cycle
- Shell scripts debugged interactively (commitlint hook took ~6 sessions to resolve)
- Markdown linting and formatting integrated and passing in CI
- GitHub Actions CI passing
- 14 tests passing in music-resort after applying the template

## Outcome

**Adopted with modifications:**

- Initial `package.json` with local pnpm dependencies → modified to global npm install
  (pnpm v11 + WSL2 isolated linker creates text redirect files, not real symlinks)
- `commitlint.config.js` → renamed to `.mjs` (Node.js v24 ESM requirement)
- `pnpm setup` for hooks → renamed to `pnpm run init` (conflicts with pnpm built-in)
- `lefthook install` in `prepare` lifecycle → moved to separate `init` script
  (pnpm lifecycle conflicts break module resolution)
- `extends: ['@commitlint/config-conventional']` → removed, all rules inline
  (global commitlint can't resolve local pnpm packages)
- `.npmrc` with pnpm options → moved to `.pnpmrc` (npm warns about unknown keys)
- `node-linker=hoisted` in `.npmrc` → rejected (still creates redirect files on WSL2)
- `release-it` hooks with echo → removed (release-it shows command + output = duplication)

**Rejected entirely:**

- `shamefully-hoist=true` + `node-linker=hoisted` as a workaround for pnpm symlinks
- `npx release-it` calls (replaced with global `release-it`)

## Project Impact

- `docs/context/decisions.md` — full log of all decisions made
- `docs/adr/ADR-0008` — commitlint configuration and WSL2 workarounds documented
- `AGENTS.md` — global tools requirement documented as a first-class constraint
- `docs/prompts/onboarding.md` — updated with correct tooling setup instructions

## Lessons Learned

**What worked well:**

- Giving Claude the full repository context at the start of each session
- Breaking work into focused sessions (init script, start wizard, ADRs, etc.)
- Testing every change immediately and feeding errors back to Claude
- Using `pnpm run init` as the single entry point — catches problems early

**What to do differently:**

- Research pnpm + WSL2 compatibility before starting (would have saved ~6 debugging sessions)
- Create `.pnpmrc` with `approve-builds=lefthook` from the start
- Use global npm install for all Node.js tools from day one
- Test git hooks from the very first commit (not after everything is set up)

**AI strengths for this task:**

- Generating consistent, well-structured markdown documentation
- Bash scripting with proper error handling and color output
- Iterative debugging when given error output directly
- Cross-file consistency (updating all related files when a convention changes)

**AI limitations observed:**

- Does not retain context between sessions — project.md and decisions.md are essential
- Can suggest approaches that work in theory but fail in specific environments (WSL2)
- May overwrite files without checking if they have unsaved changes

## Related

- [ADR-0008](../adr/ADR-0008-commitlint-commit-validation.md) — commitlint WSL2 decisions
- [ADR-0009](../adr/ADR-0009-documentation-structure.md) — documentation structure rationale
- [ADR-0010](../adr/ADR-0010-ai-assisted-development.md) — AID format definition
