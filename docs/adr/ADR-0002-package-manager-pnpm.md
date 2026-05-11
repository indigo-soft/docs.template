# ADR-0002: Package Manager (pnpm)

**Status:** Accepted
**Date:** 2026-05-11

---

## Context

The project needs a package manager for:

- Installing and managing dependencies
- Workspace support (if the project is a monorepo)
- Running scripts across packages
- Producing reproducible builds via a lock file

Requirements:

- Workspace / monorepo support
- Fast installs
- Disk-efficient storage
- Deterministic installs (lock file)
- Good CI/CD support
- Protection against phantom dependencies

Alternatives considered: npm, Yarn Classic (v1), Yarn Berry (v2+), pnpm, Bun.

## Decision

Use **pnpm** (v10+) as the package manager.

## Considered Options

### pnpm ✅ Chosen

**Pros:**

- Up to 2× faster than npm / Yarn Classic
- Content-addressable store — one copy of each package on disk, shared across projects
- Strict mode prevents phantom dependencies
- Excellent workspace (monorepo) support
- `pnpm-lock.yaml` is smaller and faster to parse than `package-lock.json`
- Actively maintained; used by Vue.js, Vite, Prisma

**Cons:**

- Developers must install pnpm separately (`npm install -g pnpm` or Corepack)
- Occasional edge-case compatibility issues (rare)

### npm

**Pros:** Built into Node.js; maximum compatibility.
**Cons:** Slower; larger `node_modules`; phantom dependencies possible.
**Verdict:** Good for simple projects; pnpm wins for workspaces and disk efficiency.

### Yarn Classic (v1)

**Pros:** Widely known.
**Cons:** No longer actively developed; slower than pnpm; phantom dependencies possible.
**Verdict:** Deprecated; avoid for new projects.

### Yarn Berry (v2+)

**Pros:** Very fast with PnP mode; modern.
**Cons:** PnP setup is complex; not all packages support it; steep learning curve.
**Verdict:** Powerful but over-engineered for most projects.

### Bun

**Pros:** Fastest (Zig-based); full runtime + package manager.
**Cons:** Still maturing; smaller ecosystem; compatibility risks in production.
**Verdict:** Promising — revisit in 1–2 years.

## Rationale

pnpm gives 80% of Bun's speed with a mature, proven ecosystem. Its strict mode catches
dependency issues early, and its workspace support is first-class.

## Configuration

### `package.json`

```json
{
    "engines": {
        "node": ">=24.0.0",
        "pnpm": ">=10.0.0"
    },
    "scripts": {
        "preinstall": "npx only-allow pnpm"
    }
}
```

The `preinstall` script blocks accidental use of `npm install` or `yarn`.

### `pnpm-workspace.yaml` (for monorepos)

```yaml
packages:
    - 'apps/*'
    - 'packages/*'
```

## Consequences

### Positive

- Faster installs — less time for developers and CI runners
- ~30–50% less disk usage compared to npm
- Strict dependency resolution prevents hard-to-debug phantom dependency bugs
- Excellent monorepo support out of the box

### Negative

- Developers must install pnpm once (`npm install -g pnpm` or `corepack enable`)
- Lock file is `pnpm-lock.yaml`, not `package-lock.json`

### Neutral

- CI/CD pipelines need a `pnpm/action-setup` step (one line)
- Commands are similar to npm (`pnpm add`, `pnpm install`, `pnpm run`)

## Related ADRs

- [ADR-0001](ADR-0001-git-workflow-branching-strategy.md) — Git workflow (uses pnpm scripts)
- [ADR-0005](ADR-0005-git-hooks-lefthook.md) — Lefthook installed via `pnpm prepare`
- [ADR-0006](ADR-0006-changelog-release-it.md) — release-it installed as pnpm dev dependency
