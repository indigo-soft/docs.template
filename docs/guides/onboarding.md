# Onboarding Guide

Welcome to the project. This guide gets you from zero to a working local setup
and your first contribution.

## Prerequisites

Before you start, make sure you have the following installed globally:

```bash
node --version    # 24+
pnpm --version    # 10+
git --version     # 2.40+
```

Install the required global tools:

```bash
npm install -g commitlint @commitlint/cli @commitlint/config-conventional
npm install -g release-it @release-it/conventional-changelog
npm install -g prettier markdownlint-cli2
```

> These tools are installed globally rather than locally due to a pnpm + WSL2 symlink
> issue. See `docs/adr/ADR-0002-package-manager-pnpm.md` for background.

## Setup steps

### 1. Clone the repository

```bash
git clone {repository-url}
cd {project-name}
```

### 2. Configure your local git

Follow `docs/guides/git-config.md` for one-time git setup (name, email, commit template).

### 3. Run the init script

```bash
pnpm run init
```

This installs dependencies, sets up git hooks, and configures your local environment.

### 4. Copy and fill in the environment file

```bash
cp .env.example .env
```

Edit `.env` with your local values. See the project README for required variables.

### 5. Verify the setup

```bash
pnpm run start
```

This shows the project status and confirms that hooks, tools, and environment are working.

## First steps

- Read `docs/context/project.md` — core project facts, stack, and team conventions
- Read `docs/guides/git-workflow.md` — branching, commit format, PR process
- Read `docs/guides/coding-standards.md` — language and style conventions
- Browse `docs/adr/` — understand the key decisions already made

## Making your first contribution

1. Create a branch following the naming convention in `docs/guides/git-workflow.md`
2. Make your changes
3. Commit using the Conventional Commits format — the hook will validate it
4. Open a pull request and fill in the PR template
5. Request a review from a team member

## Getting help

- Check `docs/guides/` for process and tooling guidance
- Check `docs/adr/` to understand why things are the way they are
- Check `docs/context/decisions.md` for smaller decisions not captured in ADRs
- Ask in the team channel or open a GitHub Discussion
