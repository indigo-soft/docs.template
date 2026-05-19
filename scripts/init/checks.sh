#!/usr/bin/env bash
# checks.sh — init check and setup functions.
# Usage: source "$(dirname "${BASH_SOURCE[0]}")/checks.sh"

# shellcheck source=../libs/colors.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../libs/colors.sh"

# Global npm packages required for the project.
# Format: "binary:package1 package2"
REQUIRED_GLOBAL_PACKAGES=(
    "commitlint:@commitlint/cli @commitlint/config-conventional"
    "release-it:release-it @release-it/conventional-changelog"
    "prettier:prettier"
    "markdownlint-cli2:markdownlint-cli2"
)

check_global_tools() {
    log_info "🔍 Checking global npm tools..."

    for entry in "${REQUIRED_GLOBAL_PACKAGES[@]}"; do
        local binary packages
        binary="${entry%%:*}"
        packages="${entry#*:}"

        if command -v "$binary" &>/dev/null; then
            log_success "  $binary — already installed ($(command -v "$binary"))"
        else
            log_info "  $binary — not found, installing: $packages"
            # shellcheck disable=SC2086
            npm install -g $packages
            log_success "  $binary — installed"
        fi
    done
}

check_pnpm() {
    if ! command -v pnpm &>/dev/null; then
        log_error "pnpm not found. Install it first: npm install -g pnpm"
        exit 1
    fi
}

install_dependencies() {
    log_info "📦 Installing local pnpm dependencies..."
    pnpm install
    log_success "pnpm dependencies installed."
}

install_hooks() {
    log_info "🪝 Installing Lefthook git hooks..."
    pnpm exec lefthook install
    log_success "Lefthook hooks installed."
}

make_scripts_executable() {
    local root_dir="${1:-$(pwd)}"
    log_info "🔧 Making scripts executable..."
    find "$root_dir/scripts" -name "*.sh" -exec chmod +x {} +
    log_success "Scripts are executable."
}

setup_env() {
    local root_dir="${1:-$(pwd)}"
    if [ -f "$root_dir/.env" ]; then
        log_success "  .env — already exists, skipping."
    else
        cp "$root_dir/.env.example" "$root_dir/.env"
        log_success "  .env — created from .env.example."
    fi
}

setup_git_template() {
    log_info "📝 Configuring git commit message template..."
    git config commit.template .gitmessage
    log_success "  Commit template → .gitmessage"
}

print_done() {
    echo ""
    log_success "✅ Project initialized successfully!"
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    log_info "  ⚠️  ACTION REQUIRED"
    echo ""
    log_text "  Add GITHUB_TOKEN to .env to enable GitHub Releases:"
    log_text "  GITHUB_TOKEN=ghp_xxxxxxxxxxxxxxxxxxxx"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
}
