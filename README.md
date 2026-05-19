# docs.template

A documentation and tooling template for software projects.

Clone this repo to get a new project with consistent conventions, documentation structure,
and a working release cycle — without writing everything from scratch.

---

## What's included

| Area               | What you get                                                                     |
| ------------------ | -------------------------------------------------------------------------------- |
| **Git workflow**   | Branch naming rules, commit format (Conventional Commits), PR process            |
| **Git hooks**      | Lefthook: pre-commit (format + lint), commit-msg (commitlint), pre-push (checks) |
| **Release cycle**  | release-it: version bump, CHANGELOG generation, GitHub Release publishing        |
| **Documentation**  | ADR, AIR, architecture, guides — all with templates and indexes                  |
| **AI prompts**     | Claude prompts for generating project-specific docs from a single onboarding run |
| **Project memory** | `docs/context/` — persistent context readable by Claude and humans               |
| **CI/CD**          | GitHub Actions: lint, format check, Renovate, Dependabot                         |

---

## Quick start

### 1. Install global tools

These must be installed globally — local pnpm installation does not work reliably
with git hooks on WSL2 (see `AGENTS.md` for explanation):

```bash
npm install -g commitlint @commitlint/cli @commitlint/config-conventional
npm install -g release-it @release-it/conventional-changelog
npm install -g prettier markdownlint-cli2
```

### 2. Install dependencies and hooks

```bash
pnpm install
pnpm run init
```

### 3. Configure git

```bash
git config commit.template scripts/.gitmessage
git config --global pull.rebase true
```

### 4. Add required secrets to GitHub

| Secret           | Purpose                              | How to get                                                 |
| ---------------- | ------------------------------------ | ---------------------------------------------------------- |
| `RENOVATE_TOKEN` | Renovate opens dependency PRs        | GitHub PAT with `repo` + `workflow` scopes                 |
| `GITHUB_TOKEN`   | release-it publishes GitHub Releases | Auto-provided by GitHub Actions (enable write permissions) |

### 5. Run the onboarding prompt

Open a new Claude session and paste the contents of `docs/prompts/onboarding.md`.
Claude will ask a few questions and generate all project-specific documents.

---

## Commands

| Command                 | Description                                 |
| ----------------------- | ------------------------------------------- |
| `pnpm install`          | Install dependencies                        |
| `pnpm run init`         | Install git hooks + make scripts executable |
| `pnpm lint`             | Run markdownlint on all markdown files      |
| `pnpm lint:fix`         | Auto-fix markdownlint issues                |
| `pnpm format`           | Format all files with Prettier              |
| `pnpm format:check`     | Check formatting without making changes     |
| `npm run release:dry`   | Preview release — no changes made           |
| `npm run release:patch` | Release patch version bump                  |
| `npm run release:minor` | Release minor version bump                  |
| `npm run release:major` | Release major version bump                  |

> Use `npm run` for release commands (not `pnpm run`) to avoid ELIFECYCLE noise.

---

## Documentation

| Document                                                                     | Description                                |
| ---------------------------------------------------------------------------- | ------------------------------------------ |
| [AGENTS.md](AGENTS.md)                                                       | Guide for AI agents working in this repo   |
| [docs/guides/git-workflow.md](docs/guides/git-workflow.md)                   | Branch naming, commit format, PR flow      |
| [docs/guides/release-flow.md](docs/guides/release-flow.md)                   | Release process and commands               |
| [docs/guides/git-config.md](docs/guides/git-config.md)                       | One-time local git setup                   |
| [docs/guides/updating-dependencies.md](docs/guides/updating-dependencies.md) | Renovate + Dependabot                      |
| [docs/adr/INDEX.md](docs/adr/INDEX.md)                                       | Architecture Decision Records              |
| [docs/air/INDEX.md](docs/air/INDEX.md)                                       | Architecture Issue Records                 |
| [docs/prompts/](docs/prompts/)                                               | Claude prompts for generating project docs |
| [CHANGELOG.md](CHANGELOG.md)                                                 | Release history                            |

---

## License

[MIT](LICENSE.md)
