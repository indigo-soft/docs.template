# Documentation Style Guide

How to write documentation in this project.
Consistency makes docs easier to scan, translate, and maintain.

## Language

The default documentation language for this project is defined in
`docs/context/project.md`. When a file's language differs from the default,
note it at the top of the file.

AI-facing files (`AGENTS.md`, `docs/prompts/`) are written in English.

## Tone

- Write for the reader who is new to this area, not for the author
- Use plain language — prefer short sentences and common words
- Be direct: "Run `pnpm install`" not "You may want to consider running `pnpm install`"
- Use active voice: "The hook validates the commit" not "The commit is validated by the hook"

## Structure

Every document should answer: what is this, why does it exist, how do I use it.

Use headings to divide content into scannable sections. Prefer a flat structure —
two levels of headings (`##` and `###`) is enough for most documents.

Do not use a heading for the first paragraph. Introduce the document in plain prose
before the first `##` heading.

## Formatting

**Headings:** Title Case, no trailing punctuation.
`## Getting Started` ✓ — `## Getting started:` ✗

**Code:** use fenced code blocks; a language tag is **recommended** for syntax
highlighting, but not required (markdownlint rule MD040 is disabled).

````markdown
```bash
pnpm run lint:check
```
````

**Inline code:** use backticks for file names, commands, paths, and values.
`docs/context/project.md`, `pnpm run init`, `main`.

**Bold:** use for terms being defined or for the most important word in a warning.
Do not use bold for general emphasis.

**Links:** use descriptive link text. "See `docs/guides/git-workflow.md`" not "click here".

**Lists:** use a bullet list for unordered items, a numbered list only when order matters.
Keep list items parallel in structure.

## File naming

Lowercase kebab-case: `git-workflow.md`, `coding-standards.md`.
No spaces, no uppercase, no underscores.

## Line length

Aim for 80–120 characters per line in Markdown source.
Prose lines do not need to match exactly — wrap at a natural sentence or clause boundary.
Code blocks are exempt.

## Front matter

This project does not use YAML front matter. Metadata (status, date, author)
goes into a blockquote at the top of the document where needed — see ADR and RFC templates.

## Keeping docs current

A document that is wrong is worse than no document.
When you change behaviour, update the relevant docs in the same commit or PR.
If you find a doc that is out of date, fix it or open an issue.
