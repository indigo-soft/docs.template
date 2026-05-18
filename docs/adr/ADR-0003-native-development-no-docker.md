# ADR-0003: Native Development without Docker

**Status:** Accepted
**Date:** 2026-05-11

---

## Context

A project needs a development environment and a production deployment approach for its
application and its dependencies (database, cache, etc.).

Common approaches:

- **Full Docker** — containerise everything for dev and production
- **Hybrid Docker** — Docker only for infrastructure (DB, Redis), native for app
- **Native** — install everything directly on the machine / server
- **Managed services (PaaS/SaaS)** — cloud-hosted databases, caches, queues

Key considerations that drive this decision:

- **Data sensitivity** — does the project handle confidential data?
- **Team experience** — familiarity with Docker and Linux administration
- **Cost** — managed services vs self-hosted VPS
- **Simplicity** — lower cognitive overhead = fewer mistakes

## Decision

Use a **fully native approach** — no Docker, no managed cloud services.

- **Local development:** dependencies (database, cache) installed natively on the developer's machine
- **Production:** dependencies run as systemd services on a VPS; the application runs under PM2

## Considered Options

### Native (no Docker) ✅ Chosen

**Pros:**

- Instant hot reload (no volume sync delay)
- Direct debugging with standard tools
- No Docker Desktop overhead (~2–4 GB RAM)
- Full transparency — you know exactly where everything is
- Lower cost: one VPS vs managed service fees
- No vendor lock-in

**Cons:**

- Each developer must install DB, cache, etc. locally
- Production server setup requires initial manual configuration
- Responsibility for backups and monitoring

### Full Docker

**Pros:** Production parity; easy to reproduce the environment.
**Cons:** Added complexity; volume performance issues on macOS/Windows; harder debugging;
Docker Desktop RAM overhead; steep learning curve for beginners.
**Verdict:** Good for large teams with DevOps expertise. Overkill for small teams and MVPs.

### Managed cloud services (Supabase, AWS RDS, Upstash, etc.)

**Pros:** Zero infrastructure maintenance.
**Cons:** Data leaves your servers (compliance and privacy risk); vendor lock-in;
cost grows with usage ($50–100+/month vs $5–15/month for a VPS).
**Verdict:** Avoid when the project handles sensitive data or when cost matters.

### Hybrid Docker (infrastructure only)

**Pros:** Reproducible DB versions.
**Cons:** Still requires Docker Desktop; adds complexity without full benefit.
**Verdict:** A middle ground that satisfies neither goal fully.

## Rationale

For projects that handle sensitive data or need full control, native deployment eliminates
third-party data access entirely. For small teams, the native approach is simpler to understand,
faster for daily development, and significantly cheaper than managed services.

The trade-offs (manual server setup, individual local installs) are one-time costs; the benefits
(speed, transparency, cost, control) are ongoing.

## Production stack

| Component           | Technology                                               |
| ------------------- | -------------------------------------------------------- |
| Application runtime | PM2 (process manager)                                    |
| Reverse proxy + SSL | Nginx + Let's Encrypt                                    |
| Database            | Installed via system package manager, managed by systemd |
| Cache / queue       | Installed via system package manager, managed by systemd |
| Firewall            | UFW                                                      |

## When to revisit this decision

- [ ] Team grows beyond 10+ developers
- [ ] Horizontal scaling across multiple servers becomes necessary
- [ ] Deployment frequency exceeds 10 times per day
- [ ] A developer environment reproducibility issue causes significant friction

In those cases, consider: Docker Compose for local dev, or Kubernetes for production.

## Consequences

### Positive

- Fast local development (instant hot reload, direct debugging)
- Full data control — no third-party access
- Low cost ($5–15/month VPS vs $50–100+/month managed services)
- No vendor lock-in

### Negative

- Developers must install the project's dependencies locally
- Production server requires one-time manual setup
- Team is responsible for backups, monitoring, and OS updates

### Neutral

- Deployment is via `git pull` + `pm2 restart` (simple but manual)
- Database version differences between developers possible (mitigate with clear version documentation)

## Related ADRs

- [ADR-0004](ADR-0004-security-strategy.md) — security strategy building on self-hosted infrastructure
