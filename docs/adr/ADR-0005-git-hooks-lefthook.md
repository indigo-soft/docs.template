# ADR-0005: Git Hooks (Lefthook)

**Status:** Accepted
**Date:** 2026-05-11

---

## Context

The project uses [Conventional Commits](https://www.conventionalcommits.org/) and enforces
branch naming conventions. Without automated checks at commit time, these rules drift quickly.

Requirements for a git hooks solution:

- Validate commit message format (commitlint)
- Format and lint staged files on pre-commit
- Run type-check and tests before push
- Fast execution — slow hooks get disabled by developers
- Configuration in a single, readable file
- No dependency on shell scripts for basic use cases

Alternatives considered: Lefthook, Husky, simple-git-hooks, pre-commit (Python).

## Decision

Use **Lefthook** for git hook management.

## Considered Options

### Lefthook ✅ Chosen

Written in Go — ships as a binary with no Node.js startup overhead.
Configuration is a single YAML file (`lefthook.yml`).
Supports parallel command execution, per-file glob patterns, and skip conditions
(e.g. skip tests during `merge` or `rebase`).

**Pros:** Fast (~10 ms startup), readable config, parallel execution, built-in skip conditions.
**Cons:** Less widely known than Husky (but actively maintained and growing).

### Husky

**Pros:** Very widely used; large community.
**Cons:** Node.js-based (~150 ms startup overhead); configuration is bash scripts (less readable);
no native parallel execution; no built-in skip conditions.
**Verdict:** Works well, but Lefthook is objectively faster and more expressive.

### simple-git-hooks

**Pros:** Minimal and simple.
**Cons:** No parallel execution; no skip conditions; limited for complex setups.
**Verdict:** Too basic for projects with multiple hooks.

### pre-commit (Python)

**Pros:** Large plugin ecosystem.
**Cons:** Requires Python; not native to the Node.js/JS ecosystem.
**Verdict:** Wrong ecosystem fit.

## Configuration

**File:** `lefthook.yml` in the project root.

```yaml
colors: true

# pre-commit: format and lint staged files
pre-commit:
    parallel: false # sequential: format first, then lint
    commands:
        format:
            glob: 'src/**/*.{ts,tsx,js,jsx,json,md,css,scss}'
            run: npx prettier --write {staged_files}
            stage_fixed: true

        lint:
            glob: 'src/**/*.{ts,tsx,js,jsx}'
            run: npx eslint --fix {staged_files}
            stage_fixed: true

# commit-msg: validate commit message
commit-msg:
    commands:
        commitlint:
            run: npx commitlint --edit {1}

# pre-push: full checks before pushing
pre-push:
    commands:
        typecheck:
            run: pnpm type-check

        test:
            run: pnpm test --bail --passWithNoTests
            skip:
                - merge
                - rebase
```

### Installation

Lefthook installs hooks via the `prepare` script in `package.json`:

```json
{
    "scripts": {
        "prepare": "lefthook install"
    }
}
```

Running `pnpm install` after cloning automatically installs the hooks.

### Skipping hooks (when needed)

```bash
# Skip all hooks for a commit
LEFTHOOK=0 git commit -m "message"

# Skip a specific hook
LEFTHOOK_EXCLUDE=pre-commit git commit -m "message"
```

## Consequences

### Positive

- Commit messages are validated automatically — no manual policing
- Staged files are formatted and linted before every commit — consistent code style
- Fast execution (~10 ms startup) — developers don't disable the hooks
- Single YAML file is easy to read and extend

### Negative

- Developers must run `pnpm install` after cloning to activate hooks (documented in README)
- Binary is ~8 MB (vs a small Node.js script for Husky)

### Neutral

- Hooks are stored in `.git/hooks/` — not committed to the repository
- The `lefthook.yml` is the single source of truth for hook configuration

## Related ADRs

- [ADR-0001](ADR-0001-git-workflow-branching-strategy.md) — defines the commit format and branch naming that these hooks
  enforce
- [ADR-0002](ADR-0002-package-manager-pnpm.md) — Lefthook is installed via `pnpm prepare`
