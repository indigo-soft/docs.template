# Prompt: Generate Testing Guide

## Purpose

Generate `docs/guides/testing.md` describing the project's testing strategy,
tools, conventions, and how to run tests.

## Prerequisites

Read `docs/context/project.md` before asking anything.
Stack and tooling already known from context should not be asked again.

## Questions to ask

### Testing stack

1. **What testing frameworks are used?**
   (e.g. Vitest, Jest, PHPUnit, pytest, Go testing, Cypress, Playwright)
2. **Are there different frameworks for different test types?**
   (e.g. Vitest for unit, Playwright for E2E)
3. **Are there any test helpers, factories, or fixtures worth documenting?**

### Test types and coverage

4. **What types of tests exist in the project?**
   (unit, integration, E2E, contract, snapshot, performance — list what applies)
5. **Is there a coverage requirement?** What is the threshold?
6. **What is NOT tested, and why?** (intentional gaps)

### Test file conventions

7. **Where do test files live?**
   (e.g. colocated `*.test.ts` next to source, or separate `tests/` directory)
8. **What is the naming convention for test files and test cases?**
   (e.g. `*.spec.ts`, `describe('UserService', ...)`)
9. **Are there rules about test isolation?**
   (e.g. "each test must clean up its own database state", "no shared mutable state")

### Running tests

10. **What are the exact commands to run tests?**
    (all, unit only, E2E only, single file, watch mode)
11. **Are there prerequisites before running tests?**
    (e.g. start Docker, run migrations, set env vars)
12. **How are tests run in CI?** Any differences from local?

## Output

Generate `docs/guides/testing.md` with sections:

```
# Testing Guide

## Testing Strategy
## Test Types
## Testing Stack
## Test File Conventions
## Running Tests
## Writing Tests (conventions and examples)
## Coverage Requirements
## CI Integration
## Known Gaps & Exclusions
```

Rules:

- Include exact runnable commands.
- Provide at least one short example per test type (what a good test looks like for this project).
- Write in English.
- Respect `.editorconfig` formatting rules.

## After completion

1. Mark `testing.md` as done in `docs/checklists/new-project.md`.
2. Append to `docs/context/decisions.md` any testing strategy decisions
   (e.g. why E2E was skipped, why a specific framework was chosen over alternatives).
