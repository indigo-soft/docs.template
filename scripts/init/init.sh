#!/usr/bin/env bash
# init.sh — project initialization script.
#
# Usage: pnpm run init
#        bash scripts/init/init.sh
#
# What it does:
#   1. Checks that required global npm tools are installed; installs missing ones.
#   2. Installs pnpm local dependencies (lefthook).
#   3. Installs Lefthook git hooks.
#   4. Makes all shell scripts in scripts/ executable.
#   5. Copies .env.example to .env if .env does not exist.
#   6. Configures git commit message template.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"

# shellcheck source=checks.sh
source "$SCRIPT_DIR/checks.sh"

cd "$ROOT_DIR"

check_pnpm
check_global_tools
install_dependencies
install_hooks
make_scripts_executable "$ROOT_DIR"
setup_env "$ROOT_DIR"
setup_git_template
print_done
