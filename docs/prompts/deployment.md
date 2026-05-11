# Prompt: Generate Deployment Guide

## Purpose

Generate `docs/guides/deployment.md` describing how the project is built, deployed,
and operated across all environments.

## Prerequisites

Read `docs/context/project.md` before asking anything.
Deployment target, CI platform, and hosting already known from context should not be asked again.

## Questions to ask

### Environments

1. **What environments exist?**
   (e.g. local, development, staging, production — list all)
2. **What differs between environments?**
   (e.g. env vars, feature flags, database, external services in sandbox mode)

### CI/CD pipeline

3. **What CI/CD platform is used?**
   (e.g. GitHub Actions, GitLab CI, Bitbucket Pipelines, CircleCI)
4. **What triggers a deployment?**
   (e.g. merge to `main` → staging, tag `v*.*.*` → production)
5. **What does the pipeline do?** Step by step.
   (e.g. install → lint → test → build → push Docker image → deploy via SSH / Kubernetes / Vercel)
6. **Are there manual approval gates?**
   (e.g. "staging deploy is automatic, production requires manual approval")

### Infrastructure

7. **Where is the application hosted?**
   (e.g. AWS ECS, DigitalOcean App Platform, Vercel, VPS, on-premise)
8. **How is configuration/secrets managed?**
   (e.g. `.env` files, AWS Secrets Manager, Vault, GitHub Actions secrets)
9. **Are there infrastructure-as-code files?** Where?
   (e.g. Terraform in `infra/`, Docker Compose in project root)

### Local development

10. **How does a developer run the project locally?**
    List the exact steps from a fresh clone.
11. **Are there dependencies that must be running locally?**
    (e.g. Docker, local database, external service mock)

### Rollback & incidents

12. **How is a bad deployment rolled back?**
13. **Are there post-deploy checks or smoke tests?**

## Output

Generate `docs/guides/deployment.md` with sections:

```
# Deployment Guide

## Environments
## Local Development Setup
## CI/CD Pipeline
## Infrastructure
## Configuration & Secrets
## Deployment Process (step by step per environment)
## Rollback Procedure
## Post-Deploy Verification
```

Rules:

- Every process must be written as numbered steps, not prose.
- Include exact commands where applicable.
- Write in English.
- Respect `.editorconfig` formatting rules.

## After completion

1. Mark `deployment.md` as done in `docs/checklists/new-project.md`.
2. Append to `docs/context/decisions.md` any infrastructure or pipeline decisions
   that are not obvious (e.g. why a certain deployment strategy was chosen).
