# Prompt: Generate Deployment Guide

## Purpose

Generate `docs/guides/deployment.md` describing how the project is set up, deployed,
and operated across all environments.

## Prerequisites

Before asking any questions, silently gather context in this order:

1. **Read `docs/context/project.md`** — deployment target, CI/CD platform, environments.
2. **Read `.env.example`** — understand all configuration variables, their defaults and purpose.
3. **Read `package.json` and/or `composer.json`** — extract scripts (install, build, test, release).
4. **Check for infrastructure files** — look for `docker-compose.yml`, `Dockerfile`,
   `infra/`, `.github/workflows/`, `Makefile`; read any that exist.
5. **Read `scripts/release/`** if it exists — understand the release process.

Only ask questions for information that cannot be inferred from the above.

## Questions to ask

Ask only what remains unknown after the inspection above:

### Environments
1. **What environments exist and what differs between them?**
   (e.g. local uses DEBUG=true, production uses DEBUG=false; staging has a separate DB)

### Setup process
2. **What are the exact steps to set up the project from a fresh clone?**
   Ask separately for dev and production if they differ.
3. **Are there dependencies that must be installed or running before the app starts?**
   (e.g. local database, message queue, external service)

### CI/CD pipeline
4. **What triggers a deployment?**
   (e.g. merge to `main` → staging, push tag → production)
5. **What does the pipeline do step by step?**
6. **Are there manual approval gates?**

### Infrastructure
7. **Where is the application hosted?**
8. **How are secrets managed in production?**
   (e.g. `.env` file on server, GitHub Actions secrets, Vault)

### Rollback & verification
9. **How is a bad deployment rolled back?**
10. **Are there post-deploy checks or smoke tests?**

## Output

Generate `docs/guides/deployment.md` with sections:

```
# Deployment Guide

## Environments
## Local Development Setup
## Production Setup
## Updating to a New Version
## Configuration & Secrets
## CI/CD Pipeline
## Rollback Procedure
## Post-Setup Verification
```

Rules:
- Every setup process must be written as numbered steps with exact commands.
- List all `.env` variables in a table: name, type, default, description.
- If CI/CD does not exist yet, include a "not yet configured" note and a placeholder
  for what it will cover (lint → test → release).
- Rollback procedure must include exact commands.
- Write in English.
- Respect `.editorconfig` formatting rules.

## After completion

1. Mark `deployment.md` as done in `docs/checklists/new-project.md`.
2. Append to `docs/context/decisions.md` any non-obvious deployment decisions
   (e.g. why a certain setup approach was chosen, what differs between environments).
