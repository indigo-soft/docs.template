# AGENTS Guide

## What this repository is
- This is a minimal documentation template repository, not an application codebase.
- Current tracked content is mostly project scaffolding (`.editorconfig`, `.gitignore`, `.idea/*`) plus an empty `docs/` directory.
- There are no discovered source modules, runtime services, or test suites yet.

## Repository map (current state)
- `docs/`: target location for documentation content (currently empty).
- `.editorconfig`: primary formatting contract for all future files.
- `.gitignore`: currently only contains a placeholder comment.
- `.idea/php.xml`: JetBrains PHP tooling preferences are present.

## Conventions agents should follow
- Respect `.editorconfig` globally:
  - UTF-8, LF endings, final newline, trailing whitespace trimmed.
  - Default indentation is 4 spaces.
  - Shell files (`*.sh`, `*.zsh`, `*.bash`) use 2 spaces.
  - JSON-like and config files listed in `.editorconfig` use 2 spaces.
- Keep line length at or under 120 where practical (`max_line_length = 120`).
- Prefer creating documentation under `docs/` unless the user asks for another location.

## Tooling and workflows
- No project-specific build/test/debug commands are discoverable from repository files.
- No dependency manifests are present (`package.json`, `pyproject.toml`, `composer.json`, etc. are absent).
- If you add runnable code, introduce its toolchain explicitly in the same change (manifest + run instructions).

## Architecture and integration notes
- No internal component boundaries or data flows are defined yet.
- No external integrations, APIs, or service contracts are declared in current files.
- Treat this repo as a blank template and avoid inventing architecture without explicit user direction.

## Agent operating guidance for this repo
- Start by confirming intended stack and output location before generating non-doc code.
- When adding new structure, keep changes minimal and explain why each new top-level file is needed.
- Use concrete file references in responses (for example, `.editorconfig`, `docs/`).
- Do not assume PHP runtime usage just because `.idea/php.xml` exists; it only reflects IDE configuration.
