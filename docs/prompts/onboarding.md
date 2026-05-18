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

### `package.json` (if missing)

Create with the following structure, substituting project-specific values.
Do NOT include `"type": "module"` unless the project has JS/TS source files that use ESM imports.

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
    "init": "pnpm exec lefthook install && find scripts -name '*.sh' -exec chmod +x {} +",
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
  "devDependencies": {
    "@commitlint/cli": "^21.0.0",
    "@commitlint/config-conventional": "^21.0.0",
    "@release-it/conventional-changelog": "^11.0.0",
    "lefthook": "^2.1.6",
    "release-it": "^20.0.1"
  }
}
```

> ⚠️ Do NOT name the hook-install script `setup` — `pnpm setup` is a pnpm built-in command
> that configures pnpm itself and will NOT run your script. Use `init` or another name,
> and always call it as `pnpm run init`.

### `.npmrc`

```properties
shamefully-hoist=true
node-linker=hoisted
```

This makes pnpm install packages as real directories (not symlinks), which is required
for Node.js to correctly resolve ESM dependencies of commitlint in git hook context.

### `commitlint.config.js` (if missing)

Copy from `docs.template/commitlint.config.js` and add the project-specific
`scope-enum` rule using the scopes from Group 4, question 14:

```js
'scope-enum': [2, 'always', ['scope1', 'scope2', ...]],
```

### `lefthook.yml` (if missing)

Create adapted to the project's primary language.
Use `node node_modules/@commitlint/cli/cli.js` for commitlint — direct node call
works reliably in git hook context with `node-linker=hoisted`.

- **PHP projects:** `pre-commit` → `composer fix`; `pre-push` → `composer stan` + `composer test`
- **JS/TS projects:** `pre-commit` → prettier + eslint; `pre-push` → typecheck + test
- **All projects:** `commit-msg` → `node node_modules/@commitlint/cli/cli.js --edit {1} --verbose`

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
**Node.js tooling:** created package.json / commitlint.config.js / lefthook.yml
**Notes:** {anything non-obvious about the project setup}
```

3. Show the user `docs/checklists/new-project.md` so they can see what to do next.
