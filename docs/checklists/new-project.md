# New Project Checklist

> Master status for setting up a new project from this template.
> Claude updates this file after completing each step.
> Run prompts in `docs/prompts/` to complete unchecked items.

## Phase 1 — Foundation

- [ ] **Onboarding** — core project facts collected and saved to `docs/context/project.md`
      → prompt: `docs/prompts/onboarding.md`

- [ ] **Commit scopes** — `commitlint.config.js` updated with project-specific scopes
      → update manually after onboarding (scopes come from onboarding Q14)

- [ ] **AGENTS.md** — generated and reflects actual project state
      → prompt: `docs/prompts/agents.md`

## Phase 2 — Architecture

- [ ] **Architecture overview** — `docs/architecture/overview.md` written
      → prompt: `docs/prompts/architecture.md`

- [ ] **Components** — `docs/architecture/components.md` written
      → prompt: `docs/prompts/architecture.md` (same prompt covers all three)

- [ ] **Modules** — `docs/architecture/modules.md` written
      → prompt: `docs/prompts/architecture.md`

## Phase 3 — Guides

- [ ] **Coding standards** — `docs/guides/coding-standards.md` written
      → prompt: `docs/prompts/coding-standards.md`

- [ ] **Deployment guide** — `docs/guides/deployment.md` written
      → prompt: `docs/prompts/deployment.md`

- [ ] **Testing guide** — `docs/guides/testing.md` written
      → prompt: `docs/prompts/testing.md`

## Phase 4 — Project meta

- [ ] **README.md** — project intro, setup steps, links to docs
      → write manually or ask Claude with project context loaded

- [ ] **CHANGELOG.md** — initialized (even if empty `## [Unreleased]` section)
      → run `pnpm release:dry` or initialize manually

- [ ] **SECURITY.md** — security contact and disclosure process filled in
      → update template placeholders manually

- [ ] **ROADMAP.md** — high-level goals for first milestone noted
      → write manually or ask Claude

## Phase 5 — Tooling verification

- [ ] **Lefthook installed** — `pnpm prepare` run, hooks active
- [ ] **commitlint working** — test commit rejected if format invalid
- [ ] **release scripts working** — `pnpm release:dry` runs without errors
- [ ] **First ADR written** — at least one decision recorded
      → prompt: `docs/prompts/adr.md`

---

## Notes

<!-- Add any project-specific setup notes here -->
