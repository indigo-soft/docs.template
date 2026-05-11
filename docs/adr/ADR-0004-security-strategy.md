# ADR-0004: Security Strategy

**Status:** Accepted
**Date:** 2026-05-11

---

## Context

Any web application handles data of varying sensitivity. A security strategy must be
established early, before the first deployment, covering:

- Secrets management
- Transport security
- Authentication and authorisation
- Data protection
- Input validation
- Dependency security

The specific sensitivity level, compliance requirements, and threat model will vary
per project — but the **structure** of the strategy is reusable.

## Decision

Apply a **Defence in Depth** security strategy with the following layers:

1. Infrastructure security — self-hosted, firewall, SSH keys only
2. Transport security — HTTPS/TLS for all connections
3. Authentication & authorisation — tokens, session management, RBAC
4. Secrets management — environment variables, never in code
5. Input validation & sanitisation — all user input validated at the boundary
6. Security headers — CORS, CSP, HSTS, rate limiting
7. Audit logging — all critical operations logged
8. Dependency security — regular audits and automated updates

## Layers in Detail

### 1. Infrastructure Security

- All services run on your own servers (see [ADR-0003](ADR-0003-native-development-no-docker.md))
- Firewall (UFW): allow only 22 (SSH), 80, 443; block direct access to database and cache ports
- SSH: key-based authentication only; root login disabled
- Fail2Ban: blocks brute-force attempts

### 2. Transport Security

- All traffic over HTTPS (Let's Encrypt SSL)
- HTTP → HTTPS redirect via Nginx
- TLS 1.2+ only; strong cipher suite
- HSTS header enabled
- Internal service connections (app ↔ DB) via localhost — no network exposure

### 3. Authentication & Authorisation

- Short-lived tokens (JWT or session-based)
- Refresh token rotation
- Role-Based Access Control (RBAC) for multi-role applications
- All protected endpoints require authentication

### 4. Secrets Management

**Rules:**

- Secrets live in `.env` files — never committed to git
- `.env` files are in `.gitignore`
- Separate `.env` files per environment (development, production)
- Minimum 32-character random values for secrets

```bash
# Generate a strong secret
openssl rand -hex 32
```

**Validate env vars at startup** — fail fast if required variables are missing or too short.

**File permissions:**

```bash
chmod 600 .env.production
```

### 5. Input Validation

- Validate and sanitise all user input at the API boundary
- Use a dedicated validation library (e.g. class-validator, Zod, Joi)
- Strip or reject unexpected fields
- Use parameterised queries / ORM — never interpolate user input into SQL

### 6. Security Headers

Apply via the application framework or reverse proxy:

- `Strict-Transport-Security` — HSTS
- `X-Frame-Options: DENY` — clickjacking protection
- `X-Content-Type-Options: nosniff`
- `Content-Security-Policy` — restrict resource origins
- CORS — allow only known origins
- Rate limiting — protect against brute-force and DoS

### 7. Audit Logging

Log all state-changing operations (POST, PUT, PATCH, DELETE) with:

- Timestamp
- User ID (or `anonymous`)
- Action and resource
- IP address
- Response status

Store audit logs separately from application logs. Retain for at least 90 days.

### 8. Dependency Security

```bash
# Check for known vulnerabilities
pnpm audit

# Fix automatically where possible
pnpm audit --fix
```

- Enable Dependabot / Renovate security alerts (see [ADR-0007](ADR-0007-automated-dependency-management.md))
- Block deployments if `pnpm audit` reports high/critical vulnerabilities in CI

## Sensitive Data at Rest

Encrypt sensitive fields (API keys, OAuth tokens, personal data) before storing them in
the database. Use AES-256-GCM. The encryption key must come from an environment variable.

**What to encrypt:** third-party API keys, OAuth tokens, sensitive user-provided data.
**What not to encrypt:** IDs, timestamps, public data, hashed passwords (bcrypt handles those).

## Security Checklist

### Development

- [ ] Secrets in `.env`, not in code
- [ ] `.env` in `.gitignore`
- [ ] Pre-commit hook checks for accidentally staged secrets
- [ ] Input validation on all endpoints
- [ ] Parameterised queries / ORM only

### Production deployment

- [ ] HTTPS with valid certificate
- [ ] Firewall configured (only 22, 80, 443 open)
- [ ] SSH key-only access; root login disabled
- [ ] Strong passwords/secrets (32+ characters)
- [ ] `.env.production` permissions: `600`
- [ ] Fail2Ban active
- [ ] Rate limiting active
- [ ] Security headers verified

### Ongoing

- [ ] `pnpm audit` runs in CI
- [ ] Automated dependency updates enabled
- [ ] Audit logs retained and reviewed periodically
- [ ] SSL certificate auto-renewal configured

## Consequences

### Positive

- Full data control — no third-party access to sensitive data
- Defence in Depth — multiple independent layers reduce blast radius of any single failure
- Audit trail supports incident investigation and compliance

### Negative

- More initial configuration required compared to managed services
- Encryption at rest adds minor latency
- Team is responsible for keeping the security posture up to date

### Neutral

- Security is an ongoing process, not a one-time setup
- Specific framework implementations will differ per project

## Related ADRs

- [ADR-0003](ADR-0003-native-development-no-docker.md) — self-hosted infrastructure
- [ADR-0007](ADR-0007-automated-dependency-management.md) — automated dependency updates for security patches
