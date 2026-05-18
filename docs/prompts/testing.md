# Prompt: Generate Testing Guide

## Purpose

Generate `docs/guides/testing.md` and set up the initial test infrastructure:
directory structure, base test case, and functional stub tests for each test type.

## Prerequisites

Before asking any questions, silently gather context:

1. **Read `docs/context/project.md`** — stack, framework, runtime.
2. **Read `composer.json` / `package.json` / `pyproject.toml`** — check `require-dev` / `devDependencies`
   for testing frameworks already installed.
3. **Check for existing test config** — `pest.php`, `phpunit.xml`, `vitest.config.*`,
   `jest.config.*`, `pytest.ini`, `pyproject.toml [tool.pytest]`; read any that exist.
4. **Check for existing `tests/` directory** — list its structure if present.
5. **Check for `samples/` or `fixtures/` directory** — note if test data already exists.

Only ask questions for what cannot be inferred from the above.

## Questions to ask

### Testing stack

1. **What testing framework is used?**
   (Only ask if not already in `composer.json` / `package.json`)
2. **Are there different frameworks for different test types?**
   (e.g. Pest for unit, Playwright for E2E)

### Test types

1. **What types of tests should exist?**
   Always ask about: unit, integration.
   Ask about the following only if the project has the relevant layer:
    - E2E — if the project has a web UI or public HTTP API
    - Contract — if the project communicates with external APIs it does not own
    - Snapshot — if the project renders UI components
    - Performance — if latency or throughput is a documented requirement

2. **Is there a coverage requirement?** What threshold?
3. **What is intentionally NOT tested and why?**

### Test data

1. **Is there a `samples/` or `fixtures/` directory for integration tests?**
   If not — should one be created?

## Setup actions (always run, no questions needed)

### 1. Create directory structure

For each confirmed test type, create the corresponding subdirectory:

```text
tests/
    TestCase.php          ← base test case
    Unit/                 ← always
    Integration/          ← always (if the project has more than one layer)
    E2E/                  ← only if confirmed
```

### 2. Create base TestCase

Adapt to the project's testing framework (Pest / PHPUnit / Vitest / Jest / pytest).

### 3. Create stub tests — one per test type

Stubs must:

- **Pass without errors** out of the box (no false failures)
- **Be functional, not empty** — test something real (a smoke assertion, a sanity check)
- **Include a TODO comment** pointing to what a real test should cover
- **Not modify any files or state** — use `--dry-run`, in-memory data, or read-only fixtures

**PHP/Pest unit stub example:**

```php
describe('ServiceName', function (): void {
    it('placeholder — replace with real unit test', function (): void {
        expect(true)->toBeTrue();
        // TODO: test ServiceName::methodName() with real assertions
    });
});
```

**PHP/Pest integration stub example:**

```php
use Symfony\Component\Process\Process;

describe('Console bootstrap', function (): void {
    it('boots without errors', function (): void {
        $process = new Process(['php', 'bin/console', 'list']);
        $process->run();
        expect($process->isSuccessful())->toBeTrue();
    });
});
```

### 4. Update `composer.json` / `package.json`

- Add `autoload-dev` / `devDependencies` for the `Tests\` namespace if missing
- Add `test:unit`, `test:integration` scripts (and `test:e2e` if applicable)

## Output

Generate `docs/guides/testing.md` with sections:

```text
# Testing Guide

## Testing Strategy
## Testing Stack
## Test File Conventions
## Running Tests
## Writing Tests (conventions and examples per type)
## Coverage Requirements
## CI Integration
## Known Gaps & Tech Debt
```

Rules:

- Include exact runnable commands for each script.
- Provide one short example per test type showing what a good test looks like.
- If a private method cannot be tested directly — document it as tech debt to fix,
  never as an acceptable pattern.
- If CI is not yet configured — add a placeholder section with the planned workflow.
- Write in English.
- Respect `.editorconfig` formatting rules.

## After completion

1. Mark `testing.md` as done in `docs/checklists/new-project.md`.
2. Append to `docs/context/decisions.md`:
    - Which test types were chosen and why
    - Any tech debt surfaced during test setup (private methods, DI violations, etc.)
