# Prompt: Generate Coding Standards Guide

## Purpose

Generate `docs/guides/coding-standards.md` (or the language-specific equivalent,
e.g. `docs/en/guides/coding-standards.md`) for this project.

## Prerequisites

Read `docs/context/project.md` before asking anything.
Stack, language, and tooling already known from context should not be asked again.

## Questions to ask

### Language & runtime

1. **What is the primary language and version?**
   (e.g. TypeScript 5.x, PHP 8.3, Python 3.12, Go 1.22)
2. **Are there secondary languages in the repo?**
   (e.g. shell scripts, SQL migrations, YAML configs)

### Formatting & linting

3. **What formatter is used, and is it enforced automatically?**
   (e.g. Prettier via Lefthook pre-commit, Black on save)
4. **What linter is used?**
   (e.g. ESLint with which config, PHPStan level, Ruff, golangci-lint)
5. **Are there any custom lint rules or rule overrides worth documenting?**

### Code style decisions

6. **Naming conventions** — any project-specific rules beyond language defaults?
   (e.g. "event handlers prefixed with `handle`", "interfaces suffixed with `Interface`")
7. **File and folder naming** — what case is used?
   (e.g. kebab-case files, PascalCase React components)
8. **Import ordering** — is it enforced? Any grouping rules?
9. **Comment style** — JSDoc / PHPDoc / docstrings required for public APIs?

### Architecture-level coding rules

10. **Are there forbidden patterns?**
    (e.g. "no `any` in TypeScript", "no raw SQL outside repository layer", "no business logic in controllers")
11. **Error handling conventions?**
    (e.g. always use custom exception classes, never swallow errors silently)

## Output

Generate `docs/guides/coding-standards.md` with sections:

```
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
## Enforcement (how rules are checked — CI, hooks, IDE)
```

Rules:

- Include concrete examples for every rule (good ✅ / bad ❌ pattern pairs where useful).
- Link to config files where relevant (e.g. `See eslint.config.js for full rule set`).
- Write in English.
- Respect `.editorconfig` formatting rules.

## After completion

1. Mark `coding-standards.md` as done in `docs/checklists/new-project.md`.
2. Append to `docs/context/decisions.md` any non-obvious standards choices
   (e.g. why a specific rule was added or an exception was made).
