# Release Flow Guide

Releases are managed via [`release-it`](https://github.com/release-it/release-it) with the
[`@release-it/conventional-changelog`](https://github.com/release-it/conventional-changelog) plugin,
wrapped in a custom pre-release check script.

## What happens on each release

1. Pre-release checks run (clean working directory, correct branch, commits pushed, lockfile in sync).
2. `release-it` determines the version bump from commit types (`feat` → minor, `fix` → patch, `feat!` → major).
3. `package.json` version is updated.
4. `CHANGELOG.md` is updated automatically from commit history.
5. A release commit is created: `chore(release): vX.Y.Z`.
6. A Git tag `vX.Y.Z` is created and pushed.
7. A GitHub Release is published with auto-generated notes.

## Prerequisites

| Tool   | Minimum version |
|--------|-----------------|
| `node` | ≥ 24.0.0        |
| `pnpm` | ≥ 10.0.0        |
| `git`  | any recent      |

A `GITHUB_TOKEN` with **repo** scope is required for GitHub Releases:

```dotenv
# .env
GITHUB_TOKEN=ghp_xxxxxxxxxxxxxxxxxxxx
```

## Release Commands

> **⚠️ Use `npm run`, not `pnpm run`** to avoid `ELIFECYCLE` noise on non-zero exit codes.

| Command                 | Description                                                             |
|-------------------------|-------------------------------------------------------------------------|
| `npm run release:dry`   | Preview only — runs checks and shows what would happen, no changes made |
| `npm run release:patch` | Bump patch version (`X.Y.Z+1`) — bug fixes                              |
| `npm run release:minor` | Bump minor version (`X.Y+1.0`) — new features                           |
| `npm run release:major` | Bump major version (`X+1.0.0`) — breaking changes                       |
| `npm run release`       | Interactive — `release-it` prompts for version choice                   |

## Typical Workflow

```
1. Merge all feature branches → main (via Pull Request)
2. Ensure CHANGELOG.md is not empty and all commits are pushed
3. npm run release:dry       ← verify everything looks correct
4. npm run release:patch     ← (or :minor / :major)
5. Verify the new tag and GitHub Release on GitHub
```

## Conventional Commits → Version Bump

| Commit type                 | CHANGELOG section          | Bump    |
|-----------------------------|----------------------------|---------|
| `feat`                      | ✨ Features                 | `minor` |
| `fix`                       | 🐛 Bug Fixes               | `patch` |
| `perf`                      | ⚡ Performance Improvements | `patch` |
| `revert`                    | ⏪ Reverts                  | `patch` |
| `docs`                      | 📚 Documentation           | —       |
| `chore`                     | 🔧 Miscellaneous Chores    | —       |
| `feat!` / `BREAKING CHANGE` | 💥 Breaking Changes        | `major` |

## Pre-Release Checks

The script validates the following before any release starts:

| # | Check                   | What it verifies                        |
|---|-------------------------|-----------------------------------------|
| 1 | Dependencies            | `git`, `node`, `pnpm` are installed     |
| 2 | Clean working directory | No unstaged or staged changes           |
| 3 | Correct branch          | You are on `main` or `master`           |
| 4 | Commits pushed          | No local commits ahead of `origin`      |
| 5 | Lockfile in sync        | Lock file matches `package.json`        |
| 6 | CHANGELOG exists        | `CHANGELOG.md` is present and non-empty |

If any check fails, the script exits with a descriptive error. No changes are made.

## CHANGELOG

`CHANGELOG.md` is generated and updated **automatically** by `@release-it/conventional-changelog`.

> ⚠️ Do **not** edit `CHANGELOG.md` manually — it will be overwritten on the next release.

## Configuration Files

| File                         | Purpose                        |
|------------------------------|--------------------------------|
| `scripts/.release-it.json`   | `release-it` configuration     |
| `scripts/release/release.sh` | Main release entry-point       |
| `scripts/release/checks.sh`  | Pre-release check functions    |
| `scripts/libs/colors.sh`     | Colored console output helpers |
| `scripts/libs/env.sh`        | `.env` file loader             |

## Troubleshooting

| Symptom                         | Cause                                  | Fix                              |
|---------------------------------|----------------------------------------|----------------------------------|
| `Permission denied` on `.sh`    | Scripts not executable                 | `npm run prepare`                |
| `CHANGELOG.md is empty`         | No content in file                     | Add at least a placeholder line  |
| `pnpm-lock.yaml is out of sync` | `package.json` changed without install | `pnpm install`                   |
| `Local commits not pushed`      | Forgot to push                         | `git push`                       |
| `GITHUB_TOKEN not set`          | Missing env var                        | Add to `.env` or export in shell |

## Future: GitHub Actions

When ready to automate releases via CI, add a workflow file. The `.release-it.json` config requires no changes:

```yaml
# .github/workflows/release.yml
name: Release
on:
    push:
        branches: [main]
jobs:
    release:
        runs-on: ubuntu-latest
        steps:
            - uses: actions/checkout@v4
              with:
                  fetch-depth: 0
            - uses: actions/setup-node@v4
              with:
                  node-version: 24
            - run: npm ci
            - run: npx release-it --ci
              env:
                  GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```
