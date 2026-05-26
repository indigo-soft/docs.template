# Prompt: Fill in SECURITY.md

## Purpose

Update `SECURITY.md` in the project root with project-specific security information.
The template version is generic — this prompt replaces placeholders with real values.

## Prerequisites

Read `docs/context/project.md` silently before asking anything.
Use all known facts without re-asking them.

## Questions to ask

Ask only what is not already known from project context:

1. **Supported versions** — which versions of the project receive security fixes?
   (e.g. "latest only", "last two major versions", "all versions ≥ 2.0")

2. **Reporting channel** — how should vulnerabilities be reported?
   - GitHub Security Advisories (recommended for public repos)
   - Private email address
   - Bug bounty platform (if applicable)

3. **Response time commitment** — what is the guaranteed response time?
   (e.g. 48 hours, 7 days, best effort)

4. **Disclosure policy** — how long before a vulnerability is publicly disclosed
   after a fix is released? (e.g. 90 days, 30 days, immediate)

5. **Security tooling** — are there any project-specific security measures to mention?
   (e.g. dependency scanning beyond Renovate, SAST tools, penetration testing schedule)

## Output

Update `SECURITY.md` with real values substituted for all placeholders.
Keep the structure from the template. Remove any sections that do not apply.

## Rules

- Do not invent contact details — only use what the user provides
- The reporting section must be unambiguous: one clear path to report
- Response time should be a commitment the team can actually keep
- Write in English
- Respect `.editorconfig` formatting rules

## After completion

Append to `docs/context/decisions.md`:

```markdown
## {YYYY-MM-DD} — SECURITY.md updated

**Supported versions:** {what was agreed}
**Reporting channel:** {GitHub Advisories / email / other}
**Response time:** {commitment}
```
