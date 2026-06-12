# Git Workflow Guide

> ⚠️ **Read before writing a single line of code.**

## Branching Strategy

We use **GitHub Flow**:

- **`main`** — the only long-lived branch; always deployable
- **Feature branches** — short-lived; one per task
- **Pull Requests** — mandatory before merging into `main`

```text
main (protected)
  ├── feature/0001-implement-auth
  ├── fix/0042-connection-timeout
  ├── docs/0099-api-reference
  └── chore/1234-update-deps
```

## Branch Naming

### Branch Format

```text
<type>/<issue-number>-<short-description>
```

| Rule          | Detail                                                                                                                                                        |
| ------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Issue number  | **Required.** Minimum 4 digits (pad with zeros: `0001`, `0042`)                                                                                               |
| Type          | Same list as commit types (with `feature` instead of `feat`): `feature`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `chore`, `ci`, `build`, `revert` |
| Description   | kebab-case, lowercase, English, 3–5 words                                                                                                                     |
| No issue yet? | Create one before creating the branch                                                                                                                         |

**✅ Valid:**

```bash
feature/0001-user-authentication
fix/0042-database-connection-timeout
docs/0099-api-endpoints
chore/1234-update-dependencies
```

**❌ Invalid:**

```bash
feature/new-feature          # no issue number
fix/42-bug                   # fewer than 4 digits
feature/My_Feature           # not kebab-case
feature/0123-добавить-фичу   # not English
```

## Creating a Branch

```bash
git checkout main
git pull origin main
git checkout -b feature/0001-my-feature
```

## Commit Messages

We follow [Conventional Commits](https://www.conventionalcommits.org/).

### Message Format

```text
<type>(<scope>): <subject>

[optional body]

[optional footer]
```

### Rules

| Field     | Rule                                                                                                           |
| --------- | -------------------------------------------------------------------------------------------------------------- |
| `type`    | Required. One of: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `chore`, `ci`, `build`, `revert` |
| `scope`   | **Required.** kebab-case. Must match project scopes from `docs/context/project.md`                             |
| `subject` | Required. Max 120 chars. Lowercase. Imperative mood. No trailing period                                        |
| `body`    | Optional. Explain _why_, not _what_. Blank line before                                                         |
| `footer`  | Optional. `Closes #123`, `BREAKING CHANGE: ...`                                                                |

### Commit scopes

Scopes are defined per project. Check `docs/context/project.md` for the current list.
Common examples: `auth`, `api`, `ui`, `db`, `config`, `deps`.

### Examples

```bash
# Simple
feat(auth): add JWT authentication

# With body
feat(api): add task creation endpoint

Implements POST /tasks with full validation.
Returns 201 with the created task on success.

# With footer
fix(db): prevent duplicate entries on retry

Fixes #234

# Breaking change
feat(api): remove deprecated v1 endpoints

BREAKING CHANGE: /v1/* endpoints are removed. Use /v2/* instead.

Closes #100
```

### When to commit

✅ Commit when:

- A logical unit of work is complete
- Code compiles without errors
- Tests pass
- Lint checks pass

❌ Do not commit:

- Code that does not compile
- Commented-out debug code
- Unfinished work (use `WIP:` prefix if you must)

### WIP commits

```bash
git commit --no-verify -m "WIP: auth service in progress"
```

> Squash all WIP commits before opening a PR.

## Pull Requests

### Before opening a PR

```bash
git fetch origin
git rebase origin/main
git push --force-with-lease
```

### PR title

Same format as a commit message:

```text
feat(auth): add JWT authentication
```

### After merge

```bash
git checkout main
git pull origin main
git branch -d feature/0001-my-feature
git fetch --prune
```

## Merge Strategy

Use **Squash and Merge** in GitHub. All commits in the branch become one commit in `main`, keeping a clean linear
history.

## Syncing with main

```bash
git fetch origin
git rebase origin/main

# If there are conflicts:
# 1. Resolve conflicts in files
git add <resolved-files>
git rebase --continue

# Push after rebase
git push --force-with-lease
```

## Common Fixes

### Committed to main by mistake

```bash
git reset --soft HEAD~1       # undo commit, keep changes
git checkout -b feature/0123-my-feature
git push -u origin feature/0123-my-feature
```

### Forgot to add a file

```bash
git add forgotten-file.ts
git commit --amend --no-edit
git push --force-with-lease   # if already pushed
```

### Accidentally committed a secret

```bash
# 1. Remove secret from code
git commit -m "fix: remove exposed credential"
git push --force-with-lease

# 2. IMMEDIATELY rotate/revoke the exposed secret
```

## Quick Reference

```bash
# Start work
git checkout main && git pull origin main
git checkout -b feature/0001-my-feature

# Daily work
git status
git add .
git commit -m "feat(scope): description"
git push

# Sync with main
git fetch origin
git rebase origin/main
git push --force-with-lease

# Cleanup after merge
git checkout main && git pull origin main
git branch -d feature/0001-my-feature
git fetch --prune
```

## Further Reading

- [Conventional Commits](https://www.conventionalcommits.org/)
- [GitHub Flow](https://guides.github.com/introduction/flow/)
- ADR: `docs/adr/` — decisions on branching, commit format, and tooling
