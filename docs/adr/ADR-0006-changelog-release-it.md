# ADR-0006: Changelog Automation (release-it)

**Status:** Accepted
**Date:** 2026-05-11

---

## Context

The project follows [Conventional Commits](https://www.conventionalcommits.org/), which
enables automatic version bumping and changelog generation from commit history.
Maintaining a changelog manually is error-prone and often skipped during fast-moving
development cycles.

Requirements for a release tool:

- Derive the next version from commit types (`feat` → minor, `fix` → patch, `feat!` → major)
- Generate `CHANGELOG.md` automatically
- Create a git tag and release commit
- Publish a GitHub Release with auto-generated notes
- Run locally via `npm scripts` (no mandatory CI dependency)
- Dry-run mode for safe previewing
- Minimal vendor lock-in

Alternatives considered: release-it, semantic-release, commit-and-tag-version, manual changelog.

## Decision

Use **release-it** with the **@release-it/conventional-changelog** plugin,
installed globally via npm.

## Considered Options

### release-it ✅ Chosen

**Pros:**

- Works identically locally and in CI — no migration required when adding GitHub Actions later
- Interactive mode + non-interactive (`--ci`) mode
- Dry-run support (`--dry-run`)
- Lifecycle hooks (`before:init`, `after:bump`, etc.)
- Single config file (`.release-it.json`)
- Actively maintained, 17 000+ GitHub stars

**Cons:**

- `GITHUB_TOKEN` required for GitHub Release publishing
- `CHANGELOG.md` must not be edited manually (it is overwritten on each release)
- Must be installed globally (see rationale below)

### semantic-release

**Pros:** Full CI automation; large plugin ecosystem.
**Cons:** Designed exclusively for CI — local runs are awkward; all-or-nothing approach;
more complex setup.
**Verdict:** Great for teams with mature CI. Premature for projects starting with local releases.

### commit-and-tag-version

**Pros:** Simple; well-known.
**Cons:** No GitHub Release publishing; no interactive mode; less active development.
**Verdict:** Missing GitHub Release publishing — a key requirement.

### Manual changelog

**Pros:** Full control.
**Cons:** Error-prone; often skipped; incompatible with automation.
**Verdict:** Does not scale; rejected.

## Rationale

release-it provides the full release pipeline (version bump → changelog → tag → GitHub Release)
with a single command, while keeping local use as the primary workflow.
When CI automation is needed later, the `.release-it.json` config requires no changes —
only a GitHub Actions workflow file needs to be added.

**Why global install:** pnpm's isolated linker on WSL2 creates text redirect files instead
of real symlinks, preventing Node.js from resolving release-it's dependencies in the hook
subprocess context. Global install bypasses this entirely.
See [ADR-0008](ADR-0008-commitlint-commit-validation.md) for the full explanation.

**Installation:**

```bash
npm install -g release-it @release-it/conventional-changelog
```

## Configuration

**File:** `scripts/.release-it.json`

```json
{
  "git": {
    "commit": true,
    "commitMessage": "chore(release): v${version}",
    "tag": true,
    "tagName": "v${version}",
    "push": true,
    "requireCleanWorkingDir": true
  },
  "github": {
    "release": true,
    "releaseName": "Release v${version}",
    "tokenRef": "GITHUB_TOKEN"
  },
  "npm": {
    "publish": false,
    "version": true
  },
  "plugins": {
    "@release-it/conventional-changelog": {
      "preset": "conventionalcommits",
      "infile": "CHANGELOG.md"
    }
  }
}
```

The config is referenced from `package.json`:

```json
{
  "release-it": {
    "extends": "./scripts/.release-it.json"
  }
}
```

### npm scripts

```json
{
  "scripts": {
    "release": "bash scripts/release/release.sh",
    "release:dry": "bash scripts/release/release.sh --dry",
    "release:patch": "bash scripts/release/release.sh --type=patch",
    "release:minor": "bash scripts/release/release.sh --type=minor",
    "release:major": "bash scripts/release/release.sh --type=major"
  }
}
```

> ⚠️ Use `npm run release:*`, not `pnpm run release:*` — pnpm's ELIFECYCLE error handling
> adds noise on non-zero exit codes.

The scripts delegate to a Bash wrapper that runs pre-release checks before calling release-it.
See `docs/guides/release-flow.md` for the full guide.

### Commit type → version bump mapping

| Commit type                 | CHANGELOG section   | Version bump |
| --------------------------- | ------------------- | ------------ |
| `feat`                      | ✨ Features         | `minor`      |
| `fix`                       | 🐛 Bug Fixes        | `patch`      |
| `perf`                      | ⚡ Performance      | `patch`      |
| `revert`                    | ⏪ Reverts          | `patch`      |
| `docs`                      | 📚 Documentation    | —            |
| `chore`                     | 🔧 Chores           | —            |
| `feat!` / `BREAKING CHANGE` | 💥 Breaking Changes | `major`      |

## Consequences

### Positive

- Changelog is always consistent with the actual commit history
- GitHub Releases are published automatically on every release
- Dry-run mode makes releases safe to preview
- Motivates writing quality commit messages — developers see the result in the changelog

### Negative

- Changelog quality depends on commit message quality
- `CHANGELOG.md` must not be edited manually
- `GITHUB_TOKEN` with `repo` scope is required
- Global installation is a manual step not captured in `package.json`

### Neutral

- `package.json` version is bumped automatically
- A release commit (`chore(release): vX.Y.Z`) and tag are created automatically

## Future: GitHub Actions automation

When ready, add a workflow file:

```yaml
# .github/workflows/release.yml
- run: npm install -g release-it @release-it/conventional-changelog
- run: release-it --ci
  env:
    GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

## Related ADRs

- [ADR-0001](ADR-0001-git-workflow-branching-strategy.md) — Conventional Commits power the automatic version detection
- [ADR-0005](ADR-0005-git-hooks-lefthook.md) — commitlint enforces the commit format that release-it depends on
- [ADR-0008](ADR-0008-commitlint-commit-validation.md) — global install rationale (applies to release-it too)
- [ADR-0011](ADR-0011-versioning-semver.md) — SemVer strategy implemented by release-it
