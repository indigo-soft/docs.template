# ADR-0007: Automated Dependency Management (Renovate + Dependabot)

**Status:** Accepted
**Date:** 2026-05-11

---

## Context

Projects accumulate npm dependencies and GitHub Actions over time.
Without automation:

- Dependencies age and accumulate security vulnerabilities
- Major updates are missed or postponed indefinitely
- Related packages are updated in separate PRs, causing noise
- Security patches require manual discovery and action

Requirements:

- Patch and minor updates applied automatically after CI passes
- Major updates always require manual review
- Related packages grouped into single PRs
- Configurable schedule — not every day
- Self-hostable via GitHub Actions (no mandatory Renovate Cloud subscription)

Alternatives considered: Renovate, Dependabot, manual updates.

## Decision

Use **two tools with a clear split of responsibility**:

| Tool           | Scope                                 | Schedule                      |
| -------------- | ------------------------------------- | ----------------------------- |
| **Renovate**   | npm packages (`package.json`)         | Every 3 days (nightly CI run) |
| **Dependabot** | GitHub Actions (`.github/workflows/`) | Weekly (every Monday)         |

## Considered Options

### Renovate + Dependabot ✅ Chosen

**Renovate pros:**

- Flexible package grouping (all related packages in one PR)
- Built-in auto-merge for patch/minor with `minimumReleaseAge` guard
- Configurable schedule
- Self-hosted via GitHub Actions — no Renovate Cloud required
- Conventional Commits compatible (`chore(deps): ...`)

**Dependabot pros:**

- Built into GitHub — zero config for GitHub Actions updates
- Native integration with GitHub security alerts

**Combined cons:**

- `RENOVATE_TOKEN` (GitHub PAT) must be created and stored in secrets
- Auto-merge requires "Allow auto-merge" enabled in GitHub repo settings
- `pnpm-lock.yaml` conflicts on Renovate PRs must be resolved manually

### Dependabot only

**Pros:** Zero additional setup.
**Cons:** Limited package grouping (much weaker than Renovate); no `minimumReleaseAge` protection;
no conditional auto-merge for minor updates.
**Verdict:** Sufficient for simple projects; insufficient for complex grouping requirements.

### Manual updates

**Pros:** Full control.
**Cons:** Security patches are missed; tedious; does not scale.
**Verdict:** Rejected.

## Rationale

Renovate provides fine-grained control over npm dependency updates that Dependabot cannot match —
particularly package grouping and `minimumReleaseAge` (which prevents auto-merging a package that
was just released, protecting against supply chain attacks).

Dependabot handles GitHub Actions natively with zero configuration, making it the right tool for that scope.

## Configuration

### Renovate (`renovate.json`)

Key settings:

- **Schedule:** `"every 3 days"` — avoids PR queue flooding
- **Auto-merge:** enabled for patch and minor (after CI passes and 3 days since release)
- **Major updates:** never auto-merged; labeled `major-update` + `needs-review`
- **Grouping:** define groups per technology domain in `packageRules`

Example group configuration:

```json
{
    "packageRules": [
        {
            "groupName": "TypeScript",
            "matchPackageNames": ["typescript", "@typescript-eslint/*"],
            "automerge": true,
            "minimumReleaseAge": "3 days"
        },
        {
            "matchUpdateTypes": ["major"],
            "automerge": false,
            "labels": ["major-update", "needs-review"]
        }
    ]
}
```

### Dependabot (`.github/dependabot.yml`)

```yaml
version: 2
updates:
    - package-ecosystem: 'github-actions'
      directory: '/'
      schedule:
          interval: 'weekly'
          day: 'monday'
          time: '09:00'
          timezone: 'Europe/Kyiv'
      groups:
          github-actions:
              patterns: ['*']
```

### GitHub Actions trigger (`.github/workflows/renovate.yml`)

```yaml
on:
    schedule:
        - cron: '0 2 * * *' # nightly at 02:00 UTC
    workflow_dispatch: # manual trigger
```

## One-time setup

1. **Enable auto-merge:** GitHub → repo → Settings → General → Pull Requests → Allow auto-merge ✓
2. **Create `RENOVATE_TOKEN`:** GitHub PAT with `repo` + `workflow` scopes → add to repo secrets

## Consequences

### Positive

- Security patches applied automatically within 3 days of release
- PR queue stays manageable thanks to grouping and schedule
- Major updates are never missed — they get a dedicated PR and a label
- Conventional Commits enforced on all dependency update commits
- No dependency on Renovate Cloud

### Negative

- `RENOVATE_TOKEN` must be created and rotated periodically
- `pnpm-lock.yaml` conflicts require manual resolution
- Auto-merge requires a GitHub repo setting to be enabled

### Neutral

- Renovate runs nightly — not real-time
- Each package group produces at most two open PRs (one minor/patch, one major)

## Related ADRs

- [ADR-0001](ADR-0001-git-workflow-branching-strategy.md) — Conventional Commits format used for dependency update
  commits
- [ADR-0002](ADR-0002-package-manager-pnpm.md) — pnpm is the package manager Renovate updates
- [ADR-0006](ADR-0006-changelog-release-it.md) — `chore(deps)` commits appear in the changelog
