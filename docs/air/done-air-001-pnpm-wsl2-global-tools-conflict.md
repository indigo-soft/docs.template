# done-AIR-001: pnpm isolated linker on WSL2 conflicts with native development policy

## Status

Resolved

## Affected ADRs

| ADR                                                         | Title                             | Status after resolution                     |
| ----------------------------------------------------------- | --------------------------------- | ------------------------------------------- |
| [ADR-0002](../adr/ADR-0002-package-manager-pnpm.md)         | Package Manager (pnpm)            | Accepted — exception added for global tools |
| [ADR-0003](../adr/ADR-0003-native-development-no-docker.md) | Native Development without Docker | Accepted — unchanged                        |

## Conflict Description

**ADR-0002** adopts pnpm as the package manager and assumes local installation of dev
tools via `devDependencies`. pnpm's isolated linker creates symlinks in `node_modules`
that point to the pnpm store.

**ADR-0003** requires native development on the host OS (Ubuntu 24.04 via WSL2) without
Docker or other containerisation.

**Point of conflict:** On WSL2, pnpm v11's isolated linker creates text redirect files
instead of real symlinks in `node_modules/@scope/pkg`. Node.js cannot resolve ESM imports
through these redirect files. As a result, `commitlint`, `release-it`, and `prettier` —
installed as local `devDependencies` — fail when invoked from git hook subprocesses
(lefthook pre-commit, commit-msg, pre-push). The tools work in a regular terminal session
but not in the hook context, making the development workflow unusable.

## Severity

**Level:** Critical

Blocks the entire git hook workflow. Neither ADR-0002 nor ADR-0003 can be applied
together as written on WSL2 — at least one must be amended.

## Resolution Paths

### Path A: Switch to npm or yarn as the package manager ❌

Replace pnpm with npm or yarn, which use a flat `node_modules` structure without
the symlink issue.

**Pros:**

- ✅ Standard symlink behaviour — local tool installation works in all contexts

**Cons:**

- ❌ Reverses ADR-0002 entirely; pnpm was chosen for workspace support and speed
- ❌ Larger `node_modules` footprint
- ❌ Requires rewriting all scripts and CI steps

**Status:** ❌ Rejected

### Path B: Use `node-linker=hoisted` in `.npmrc` ❌

Configure pnpm to use a flat (hoisted) node_modules layout, which avoids the
redirect file issue.

**Pros:**

- ✅ Keeps pnpm; resolves the symlink problem

**Cons:**

- ❌ `node-linker=hoisted` in `.npmrc` still produces redirect files in WSL2 —
  tested and confirmed not to resolve the issue
- ❌ `.npmrc` is read by both npm and pnpm; mixing configs causes confusion

**Status:** ❌ Rejected — tested, does not solve the problem

### Path C: Install affected tools globally via npm ✅ Chosen

Install `commitlint`, `release-it`, and `prettier` globally via `npm install -g`
rather than as local `devDependencies`. Keep `lefthook` as a local pnpm dependency
(Go binary, no ESM resolution issue).

**Pros:**

- ✅ Solves the hook subprocess resolution problem completely
- ✅ Keeps pnpm and ADR-0003 unchanged
- ✅ Global tools are available in all contexts (terminal, hooks, CI)
- ✅ Minimal change — only affects installation method, not tooling choices

**Cons:**

- ⚠️ Global installation is not tracked in `package.json` — requires documentation
- ⚠️ Developers must run `npm install -g ...` manually on new machines
  (mitigated by `pnpm run init` which handles this automatically)
- ⚠️ WSL2-specific workaround — on native Linux or macOS with pnpm,
  local installation may work correctly

**Status:** ✅ Chosen

## Decision Taken

Install `commitlint`, `release-it`, and `prettier` globally via `npm install -g`.
Do not add them to `devDependencies`. `lefthook` remains a local pnpm dependency.

The `pnpm run init` script installs all global tools automatically so developers
do not need to run the commands manually after the initial setup.

This sets a precedent: on WSL2 + pnpm projects, any tool invoked from a git hook
subprocess should be verified to work in that context before being added as a local
dependency. If it fails, global installation is the preferred fallback.

## Consequences

### For ADR-0002

An exception was added: tools invoked from git hook subprocesses on WSL2 must be
installed globally via npm rather than as local pnpm devDependencies.
The exception is documented in `AGENTS.md` and `docs/prompts/onboarding.md`.

### For ADR-0003

Unchanged. Native development on WSL2 remains the standard. The global tool
installation is a consequence of the WSL2 environment, not a deviation from
the native development policy.

### For the team

- [x] `pnpm run init` updated to install global tools automatically
- [x] `AGENTS.md` updated with the global tools requirement and rationale
- [x] `docs/prompts/onboarding.md` updated with the global tools setup step
- [x] `commitlint.config.mjs` updated — all rules defined inline, no `extends`
      (avoids dependency on locally installed `@commitlint/config-conventional`)

## Date Opened

2026-05-18

## Date Resolved

2026-05-18

## Tags

`tooling` `pnpm` `wsl2` `git-hooks` `symlinks`
