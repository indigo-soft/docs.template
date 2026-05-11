# Prompt: Generate Architecture Documentation

## Purpose

Generate the three core architecture documents:

- `docs/architecture/overview.md` — high-level system description
- `docs/architecture/components.md` — component breakdown and responsibilities
- `docs/architecture/modules.md` — internal module structure and boundaries

## Prerequisites

Read `docs/context/project.md` before asking anything.
Use known facts (project name, stack, deployment target) silently.

## Questions to ask

### System overview

1. **What problem does this system solve?** One or two sentences, from a user perspective.
2. **Who are the main users / consumers of this system?**
   (e.g. end users, other services, mobile clients, internal tools)
3. **What are the system's external boundaries?**
   What does it receive as input, and what does it produce or affect as output?

### Components

4. **What are the major components or services?**
   List them with a one-line description of each.
   (e.g. REST API, background worker, admin panel, message queue consumer)
5. **How do components communicate?**
   (e.g. HTTP, gRPC, message queue, shared database, events)
6. **What external services or dependencies does the system rely on?**
   (e.g. PostgreSQL, Redis, S3, Stripe, SendGrid, Auth0)

### Modules (internal code structure)

7. **What are the main internal modules or packages?**
   (e.g. `auth`, `billing`, `notifications`, `core`)
8. **Are there any hard module boundaries — things that must not depend on each other?**
9. **Is there a layered architecture?**
   (e.g. controller → service → repository, or domain → application → infrastructure)

## Output

### `docs/architecture/overview.md`

Sections: Purpose, Users & Consumers, System Boundaries, Key Constraints, Architecture Diagram placeholder.

### `docs/architecture/components.md`

A section per component with: responsibility, interfaces (what it exposes/consumes), external dependencies.

### `docs/architecture/modules.md`

A section per module with: purpose, public API (what other modules may use), forbidden dependencies.

Rules for output:

- Use diagrams as ASCII or Mermaid code blocks where helpful.
- Be specific — prefer "PostgreSQL 16 via Prisma ORM" over "database".
- Write in English.
- Respect `.editorconfig` formatting rules.

## After completion

1. Mark `architecture.md` as done in `docs/checklists/new-project.md`.
2. Append to `docs/context/decisions.md` any architectural constraints or choices captured
   that were not obvious from the questions (e.g. why a certain boundary exists).
