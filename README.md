# docs.template

A documentation and tooling template for software projects with AI-assisted onboarding —
Claude prompts, decision records ([ADR](docs/glossary/glossary.md#adr)/[AIR](docs/glossary/glossary.md#air)/[AID](docs/glossary/glossary.md#aid)/[RFC](docs/glossary/glossary.md#rfc)),
git conventions, and release automation ready to use.

---

## What's included

| Area                 | What you get                                                                                                                                          |
| -------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Git workflow**     | Branch naming rules, commit format ([Conventional Commits](docs/glossary/glossary.md#conventional-commits)), PR process                               |
| **Git hooks**        | [Lefthook](docs/glossary/glossary.md#lefthook): pre-commit (format + lint), commit-msg ([commitlint](docs/glossary/glossary.md#commitlint)), pre-push |
| **Release cycle**    | [Release-it](docs/glossary/glossary.md#release-it): version bump, CHANGELOG generation, GitHub Release publishing                                     |
| **Decision records** | ADR, AIR, AID, RFC — all with templates, indexes, and archive                                                                                         |
| **Documentation**    | Architecture, guides, checklists, [glossary](docs/glossary/glossary.md) — structured and linked                                                       |
| **AI prompts**       | Claude prompts for generating project-specific docs from a single onboarding run                                                                      |
| **Project memory**   | `docs/context/` — persistent context readable by Claude and humans                                                                                    |
| **Init wizard**      | `pnpm run init` — installs tools, hooks, .env, git template in one command                                                                            |
| **Status wizard**    | `pnpm start` — shows project status and recommends the next step                                                                                      |
| **CI/CD**            | GitHub Actions: lint, format check, link check, Renovate, Dependabot                                                                                  |

---

## Quick start

### 1. Initialize the project

```bash
pnpm run init
```

The script automatically:

- Checks and installs required global tools (commitlint, release-it, prettier, markdownlint-cli2)
- Installs local pnpm dependencies (lefthook)
- Installs git hooks
- Creates `.env` from `.env.example`
- Configures git commit message template

### 2. Add required secrets to GitHub

| Secret           | Purpose                              | How to get                                                 |
| ---------------- | ------------------------------------ | ---------------------------------------------------------- |
| `RENOVATE_TOKEN` | Renovate opens dependency PRs        | GitHub PAT with `repo` + `workflow` scopes                 |
| `GITHUB_TOKEN`   | release-it publishes GitHub Releases | Auto-provided by GitHub Actions (enable write permissions) |

### 3. Run the onboarding prompt

Open a new Claude session and paste the contents of `docs/prompts/onboarding.md`.
Claude will ask a few questions and generate all project-specific documents.

### 4. Check project status

```bash
pnpm start
```

---

## Commands

| Command                 | Description                                        |
| ----------------------- | -------------------------------------------------- |
| `pnpm start`            | Show project status and next recommended step      |
| `pnpm run init`         | Full project initialization (run once after clone) |
| `pnpm run lint:fix`     | Auto-fix markdownlint issues                       |
| `pnpm run lint:check`   | Check markdown without fixing                      |
| `pnpm run lint`         | Fix then check (combined)                          |
| `pnpm run format:fix`   | Format all files with Prettier                     |
| `pnpm run format:check` | Check formatting without making changes            |
| `pnpm run format`       | Fix then check (combined)                          |
| `npm run release:dry`   | Preview release — no changes made                  |
| `npm run release:patch` | Release patch version bump                         |
| `npm run release:minor` | Release minor version bump                         |
| `npm run release:major` | Release major version bump                         |

> Use `npm run` for release commands (not `pnpm run`) to avoid ELIFECYCLE noise.

---

## Documentation

| Document                                                                     | Description                                          |
| ---------------------------------------------------------------------------- | ---------------------------------------------------- |
| [AGENTS.md](AGENTS.md)                                                       | Guide for AI agents working in this repo             |
| [docs/glossary/glossary.md](docs/glossary/glossary.md)                       | Definitions of all terms used across the project     |
| [docs/guides/onboarding.md](docs/guides/onboarding.md)                       | Getting started for new team members                 |
| [docs/guides/git-workflow.md](docs/guides/git-workflow.md)                   | Branch naming, commit format, PR flow                |
| [docs/guides/code-review.md](docs/guides/code-review.md)                     | Code review principles and what to check             |
| [docs/guides/release-flow.md](docs/guides/release-flow.md)                   | Release process and commands                         |
| [docs/guides/docs-style-guide.md](docs/guides/docs-style-guide.md)           | How to write documentation in this project           |
| [docs/guides/git-config.md](docs/guides/git-config.md)                       | One-time local git setup                             |
| [docs/guides/updating-dependencies.md](docs/guides/updating-dependencies.md) | Renovate + Dependabot workflow                       |
| [docs/adr/INDEX.md](docs/adr/INDEX.md)                                       | ADR — Architecture Decision Records                  |
| [docs/air/INDEX.md](docs/air/INDEX.md)                                       | AIR — Architecture Issue Records                     |
| [docs/aid/INDEX.md](docs/aid/INDEX.md)                                       | AID — AI Interaction Documents                       |
| [docs/rfc/INDEX.md](docs/rfc/INDEX.md)                                       | RFC — Requests for Comments (pre-decision proposals) |
| [docs/checklists/new-project.md](docs/checklists/new-project.md)             | Master checklist for setting up a new project        |
| [docs/checklists/code-review.md](docs/checklists/code-review.md)             | Pre-approve checklist for reviewers                  |
| [docs/checklists/release.md](docs/checklists/release.md)                     | Combined human + AI release checklist                |
| [docs/checklists/new-feature.md](docs/checklists/new-feature.md)             | Combined human + AI new feature checklist            |
| [docs/prompts/](docs/prompts/)                                               | Claude prompts for generating project docs           |
| [CHANGELOG.md](CHANGELOG.md)                                                 | Release history                                      |
| [ROADMAP.md](ROADMAP.md)                                                     | Planned milestones                                   |

---

## Built with

| Tool                                                                 | Author                                                               | Purpose                      |
| -------------------------------------------------------------------- | -------------------------------------------------------------------- | ---------------------------- |
| [Lefthook](https://github.com/evilmartians/lefthook)                 | [Evil Martians](https://evilmartians.com)                            | Git hooks manager            |
| [commitlint](https://commitlint.js.org)                              | [@conventional-changelog](https://github.com/conventional-changelog) | Commit message validation    |
| [release-it](https://github.com/release-it/release-it)               | [@release-it](https://github.com/release-it)                         | Release automation           |
| [Prettier](https://prettier.io)                                      | [@prettier](https://github.com/prettier)                             | Code formatter               |
| [markdownlint-cli2](https://github.com/DavidAnson/markdownlint-cli2) | [@DavidAnson](https://github.com/DavidAnson)                         | Markdown linter              |
| [Renovate](https://docs.renovatebot.com)                             | [@renovatebot](https://github.com/renovatebot)                       | Automated dependency updates |

---

## License

[MIT](LICENSE.md)
