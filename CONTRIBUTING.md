# Contributing Guide

Thank you for your interest in contributing!

## Before you start

1. Read [Git Workflow Guide](docs/guides/git-workflow.md)
2. Set up your local environment (see [README.md](README.md))
3. Review the [Code of Conduct](CODE_OF_CONDUCT.md)

## Quick start

```bash
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
- Commit format: `<type>(<scope>): <description>` (scope is required)
- Merge strategy: Squash and Merge

## PR checklist

Before opening a PR:

- [ ] Commit messages follow Conventional Commits
- [ ] `pnpm lint` passes
- [ ] `pnpm format:check` passes
- [ ] Documentation updated if needed
- [ ] PR title matches commit message format

## Local commands

```bash
pnpm install        # install dependencies
pnpm run init       # install git hooks
pnpm lint           # run markdownlint
pnpm lint:fix       # auto-fix lint issues
pnpm format         # format all files
pnpm format:check   # check formatting
```

## Adding documentation

When adding new guides or document types:

- Guides → `docs/guides/`
- ADRs → `docs/adr/` (use prompt `docs/prompts/adr.md`)
- AIRs → `docs/air/` (ADR conflicts only)
- AIDs → `docs/aid/` (AI interactions)
- Claude prompts → `docs/prompts/`

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
