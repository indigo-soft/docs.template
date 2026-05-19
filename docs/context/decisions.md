# Decisions Log

> Append-only log of decisions made during project setup and development.
> Covers both ADR-level decisions (with a link to the full ADR) and smaller choices
> that don't warrant a formal record but are worth remembering.
>
> Format: newest entries at the top.
> Claude appends to this file after completing prompts or making notable choices.

---

## 2026-05-19 — `.pnpmrc` instead of `.npmrc` for approve-builds

**Decision:** Use `.pnpmrc` (not `.npmrc`) for pnpm-specific config options.

**Problem:** `approve-builds=lefthook` in `.npmrc` caused npm warnings:
`Unknown project config "approve-builds". This will stop working in the next major version of npm.`

**Reason:** `approve-builds` is a pnpm-specific option. npm reads `.npmrc` too and warns
about keys it doesn't recognize. `.pnpmrc` is read only by pnpm — no conflicts.

**Rule:** All pnpm-specific options go in `.pnpmrc`, not `.npmrc`.

---

## 2026-05-18 — pnpm + WSL2 + git hooks tooling decisions

**Problem:** pnpm v11 on WSL2 creates text redirect files instead of real symlinks
in `node_modules/@scope/pkg`. Node.js cannot resolve ESM imports through these files,
causing commitlint, release-it, and prettier to fail when invoked from git hook subprocesses.

**Decision:** Install commitlint, release-it, and prettier globally via npm. Do not add
them to `devDependencies`. Keep only `lefthook` as a local pnpm dependency (it is a Go
binary and does not have this issue).

**Affected files:** `package.json`, `commitlint.config.mjs`, `lefthook.yml`, `AGENTS.md`,
`docs/prompts/onboarding.md`

**Related decisions:**

- `commitlint.config.js` renamed to `commitlint.config.mjs` — Node.js v24 requires `.mjs`
  extension for ESM modules when `"type": "module"` is absent from `package.json`
- `extends: ['@commitlint/config-conventional']` removed from commitlint config — all rules
  defined inline to avoid dependency on locally installed packages
- `pnpm run init` used instead of `pnpm setup` — `pnpm setup` is a pnpm built-in that
  configures pnpm itself (adds global bin to PATH), not a custom script
- `.npmrc` with `node-linker=hoisted` was tried and rejected — it creates redirect files
  too (different format, same problem)

---

## 2026-05-11 — guides and foundational ADRs added

**Guides written** (generic, no project-specific content):

- `git-workflow.md` — scopes section points to `docs/context/project.md` instead of hardcoding them
- `git-config.md` — minimal one-time setup reference
- `release-flow.md` — fully generic, project-agnostic
- `naming-conventions.md` — generic TypeScript/file conventions; code-style decisions left for per-project prompt
- `updating-dependencies.md` — Renovate + Dependabot workflow

**Guides intentionally left as prompts** (too project-specific to write generically):

- `coding-standards.md` — depends on stack and linting tools
- `deployment.md` — depends on hosting, CI/CD platform, infrastructure
- `testing.md` — depends on testing framework and strategy

**ADRs written** (ADR-0001 through ADR-0007, adapted from agent-flow-v2):

- Removed all project-specific code examples (NestJS, Prisma, Next.js references)
- Removed "migration from Husky" framing from ADR-0005 — template starts with Lefthook directly
- Kept security strategy (ADR-0004) generic — framework-specific implementation belongs in the project
- ADR numbering: 4-digit zero-padded (0001...), matches commitlint branch naming convention
- File naming: `ADR-XXXX-kebab-case-title.md` (different from agent-flow which used `XXX-title.md`)

**Rationale for 4-digit numbering:** Consistent with the branch naming rule (minimum 4 digits).

---

## 2026-05-11 — docs.template initial structure designed

**Decisions:**

- Prompts stored in `docs/prompts/` (not project root) to keep root clean
- Per-document prompts written first; common questions extracted into `onboarding.md`
- Checklists stored in `docs/checklists/` separately from prompts — Claude fills them in
- Context stored in `docs/context/` as persistent project memory readable by Claude and humans
- `decisions.md` is append-only, newest first — serves as a lightweight decision journal
- `sessions/` subfolder for long-session summaries (optional but available)
- Prompts written in English; docs language is project-configurable via onboarding

**Rationale:** Wanted a single place to answer "why did we do it this way?" for decisions
below ADR threshold. Append-only format avoids merge conflicts and preserves history.
