# ADR-0012: Shell Script Conventions

**Status:** Accepted
**Date:** 2026-05-19

---

## Context

The project includes shell scripts for release automation (`scripts/release/`) and project
initialization (`scripts/init/`). Without consistent conventions, shell scripts become hard
to read, test, and maintain — especially when shared output formatting and environment
loading are needed across multiple scripts.

## Decision

All shell scripts follow these conventions:

1. **Function-based structure** — logic is extracted into named functions; entry-point
   scripts are thin orchestrators that call functions in order.
2. **Shared libraries** — common functionality lives in `scripts/libs/` and is sourced
   at the top of each script that needs it.
3. **No execute permissions required** — scripts are invoked via `bash script.sh`,
   not `./script.sh`, so `+x` is not required for entry points.
4. **`set -euo pipefail`** — all entry-point scripts use strict error handling.

## Script structure

### Entry-point script

```bash
#!/usr/bin/env bash
# purpose.sh — one-line description.
#
# Usage: bash scripts/<dir>/purpose.sh [options]

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"

# Source libraries
# shellcheck source=../libs/colors.sh
source "$SCRIPT_DIR/../libs/colors.sh"

# Source local function file (if split)
# shellcheck source=checks.sh
source "$SCRIPT_DIR/checks.sh"

cd "$ROOT_DIR"

# Call functions in order
function_one
function_two "$ROOT_DIR"
```

### Function file (sourced, not executed directly)

```bash
#!/usr/bin/env bash
# checks.sh — functions for <purpose>.
# Usage: source "$(dirname "${BASH_SOURCE[0]}")/checks.sh"

# shellcheck source=../libs/colors.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../libs/colors.sh"

my_function() {
    local arg="${1:-}"
    log_step "Doing something..."
    # ...
    log_success "Done."
}
```

## Shared libraries (`scripts/libs/`)

### `colors.sh`

Colored output functions. Source in any script that produces console output.

| Function      | Output    | Use for                        |
| ------------- | --------- | ------------------------------ |
| `log_error`   | red + ❌  | Errors (also writes to stderr) |
| `log_success` | green + ✔ | Successful steps               |
| `log_info`    | yellow    | Section headers, warnings      |
| `log_text`    | white     | Plain informational text       |
| `log_step`    | white + → | Individual check steps         |

### `env.sh`

Safe `.env` file loader. Source when a script needs environment variables from `.env`.

```bash
source "$LIBS_DIR/env.sh"
load_env "$ROOT_DIR"   # loads $ROOT_DIR/.env into the environment
```

Safe by design — does not evaluate or execute values; strips quotes; skips comments.

## Directory layout

```text
scripts/
    libs/
        colors.sh       ← output formatting (always available)
        env.sh          ← .env loader (source when needed)
    init/
        init.sh         ← entry point: sources checks.sh, calls functions
        checks.sh       ← all init functions
    release/
        release.sh      ← entry point: sources checks.sh, calls functions
        checks.sh       ← all pre-release check functions
```

## Consequences

### Positive

- Entry-point scripts are short and readable — the sequence of steps is immediately visible
- Functions are individually testable and reusable across scripts
- Consistent output formatting via `colors.sh` across all scripts
- `shellcheck` directives on `source` statements enable static analysis

### Negative

- More files than a single monolithic script
- Sourcing requires careful path handling (`BASH_SOURCE[0]`)

### Neutral

- Scripts are run via `bash script.sh` — no `chmod +x` needed for entry points
- Function files use `#!/usr/bin/env bash` shebang for editor syntax highlighting,
  but are sourced, not executed directly

## Related ADRs

- [ADR-0006](ADR-0006-changelog-release-it.md) — release scripts follow these conventions
