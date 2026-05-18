# ADR-0001: Git Workflow and Branching Strategy

**Status:** Accepted
**Date:** 2026-05-11

---

## Context

Every project needs a clear Git strategy covering:

- When and how to create branches
- How to name branches
- How to write commit messages
- When and how to merge
- How to organise releases

Requirements:

- Simple enough for small teams and solo developers
- Clean, readable git history
- Support for CI/CD
- Easy rollback capability

Strategies considered: GitHub Flow, Git Flow, Trunk-Based Development, GitLab Flow.

## Decision

Use **GitHub Flow** combined with **Conventional Commits**.

## Considered Options

### GitHub Flow ✅ Chosen

- One main branch (`main`), always deployable
- Short-lived feature branches per task
- Pull Requests for code review
- Every merge to `main` is a potential release

**Pros:** Simple, fast, CI/CD-friendly, suitable for teams of any size.
**Cons:** Requires discipline; no built-in staging gate.

### Git Flow

**Pros:** Good for scheduled/versioned releases.
**Cons:** Multiple long-lived branches, slow releases, overkill for most projects.

### Trunk-Based Development

**Pros:** Fastest integration.
**Cons:** No review gate before merging; requires very high team discipline and mature CI.

### GitLab Flow

**Pros:** Good for multi-environment deployments.
**Cons:** Environment branches add complexity; overkill for small teams.

## Rationale

GitHub Flow wins on simplicity and CI/CD alignment. Conventional Commits add structure to
commit messages, enabling automated changelog generation and semantic versioning.

## Branch Naming

```text
<type>/<issue-number>-<short-description>
```

- **Types:** `feature`, `fix`, `docs`, `refactor`, `test`, `chore`, `perf`
- **Issue number:** required, minimum 4 digits (e.g. `0001`, `0042`, `1234`)
- **Description:** kebab-case, English, 3–5 words

```bash
# ✅ Valid
feature/0001-user-authentication
fix/0042-database-connection-timeout
docs/0099-api-reference
chore/1234-update-dependencies

# ❌ Invalid
feature/new-feature          # no issue number
fix/42-bug                   # fewer than 4 digits
```

## Commit Message Format

```text
<type>(<scope>): <subject>

[optional body]

[optional footer]
```

- **scope** is **required** — kebab-case, defines the module or domain area
- **subject** — max 72 chars, lowercase, imperative mood, no trailing period
- **BREAKING CHANGE** in footer triggers a major version bump

## Merge Strategy

Use **Squash and Merge** in GitHub for a clean, linear `main` history.

## Consequences

### Positive

- Clean, searchable git history
- Conventional Commits enable automatic changelog and semantic versioning
- Simple enough to follow consistently

### Negative

- Requires discipline to write good commit messages
- Squash merge discards intermediate commit history from branches

### Neutral

- Team must learn Conventional Commits (low overhead)
- Branch protection rules must be configured in GitHub

## Related ADRs

- [ADR-0005](ADR-0005-git-hooks-lefthook.md) — commit and branch validation via Lefthook + commitlint
- [ADR-0006](ADR-0006-changelog-release-it.md) — automated changelog powered by Conventional Commits
