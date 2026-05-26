# Glossary

Terms used across this project's documentation and tooling.
Entries are sorted alphabetically. Every README should link the first occurrence
of each term using `[term](docs/glossary/glossary.md#term-anchor)`.

---

## A

### ADR

Architecture Decision Record. A document that captures a significant architectural
or process decision that has been made. Records the context, the decision itself,
and its consequences. Stored in `docs/adr/`. See `docs/adr/README.md`.

### AID

AI Interaction Document. A document that records a significant interaction with an
AI assistant during development. Captures the goal, what was done, the outcome,
and lessons learned. Stored in `docs/aid/`. See `docs/aid/README.md`.

### AIR

Architecture Issue Record. A document that captures a conflict, ambiguity, or
unresolved issue with an existing ADR. Stored in `docs/air/`. See `docs/air/README.md`.

### Archive

A subfolder (`archive/`) within ADR, AID, and RFC directories that holds superseded,
rejected, or obsolete documents. Archived documents are kept for historical reference
and are not deleted.

## C

### Commitlint

A tool that validates commit message format against the rules defined in
`commitlint.config.mjs`. Runs as a `commit-msg` git hook via Lefthook.

### Conventional Commits

A specification for commit message format: `<type>(<scope>): <description>`.
See `docs/guides/git-workflow.md` for the types and scopes used in this project.

## D

### Decisions log

The file `docs/context/decisions.md`. An append-only journal of decisions made
during the project — both ADR-level decisions and smaller choices that don't warrant
a full ADR. Newest entries are at the top. Never rewrite or delete existing entries.

## G

### Git hook

A script that runs automatically at a specific point in the git workflow
(e.g. before a commit, before a push). Managed by Lefthook in this project.

## I

### INDEX.md

A file in each document directory (ADR, AIR, AID, RFC) that lists all documents
in that directory. Kept up to date manually or via script.

## L

### Lefthook

A Git hooks manager configured in `lefthook.yml`. Runs Prettier and markdownlint
on pre-commit, commitlint on commit-msg, and lint + format checks on pre-push.

## M

### Markdownlint

A linter for Markdown files. Configuration is in `.markdownlint.jsonc`.
Run via `pnpm run lint:check` or `pnpm run lint:fix`.

## P

### Prettier

A code formatter for all files in the project. Configuration is in `.prettierrc`.
Run via `pnpm run format:check` or `pnpm run format:fix`.

### Project context

The folder `docs/context/`. Contains persistent project memory: core facts
(`project.md`), decision log (`decisions.md`), and session summaries (`sessions/`).
Read by AI assistants at the start of each session.

## R

### Release-it

A tool for automating versioning and changelog generation. Configuration is in
`.release-it.json`. Run via `npm run release:patch|minor|major`.

### RFC

Request for Comments. A document that captures an idea or proposal **before** a
decision is made. Used for thinking through options, parking ideas, or flagging
things that need a decision later. Stored in `docs/rfc/`. See `docs/rfc/README.md`.

## S

### Scope

The part of a commit message in parentheses that identifies what area of the project
was changed: `feat(auth): add login`. Project-specific scopes are defined in
`commitlint.config.mjs` and listed in `docs/context/project.md`.

### Session summary

A Markdown file written at the end of a long working session that summarises what
was done, what decisions were made, and what comes next. Stored in
`docs/context/sessions/` and named `YYYY-MM-DD-topic.md`.
