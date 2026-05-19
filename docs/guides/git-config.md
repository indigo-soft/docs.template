# Git Global Configuration

Run these commands once after cloning the repository.
They configure your local Git to match the project's workflow.

```bash
# Install dependencies and run full initialization
bash scripts/init/init.sh
```

The init script handles automatically:

- Installing required global npm tools (commitlint, release-it, prettier, markdownlint-cli2)
- Installing local pnpm dependencies
- Installing Lefthook git hooks
- Making shell scripts executable
- Creating `.env` from `.env.example`
- Setting git commit message template

## Additional git settings (optional)

```bash
# Rebase instead of merge when pulling (keeps linear history)
git config --global pull.rebase true

# Default branch name for new repositories
git config --global init.defaultBranch main

# Enable colored output
git config --global color.ui auto

# Set your preferred editor (choose one)
git config --global core.editor "code --wait"   # VS Code
git config --global core.editor "vim"
git config --global core.editor "nano"
```

## Verify your setup

```bash
git config --list --local
```

You should see `commit.template` pointing to `.gitmessage` in the project root.
