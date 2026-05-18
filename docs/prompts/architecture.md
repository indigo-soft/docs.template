# Prompt: Generate Architecture Documentation

## Purpose

Generate the three core architecture documents:

- `docs/architecture/overview.md` — high-level system description
- `docs/architecture/components.md` — component breakdown and responsibilities
- `docs/architecture/modules.md` — internal module structure and boundaries

## Prerequisites

Before asking any questions, silently gather context in this order:

1. **Read `docs/context/project.md`** — project name, stack, deployment target.
2. **Read existing documentation** — check for `README.md`, `AGENTS.md`, `CONTRIBUTING.md`
   in the project root; read any that exist.
3. **Inspect source code structure** — list top-level directories, then inspect the primary
   source directory (e.g. `src/`, `app/`, `packages/`):
   - List subdirectories and key files
   - Read entry point(s) (e.g. `bin/console`, `main.ts`, `index.php`, `app.py`)
   - Read 2–3 representative source files to understand patterns
     (e.g. one controller/command, one service, one model/entity)
4. **Check for config files** — `composer.json`, `package.json`, `pyproject.toml`, etc.
   to discover dependencies and scripts.

Only ask questions for information that cannot be inferred from the above.
The goal is zero questions for well-documented projects.

## Questions to ask

Ask only what remains unknown after the source code inspection above:

### System overview

1. **What problem does this system solve?** One or two sentences, from a user perspective.
2. **Who are the main users / consumers of this system?**
   (e.g. end users, other services, mobile clients, internal tools)
3. **What are the system's external boundaries?**
   What does it receive as input, and what does it produce or affect as output?

### Components

4. **What are the major components or services?**
   List them with a one-line description of each.
5. **How do components communicate?**
   (e.g. HTTP, gRPC, message queue, shared database, events)
6. **What external services or dependencies does the system rely on?**
   (e.g. PostgreSQL, Redis, S3, Stripe, SendGrid, Auth0)

### Modules (internal code structure)

7. **What are the main internal modules or packages?**
8. **Are there any hard module boundaries — things that must not depend on each other?**
9. **Is there a layered architecture?**
   (e.g. controller → service → repository, or domain → application → infrastructure)

## Output

### `docs/architecture/overview.md`

Sections: Purpose, Users & Consumers, System Boundaries, Key Constraints, Architecture Diagram.

### `docs/architecture/components.md`

A section per component with: responsibility, interfaces (what it exposes/consumes), external dependencies.

### `docs/architecture/modules.md`

A section per module with: purpose, public API (what other modules may use), forbidden dependencies.
Include a "Hard Module Boundaries" summary table at the end.

Rules for output:

- Use ASCII or Mermaid diagrams where they aid understanding.
- Be specific — prefer "PostgreSQL 16 via Prisma ORM" over "database".
- Capture implicit conventions found in source code (naming patterns, layering rules,
  dependency constraints) — make them explicit in the docs.
- Write in English.
- Respect `.editorconfig` formatting rules.

## After completion

1. Mark `architecture.md` as done in `docs/checklists/new-project.md`.
2. Append to `docs/context/decisions.md` any architectural constraints or choices captured
   that were not obvious from questions or existing docs (e.g. implicit conventions found
   in source code that are now made explicit).
