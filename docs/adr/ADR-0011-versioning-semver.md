# ADR-0011: Versioning Strategy (SemVer + release-it)

**Status:** Accepted
**Date:** 2026-05-11

---

## Context

Every project that ships releases needs a versioning strategy that:

- Communicates the impact of a release to users and developers
- Is determined automatically from commit history (no manual version decisions)
- Generates a human-readable changelog automatically
- Integrates with the existing Conventional Commits workflow

## Decision

Use **Semantic Versioning (SemVer)** with version bumps determined automatically
from Conventional Commits, managed by **release-it** with the
`@release-it/conventional-changelog` plugin.

See also [ADR-0006](ADR-0006-changelog-release-it.md) for the release tooling decision.

## SemVer Rules

```text
MAJOR.MINOR.PATCH
```

| Commit type                    | Version bump | When to use                                         |
| ------------------------------ | ------------ | --------------------------------------------------- |
| `feat`                         | `MINOR`      | New functionality, backwards compatible             |
| `fix`, `perf`, `revert`        | `PATCH`      | Bug fixes, performance, reversions                  |
| `feat!` or `BREAKING CHANGE:`  | `MAJOR`      | Breaking change — existing behavior removed/changed |
| `docs`, `chore`, `style`, etc. | none         | No user-facing change                               |

## What counts as a BREAKING CHANGE

A breaking change requires users to change their code or configuration to upgrade.

**Examples:**

- Removing a public API, command, or option
- Changing the format of output that other tools depend on
- Changing required configuration keys
- Dropping support for a runtime version

**Not a breaking change:**

- Adding a new optional flag or option
- Internal refactoring with no API change
- Performance improvements
- Documentation updates

## Version 0.x.x

Before `1.0.0`, the project is considered unstable. Any release may contain breaking changes.
The first stable release should be `1.0.0` and should be tagged explicitly.

## Initial release

When a project has existing code but no release history, use:

```bash
release-it 1.0.0 --no-npm.version
```

Or set `package.json` version to `0.x.x` and use `release:major` to reach `1.0.0`.

## Tagging convention

All release tags use the `v` prefix: `v1.0.0`, `v1.2.3`, `v2.0.0`.

## CHANGELOG

The changelog is generated automatically from commit history by
`@release-it/conventional-changelog`. Sections correspond to commit types:

| Commit type     | CHANGELOG section           |
| --------------- | --------------------------- |
| `feat`          | ✨ Features                 |
| `fix`           | 🐛 Bug Fixes                |
| `perf`          | ⚡ Performance Improvements |
| `revert`        | ⏪ Reverts                  |
| `docs`          | 📚 Documentation            |
| `chore`         | 🔧 Miscellaneous Chores     |
| Breaking change | 💥 Breaking Changes         |

> ⚠️ Do not edit `CHANGELOG.md` manually — it is overwritten on each release.

## Consequences

### Positive

- Version bumps are determined from commit history — no manual decisions
- CHANGELOG is always consistent with what actually changed
- Developers understand the impact of a release from the version number alone
- SemVer is widely understood — no learning curve

### Negative

- Requires discipline in writing commit messages (mitigated by commitlint)
- `docs` and `chore` commits produce no version bump — a release with only
  documentation changes requires a manual patch bump

### Neutral

- `package.json` version is the single source of truth for the current version
- GitHub Releases are published automatically with each release

## Related ADRs

- [ADR-0001](ADR-0001-git-workflow-branching-strategy.md) — Conventional Commits that drive version bumps
- [ADR-0006](ADR-0006-changelog-release-it.md) — release-it tooling
- [ADR-0008](ADR-0008-commitlint-commit-validation.md) — commitlint enforces the commit format
