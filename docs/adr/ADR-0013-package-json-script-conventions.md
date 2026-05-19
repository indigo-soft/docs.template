# ADR-0013: package.json Script Naming Conventions

**Status:** Accepted
**Date:** 2026-05-19

---

## Context

`package.json` scripts tend to accumulate inconsistently — different naming styles,
ambiguous actions, and long inline commands that belong in shell scripts.
A consistent convention makes the scripts predictable, discoverable, and maintainable.

## Decision

Apply the following rules to all `package.json` scripts across all projects.

---

## Rule 1 — Naming format

Script names use **kebab-case** with an optional colon-separated action:

```text
command
command:action
command:type
command-name:action-name
```

- Only hyphens within each segment — no underscores, no camelCase
- Examples: `lint:fix`, `release:minor`, `format:check`, `code-gen:types`

---

## Rule 2 — Linters, formatters, and checkers

### 2.1 Individual commands

Format: `command:action`

Typical actions: `fix`, `check`, `lint`

```json
"lint:fix":    "markdownlint-cli2 --fix ...",
"lint:check":  "markdownlint-cli2 ...",
"format:fix":  "prettier --write .",
"format:check":"prettier --check ."
```

### 2.2 Combined command (same tool, same direction)

A bare `command` (no action) is reserved for a **combined** command of the same tool.
Fix commands always run **before** check commands:

```json
"lint":   "pnpm run lint:fix && pnpm run lint:check",
"format": "pnpm run format:fix && pnpm run format:check"
```

### 2.3 Cross-tool combined

When multiple tools have fix or check commands, run them separately:

```bash
pnpm lint && pnpm format
```

No single combined script is required — sequential calls are explicit and readable.

---

## Rule 3 — Long or complex commands → bash scripts

If a command exceeds **120 characters**, or consists of multiple chained commands,
extract it to a bash script:

```text
scripts/
    command-name/
        command-name.sh
```

Call it from `package.json`:

```json
"command-name": "bash scripts/command-name/command-name.sh --arg1 --arg2"
```

---

## Rule 4 — Required commands

Every project `package.json` must include these commands when applicable:

| Command            | Required when            | Description                           |
| ------------------ | ------------------------ | ------------------------------------- |
| `init`             | always                   | Full project setup from a fresh clone |
| `start`            | project has a runtime    | Start the application                 |
| `build`            | project has a build step | Build for production                  |
| `build:dev`        | project has environments | Build for development                 |
| `build:staging`    | project has staging env  | Build for staging                     |
| `generate`         | project has generators   | Run all generators                    |
| `generate:type`    | multiple generator types | Run a specific generator              |
| `test`             | project has tests        | Run all tests                         |
| `test:unit`        | multiple test types      | Run unit tests only                   |
| `test:integration` | multiple test types      | Run integration tests only            |
| `test:e2e`         | project has E2E tests    | Run E2E tests only                    |
| `lint`             | project has a linter     | Fix then check (combined)             |
| `lint:fix`         | project has a linter     | Fix issues automatically              |
| `lint:check`       | project has a linter     | Check without fixing                  |
| `format`           | project has a formatter  | Fix then check (combined)             |
| `format:fix`       | project has a formatter  | Format files                          |
| `format:check`     | project has a formatter  | Check formatting only                 |
| `release`          | project has releases     | Interactive release                   |
| `release:dry`      | project has releases     | Dry-run release                       |
| `release:patch`    | project has releases     | Patch version bump                    |
| `release:minor`    | project has releases     | Minor version bump                    |
| `release:major`    | project has releases     | Major version bump                    |

Commands with a `:watch` suffix are added when a process supports watch mode:

```json
"test:watch": "vitest --watch",
"build:watch": "tsc --watch"
```

---

## Consequences

### Positive

- Predictable script names across all projects — no guessing
- Combined commands enforce the fix-before-check pattern
- Long commands in bash scripts are easier to read, test, and document
- Required command list ensures no common entry point is missing

### Negative

- More scripts than a minimal setup
- Combined `command` scripts add indirection (call two sub-commands)

### Neutral

- Projects without a specific feature simply omit the corresponding commands
- The convention applies to new projects; existing projects migrate incrementally

## Related ADRs

- [ADR-0012](ADR-0012-shell-script-conventions.md) — bash script structure for extracted commands
