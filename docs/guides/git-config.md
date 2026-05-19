# Git Global Configuration

Run these commands once after cloning the repository.
They configure your local Git to match the project's workflow.

```bash
# Use project commit message template (shows valid types and scopes)
git config commit.template scripts/.gitmessage

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

# Install Node.js dependencies and git hooks
pnpm install
pnpm run init
```

## Verify your setup

```bash
git config --list --local
```

You should see `commit.template` pointing to `scripts/.gitmessage` in the project root.
