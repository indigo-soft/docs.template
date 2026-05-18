# Prompt: Generate Coding Standards Guide

## Purpose

Generate `docs/guides/coding-standards.md` (or the language-specific equivalent,
e.g. `docs/en/guides/coding-standards.md`) for this project.

## Prerequisites

Before asking any questions, silently gather context in this order:

1. **Read `docs/context/project.md`** — language, stack, tooling.
2. **Read existing formatter and linter config files** — check for and read all that exist:

   | Config file                                    | Tool          |
   | ---------------------------------------------- | ------------- |
   | `.php-cs-fixer.dist.php` / `.php-cs-fixer.php` | PHP CS Fixer  |
   | `phpstan.neon` / `phpstan.neon.dist`           | PHPStan       |
   | `psalm.xml`                                    | Psalm         |
   | `.eslintrc*` / `eslint.config.*`               | ESLint        |
   | `.prettierrc*` / `prettier.config.*`           | Prettier      |
   | `pyproject.toml` / `ruff.toml`                 | Ruff / Black  |
   | `.golangci.yml`                                | golangci-lint |
   | `commitlint.config.*`                          | commitlint    |
   | `.editorconfig`                                | EditorConfig  |

3. **Read `package.json` / `composer.json` / `pyproject.toml`** — check `scripts` section
   for lint, format, fix, test commands.
4. **Read `lefthook.yml`** — understand which checks run at which git hook stage.
5. **Inspect source code** — read 2–3 representative files to identify:
   - Actual naming conventions used in the codebase
   - PHPDoc / JSDoc / docstring patterns
   - Import ordering
   - Any patterns explicitly forbidden in comments or AGENTS.md

Only ask questions for information that cannot be inferred from config files or source code.

## Questions to ask

Ask only what remains unknown after the inspection above:

### Language & runtime

1. **Secondary languages in the repo?**
   (e.g. shell scripts, SQL migrations, YAML configs — if not obvious from project structure)

### Formatting & linting

2. **Are there custom lint rules or overrides worth documenting?**
   (Only if not self-evident from the config files)

### Code style decisions

3. **Naming conventions** — any project-specific rules beyond what's visible in source code?
4. **Comment style** — PHPDoc / JSDoc / docstrings required for public APIs?
   (Only if not clear from existing source files)

### Architecture-level coding rules

5. **Are there forbidden patterns not visible in source code or AGENTS.md?**
6. **Error handling conventions?**
   (Only if not documented elsewhere)

## Output

Generate `docs/guides/coding-standards.md` with sections:

```text
# Coding Standards

## Language & Runtime
## Formatting
## Linting
## Naming Conventions
## File & Folder Structure
## Import Rules
## Documentation & Comments
## Forbidden Patterns
## Error Handling
## Enforcement
```

Rules:

- Extract concrete rules directly from config files — do not paraphrase vaguely.
  E.g. "PHPStan level 1 (`phpstan.neon.dist`)" not "we use static analysis".
- Include ✅ / ❌ code examples for every non-obvious rule.
- Link to config files where relevant (e.g. `See .php-cs-fixer.dist.php for full rule set`).
- If a violation exists in the current codebase, document it as **tech debt to fix**,
  never as an "exception" or "known pattern". Be explicit: "this must be fixed".
- Write in English.
- Respect `.editorconfig` formatting rules.

## After completion

1. Mark `coding-standards.md` as done in `docs/checklists/new-project.md`.
2. Append to `docs/context/decisions.md`:
   - Any non-obvious standards choices
   - Any tech debt violations found in source code during inspection
