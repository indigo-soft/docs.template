#!/usr/bin/env bash
# init.sh — project initialization script.
#
# Usage: pnpm run init
#        bash scripts/init/init.sh
#
# What it does:
#   1. Checks Node.js is installed and meets minimum version requirement.
#   2. Checks that required global npm tools are installed; installs missing ones.
#   3. Enables corepack for pnpm.
#   4. Installs pnpm local dependencies (lefthook).
#   5. Installs Lefthook git hooks.
#   6. Makes all shell scripts in scripts/ executable.
#   7. Copies .env.example to .env if .env does not exist.
#   8. Configures git commit message template.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"

# shellcheck source=checks.sh
source "$SCRIPT_DIR/checks.sh"

cd "$ROOT_DIR"

check_node
check_global_tools
check_corepack
check_pnpm
install_dependencies
install_hooks
make_scripts_executable "$ROOT_DIR"
setup_env "$ROOT_DIR"
setup_git_template
print_done
