# Contributing Guide

Thank you for your interest in contributing!

## Before you start

1. Read [Git Workflow Guide](docs/guides/git-workflow.md)
2. Set up your local environment (see [README.md](README.md))
3. Review the [Code of Conduct](CODE_OF_CONDUCT.md)

## Quick start

```bash
# 0. One-time setup after cloning (tools, hooks, .env, git template)
pnpm run init

# 1. Create a branch (issue number is REQUIRED)
git checkout -b feature/0123-my-change

# 2. Make commits
git commit -m "feat(scope): description"

# 3. Push and open a PR
git push -u origin feature/0123-my-change
```

## Git workflow

See [docs/guides/git-workflow.md](docs/guides/git-workflow.md) for the full guide.

Key rules:

- Branch format: `<type>/<issue-number>-<description>` (issue number min 4 digits)
- Commit format: `<type>(<scope>): <description>` (scope is required, subject max 120 chars)
- Merge strategy: Squash and Merge

## PR checklist

Before opening a PR:

- [ ] Commit messages follow Conventional Commits
- [ ] `pnpm run lint:check` passes
- [ ] `pnpm run format:check` passes
- [ ] Documentation updated if needed — config, scripts, and docs must stay in sync
      (see `AGENTS.md → Keep config, scripts, and docs in sync`)
- [ ] PR title matches commit message format

## Local commands

```bash
pnpm run init         # one-time setup: global tools, dependencies, git hooks, .env
pnpm start            # show project status and the next recommended step
pnpm run lint:check   # check markdown without fixing
pnpm run lint:fix     # auto-fix markdownlint issues
pnpm run lint         # fix then check (combined — modifies files)
pnpm run format:check # check formatting without making changes
pnpm run format:fix   # format all files with Prettier
pnpm run format       # fix then check (combined — modifies files)
```

## Adding documentation

When adding new guides or document types:

- Guides → `docs/guides/`
- ADRs → `docs/adr/` (use prompt `docs/prompts/adr.md`)
- AIRs → `docs/air/` (ADR conflicts only; use prompt `docs/prompts/air.md`)
- AIDs → `docs/aid/` (AI interactions; use prompt `docs/prompts/aid.md`)
- RFCs → `docs/rfc/` (pre-decision proposals)
- Claude prompts → `docs/prompts/`

When adding new terms or tools, check `docs/glossary/glossary.md` and add missing definitions.

## Reporting bugs

Open a GitHub issue with:

- Steps to reproduce
- Expected vs actual behavior
- Environment (OS, Node version, pnpm version)

## Security vulnerabilities

Do **not** open a public GitHub issue.
Follow the process described in [SECURITY.md](SECURITY.md).

## License

By contributing, you agree that your code will be licensed under [MIT](LICENSE.md).
