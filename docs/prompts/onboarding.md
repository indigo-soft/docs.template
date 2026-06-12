# Prompt: Project Onboarding

## Purpose

Collect the core facts about a new (or existing) project and save them to
`docs/context/project.md`. This context is then read silently by all other prompts,
so you only answer these questions once.

Run this prompt first, before any other prompt in `docs/prompts/`.

## Instructions for Claude

1. Read existing project files first (silently):
   - `README.md`, `AGENTS.md`, `composer.json`, `package.json`, `pyproject.toml` — extract
     as many facts as possible before asking questions.
2. Ask questions below one group at a time — only what is not already known from files.
3. After all answers are collected:
   - Generate `docs/context/project.md`
   - Set up Node.js tooling (see section below)
   - Show the user `docs/checklists/new-project.md`

## Questions

### Group 1 — Identity

1. **Project name** — the canonical name used in code, package.json, README, etc.
2. **Short description** — one or two sentences: what does this project do and for whom?
3. **Repository URL** — e.g. `https://github.com/org/repo`
4. **Primary language(s)** — e.g. TypeScript, PHP, Python, Go

### Group 2 — Tech stack

5. **Runtime / platform** — e.g. Node.js 24, PHP 8.3 + FrankenPHP, Python 3.12
6. **Main framework(s)** — e.g. NestJS, Laravel, FastAPI, Next.js
7. **Package manager** — e.g. pnpm, npm, yarn, composer, pip + uv
8. **Database(s)** — e.g. PostgreSQL 16, MySQL 8, MongoDB, Redis (as primary store)
9. **Key third-party services** — e.g. Stripe, SendGrid, AWS S3, Auth0

### Group 3 — Infrastructure

10. **Deployment target** — e.g. AWS ECS, Vercel, DigitalOcean, VPS, local CLI
11. **CI/CD platform** — e.g. GitHub Actions, GitLab CI, Bitbucket Pipelines, none yet
12. **Environments** — e.g. local, staging, production (list all)

### Group 4 — Team & process

13. **Team size** — roughly how many developers work on this project?
14. **Commit scopes** — what are the main domain areas / modules?
    These become the allowed scopes in commitlint (e.g. `auth`, `billing`, `api`, `ui`, `db`).
    List as many as known; more can be added later.
15. **Documentation language(s)** — English only, or multilingual?
    If multilingual, list languages (e.g. `en`, `uk`).

## Node.js Tooling Setup

Every project uses Node.js dev tooling regardless of primary language.
After saving `docs/context/project.md`, check whether these files exist.
If any are missing — create them.

### Prerequisites (must be installed once per machine)

```bash
# 1. Node.js v24+ — install via nvm (recommended) or https://nodejs.org
nvm install 24 && nvm use 24

# 2. Corepack — built into Node.js, enables managed package managers
npm install -g corepack
corepack enable pnpm

# 3. Global tools — installed globally due to pnpm WSL2 isolated linker limitations
npm install -g commitlint @commitlint/cli @commitlint/config-conventional
npm install -g release-it @release-it/conventional-changelog
npm install -g prettier markdownlint-cli2
```

> The `pnpm run init` script checks Node.js version, enables corepack, and installs
> all global tools automatically — except Node.js itself which must be installed first.

### `pnpm-workspace.yaml` (if missing)

Create in the project root to approve lefthook's `postinstall` build script
(pnpm requires explicit approval before running dependency build scripts):

```yaml
allowBuilds:
  lefthook: true
```

> ⚠️ Since pnpm v11, pnpm-specific settings live **only** in `pnpm-workspace.yaml`
> (or the global `~/.config/pnpm/config.yaml`) — `.npmrc` and `.pnpmrc` are not read
> for non-auth settings. During install, pnpm auto-adds unlisted build-script
> dependencies with a placeholder of `false`; make sure `lefthook` is set to `true`.

### `package.json` (if missing)

Create with the following structure, substituting project-specific values.
Do NOT include `"type": "module"` unless the project has JS/TS source files that use ESM imports.
Do NOT add `commitlint`, `release-it` or `prettier` to `devDependencies` — they are global.

```json
{
  "name": "{project-name}",
  "version": "0.1.0",
  "description": "{short description}",
  "private": true,
  "homepage": "{repository-url}#readme",
  "bugs": { "url": "{repository-url}/issues" },
  "repository": { "type": "git", "url": "git+{repository-url}.git" },
  "license": "MIT",
  "author": "github.com/{org}",
  "scripts": {
    "start": "bash scripts/start/start.sh",
    "init": "bash scripts/init/init.sh",
    "release": "bash scripts/release/release.sh",
    "release:dry": "bash scripts/release/release.sh --dry",
    "release:patch": "bash scripts/release/release.sh --type=patch",
    "release:minor": "bash scripts/release/release.sh --type=minor",
    "release:major": "bash scripts/release/release.sh --type=major"
  },
  "engines": {
    "node": ">=24.0.0",
    "pnpm": ">=10.0.0"
  },
  "release-it": {
    "extends": "./.release-it.json"
  },
  "devDependencies": {
    "lefthook": "^2.1.6"
  }
}
```

> ⚠️ Do NOT name the hook-install script `setup` — `pnpm setup` is a pnpm built-in command
> that configures pnpm itself. Use `init` and call it as `pnpm run init`.

### `commitlint.config.mjs` (if missing)

Copy from `docs.template/commitlint.config.mjs`. Record the project scopes from
Group 4, question 14 in `docs/context/project.md` — they are the source of truth.
Optionally, add a `scope-enum` rule to enforce the list strictly:

```javascript
'scope-enum': [2, 'always', ['auth', 'api', 'ui', 'db', 'config', 'deps']],
```

Use `.mjs` extension (not `.js`) — required for Node.js v24 ESM compatibility.
Do not use `extends: ['@commitlint/config-conventional']` — define all rules inline
to avoid dependency on locally installed packages.

### `lefthook.yml` (if missing)

Create adapted to the project's primary language.
Use `commitlint --edit {1} --verbose` — relies on the global installation.

- **PHP projects:** `pre-commit` → `composer fix`; `pre-push` → `composer stan` + `composer test`
- **JS/TS projects:** `pre-commit` → `prettier --write` + eslint; `pre-push` → typecheck + test
- **All projects:** `commit-msg` → `commitlint --edit {1} --verbose`

## Output

Create or overwrite `docs/context/project.md`:

```markdown
# Project Context

> Generated by onboarding prompt on {YYYY-MM-DD}.
> Update this file when core facts change.

## Identity

- **Name:** {project name}
- **Description:** {short description}
- **Repository:** {url}
- **Primary language(s):** {languages}

## Tech Stack

- **Runtime:** {runtime}
- **Framework(s):** {frameworks}
- **Package manager:** {package manager}
- **Database(s):** {databases}
- **Key services:** {services}

## Infrastructure

- **Deployment:** {target}
- **CI/CD:** {platform}
- **Environments:** {list}

## Team & Process

- **Team size:** {size}
- **Commit scopes:** {comma-separated list}
- **Docs language(s):** {languages}
```

## After completion

1. Check off `onboarding` and `commit scopes` in `docs/checklists/new-project.md`.
2. Create the first entry in `docs/context/decisions.md`:

```markdown
## {YYYY-MM-DD} — Project onboarding completed

**Stack:** {runtime} + {framework}
**Deployment:** {target}
**Node.js tooling:** created package.json / commitlint.config.mjs / lefthook.yml / pnpm-workspace.yaml
**Notes:** {anything non-obvious about the project setup}
```

3. Show the user `docs/checklists/new-project.md` so they can see what to do next.
