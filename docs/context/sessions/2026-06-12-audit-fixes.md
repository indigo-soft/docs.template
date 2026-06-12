# Session: 2026-06-12 — Full project audit and consistency fixes

## What was done

A full audit of every config, script, workflow, guide, checklist, template, prompt,
glossary entry, and CHANGELOG found ~23 inconsistencies. All approved fixes were applied
in this session.

### Critical fixes

- **`renovate.json` created** — was referenced by `dependabot.yml`, ADR-0007, and
  `updating-dependencies.md` but never existed. Config matches the documented behaviour:
  schedule every 3 days, non-major updates grouped and auto-merged after a 3-day release age,
  majors labeled `major-update` + `needs-review`, npm manager only (Actions stay on Dependabot).
- **Empty guide stubs filled with placeholders** — `coding-standards.md`, `testing.md`,
  `deployment.md`, `requirements.md`, `system-design.md` were 0-byte files actively linked
  from other docs. Each now carries a "generated during onboarding" note pointing to its prompt.
- **New prompts** — `docs/prompts/requirements.md` and `docs/prompts/system-design.md`
  (these two guides previously had no generating prompt). Added as optional items to
  `docs/checklists/new-project.md` Phase 3.

### pnpm v11 configuration (supersedes the `.pnpmrc` decision of 2026-05-19)

Research confirmed pnpm v11 reads non-auth settings **only** from `pnpm-workspace.yaml`
(or the global config.yaml) — `.npmrc`/`.pnpmrc` are ignored. The auto-added
`allowBuilds: lefthook: false` placeholder was evidence `.pnpmrc` never worked under v11.

- `pnpm-workspace.yaml` → `allowBuilds: lefthook: true`
- `.pnpmrc` removed; AGENTS.md and the onboarding prompt rewritten accordingly

### Commit / branch rules unified

- Subject and body max length: **120 chars everywhere** — commitlint already enforced 120
  while `.gitmessage`, the hook info script, and `git-workflow.md` claimed 72
- `body-max-line-length` raised 100 → 120 in commitlint for consistency
- Branch types now mirror commit types (added `style`, `ci`, `build`, `revert`) in the
  commitlint plugin, `git-workflow.md`, and `naming-conventions.md`
- Scopes: source of truth is `docs/context/project.md`; commitlint enforces format only;
  `scope-enum` documented as optional (AGENTS.md, onboarding prompt, ADR-0008 reworded)
- `.lefthook/commit-format-info.sh` was an orphan — now wired into the `commit-msg` hook
  and prints the full format reference when commitlint fails

### AIR process unified with ADR/AID/RFC

- 4-digit numbering: `AIR-XXXX` (was `air-00N`)
- Resolved AIRs move to `docs/air/archive/` (the `done-` filename prefix is retired)
- AIR-0001 migrated to `archive/AIR-0001-pnpm-wsl2-global-tools-conflict.md`
  (title and relative ADR links adjusted)
- Updated: `air/README.md`, `air/INDEX.md`, `AIR-TEMPLATE.md` (incl. the broken
  `../INDEX.md` link), `prompts/air.md`, `ADR-TEMPLATE.md`, glossary `Archive` entry

### CI workflows

- `check-links.yml`: push/PR run the offline (internal) check; the weekly schedule now runs
  a full check including external links — previously `--offline` applied to every trigger
- `renovate.yml`: fixed guide reference (`dependency-updates.md` → `updating-dependencies.md`)

### Docs drift fixes

- `release-flow.md`: config path corrected to root `.release-it.json`; pre-release checks
  table now lists all 7 checks (GITHUB_TOKEN was missing)
- `git-workflow.md`: stray "### Format (Body)" heading fixed
- `onboarding.md` guide: redundant manual `cp .env.example .env` step removed (init does it);
  WSL2 issue now links AIR-0001 as the canonical record
- `docs-style-guide.md`: language tags on code blocks downgraded to "recommended"
  (consistent with MD040 being disabled); heading style set to Title Case
- `adr/README.md`: next-number command fixed (`ls docs/adr/ADR-*.md`); copy example uses
  the `ADR-XXXX` placeholder
- `CONTRIBUTING.md` rewritten to current state (accurate command semantics, sync rule)
- `ROADMAP.md`: status updated to released (latest v1.0.3); completed v1.1 items checked;
  test project name corrected to music.local
- `CHANGELOG.md`: preamble moved to the top (backed by the new `header` option in
  `.release-it.json`); compare links fixed to `indigo-soft/docs.template`; duplicate
  0.6.1/0.6.4 entries removed
- `package.json`: stale `"main": "./src/index.ts"` removed (src/ no longer exists);
  AGENTS.md repo map updated accordingly

### AGENTS.md — new rules

- **Sync rule:** config ↔ scripts ↔ docs must be updated together in the same change,
  with examples of coupled pairs
- **Glossary maintenance extended:** adjacent terms (tools, services, standards introduced
  indirectly) must be added too — Renovate, Dependabot, and SemVer added to the glossary

### Scripts

- `check_lockfile`: log message renamed to "exists" (the sync check was intentionally
  removed earlier — `--frozen-lockfile` hangs on WSL2)
- `check_pushed`: now fails explicitly when the branch has no upstream
- `.gitignore`: added `.claude/`, `/reports/*` + `!/reports/.gitkeep`

## Manual follow-ups (user)

- [ ] `rm .pnpmrc`
- [ ] `rm docs/air/done-air-001-pnpm-wsl2-global-tools-conflict.md` (replaced by archive copy)
- [ ] Check `.env` never entered git history: `git log --all --oneline -- .env`
- [ ] Verify `RENOVATE_TOKEN` secret exists; Renovate will now follow `renovate.json`
- [ ] Run `pnpm lint && pnpm format` and commit

## State at end of session

All audit items resolved. Project consistent across configs, scripts, and docs.
Next release should be a `minor` (new prompts, renovate.json, AIR process change).
