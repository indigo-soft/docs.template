# Dependency Updates Guide

Two tools split the responsibility for keeping dependencies up to date:

| Tool           | Scope                                 | Schedule                      |
| -------------- | ------------------------------------- | ----------------------------- |
| **Renovate**   | npm packages (`package.json`)         | Every 3 days (nightly CI run) |
| **Dependabot** | GitHub Actions (`.github/workflows/`) | Weekly (every Monday)         |

## How Renovate works

Renovate runs nightly via GitHub Actions. On each run it:

1. Checks `package.json` for outdated dependencies.
2. Groups them by functionality.
3. Applies the `"every 3 days"` schedule filter — skips creation if updated recently.
4. Opens grouped PRs.
5. Auto-merges patch/minor PRs once CI passes and `minimumReleaseAge: 3 days` is reached.

## Automatic vs manual

### ✅ Automatic (no action needed)

| Update type                         | What happens                        |
| ----------------------------------- | ----------------------------------- |
| **patch** (e.g. `1.2.3` → `1.2.4`)  | PR opened → CI passes → auto-merged |
| **minor** (e.g. `1.2.0` → `1.3.0`)  | PR opened → CI passes → auto-merged |
| **GitHub Actions** (via Dependabot) | PR opened → CI passes → auto-merged |

> Auto-merge requires **"Allow auto-merge"** enabled in GitHub repo settings:
> **Settings → General → Pull Requests → Allow auto-merge** ✓

### 🔍 Manual review required

| Update type                    | Why                       | Label                          |
| ------------------------------ | ------------------------- | ------------------------------ |
| **major** (e.g. `1.x` → `2.x`) | Breaking changes possible | `major-update`, `needs-review` |
| Any update that **breaks CI**  | Tests or lint fail        | PR stays open                  |
| `pnpm-lock.yaml` conflicts     | Manual rebase needed      | —                              |

## One-time setup

### 1. Enable auto-merge on GitHub

**Settings → General → Pull Requests → Allow auto-merge** ✓

### 2. Create `RENOVATE_TOKEN` secret

Renovate needs a GitHub PAT to open PRs:

1. Go to [github.com/settings/tokens](https://github.com/settings/tokens)
2. **Generate new token (classic)** — scopes: `repo` + `workflow`
3. Go to **GitHub → repo → Settings → Secrets → Actions**
4. Add secret: `RENOVATE_TOKEN` = `ghp_xxxx...`

## Triggering Renovate manually

1. Go to **GitHub → Actions → Renovate**
2. Click **Run workflow**

## Handling major updates

1. Read the package's **CHANGELOG / Migration Guide**.
2. Check for breaking changes.
3. Update the code as needed.
4. Run tests and lint locally.
5. Approve and merge the PR.

> Major updates are **never auto-merged**.

## Handling stuck PRs

### `pnpm-lock.yaml` conflicts

```bash
git checkout renovate/some-package-name
pnpm install
git add pnpm-lock.yaml
git commit -m "chore(deps): fix pnpm-lock.yaml conflict"
git push
```

### Renovate PR not appearing

- Check the **Renovate workflow** in GitHub Actions for errors.
- Ensure `RENOVATE_TOKEN` is valid and not expired.
- Validate config: `renovate-config-validator renovate.json`

## Skipping a specific update

```json
"packageRules": [
  {
    "matchPackageNames": ["some-package"],
    "enabled": false
  }
]
```

Or pin to a version range:

```json
{
  "matchPackageNames": ["some-package"],
  "allowedVersions": "< 3.0.0"
}
```

## Running Renovate locally (dry run)

```bash
npm install -g renovate

RENOVATE_TOKEN=ghp_xxxx \
RENOVATE_DRY_RUN=full \
renovate --platform=github --token=$RENOVATE_TOKEN your-org/your-repo
```

## Configuration files

| File                             | Purpose                                              |
| -------------------------------- | ---------------------------------------------------- |
| `renovate.json`                  | Renovate config (groups, schedule, auto-merge rules) |
| `.github/dependabot.yml`         | Dependabot config (GitHub Actions only)              |
| `.github/workflows/renovate.yml` | Nightly Renovate trigger                             |
