# ADR-0008: Commit Message Validation (commitlint)

**Status:** Accepted
**Date:** 2026-05-11

---

## Context

The project uses [Conventional Commits](https://www.conventionalcommits.org/) (see
[ADR-0001](ADR-0001-git-workflow-branching-strategy.md)). Without automated validation,
commit message format drifts quickly — especially the scope requirement, which is
non-standard and not enforced by default Conventional Commits tooling.

Additional constraints discovered during setup:

- Node.js v24 changed ESM module loading behavior
- pnpm v11 on WSL2 creates text redirect files instead of real symlinks in `node_modules`
- Running tools from git hook subprocesses has a different resolution context than the terminal

These constraints ruled out several standard approaches and led to non-obvious decisions
that are worth documenting explicitly.

## Decision

Use **commitlint** for commit message and branch name validation, with the following
non-standard configuration:

1. Config file named `commitlint.config.mjs` (not `.js`)
2. No `extends` — all rules defined inline
3. Installed globally via npm (not as a local pnpm dependency)

## Considered Options

### Standard local pnpm install + `commitlint.config.js`

**Pros:** Standard approach, versioned with the project.
**Cons:** Fails on WSL2 — pnpm creates text redirect files that Node.js cannot resolve
as real directories in git hook subprocess context.
**Verdict:** Rejected due to WSL2 incompatibility.

### Local pnpm install + `node-linker=hoisted` in `.npmrc`

**Pros:** Forces pnpm to install packages as real directories.
**Cons:** On WSL2, `node-linker=hoisted` still produces redirect files in a different
format. Also creates `.npmrc` coupling that affects all packages, not just commitlint.
**Verdict:** Rejected — same underlying problem in a different form.

### Global npm install ✅ Chosen

**Pros:** Bypasses pnpm's isolated linker entirely. Works reliably in hook subprocess context.
**Cons:** Not versioned with the project — developers must install manually.
**Verdict:** Accepted. Documented in `AGENTS.md` and `README.md`.

## Rationale for `.mjs` extension

Node.js v24 requires the `.mjs` extension for ESM modules when `"type": "module"` is
absent from `package.json`. The commitlint config uses `export default` (ESM syntax),
so `.mjs` is required for correct loading. Using `.js` causes a silent config load
failure — commitlint runs but applies no rules.

## Rationale for inline rules (no `extends`)

`extends: ['@commitlint/config-conventional']` requires `@commitlint/config-conventional`
to be resolvable from the commitlint config file's location. Since commitlint is installed
globally, it looks for the package in the global node_modules, where
`@commitlint/config-conventional` may not be present. Defining all rules inline
eliminates this dependency entirely.

## Configuration

**File:** `commitlint.config.mjs`

Key rules enforced:

- `scope-empty: [2, 'never']` — scope is **required** (non-standard, stricter than default)
- `scope-enum` — only project-defined scopes are allowed (updated per project)
- `type-enum` — standard Conventional Commits types
- `branch-name-format` — custom plugin enforcing `<type>/<4-digit-issue>-<description>`

**Installation (once per machine):**

```bash
npm install -g commitlint @commitlint/cli @commitlint/config-conventional
```

## Consequences

### Positive

- Commit messages are validated automatically on every commit
- Branch names are validated automatically on every push
- No silent failures — invalid messages show clear error output
- Works reliably in WSL2 + pnpm v11 environment

### Negative

- Global installation is a manual step not captured in `package.json`
- CI pipelines must install commitlint globally before running hooks
- Scope list must be kept in sync with the project's actual module structure

### Neutral

- `commitlint.config.mjs` is committed to the repo and versioned
- Global install version may differ between developers (mitigated by pinning in docs)

## Related ADRs

- [ADR-0001](ADR-0001-git-workflow-branching-strategy.md) — defines the commit and branch format that commitlint enforces
- [ADR-0005](ADR-0005-git-hooks-lefthook.md) — Lefthook triggers commitlint via `commit-msg` hook
