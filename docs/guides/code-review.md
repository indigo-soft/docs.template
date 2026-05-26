# Code Review Guide

Guidelines for reviewing pull requests in this project.
The goal of a review is to ship better code, not to be right.

## Reviewer mindset

- Assume good intent — the author made reasonable choices with the context they had
- Ask questions before making statements: "What was the thinking here?" beats "This is wrong"
- Distinguish between blocking issues and suggestions: prefix non-blocking comments
  with "nit:" or "optional:"
- Approve when the code is good enough to ship, not when it's perfect

## What to check

**Correctness**
Does the code do what it's supposed to do?
Are edge cases handled?
Are there obvious bugs or off-by-one errors?

**Clarity**
Can you understand what the code does without asking the author?
Are names meaningful?
Is complex logic explained with a comment?

**Consistency**
Does it follow the conventions in `docs/guides/coding-standards.md`?
Does it match the patterns already used in the codebase?

**Tests**
Are there tests for the new behaviour?
Do existing tests still pass?
Are the tests testing the right things?

**Documentation**
If a public API or behaviour changed, is the documentation updated?
If a significant decision was made, is there an ADR or an entry in `decisions.md`?

**Security**
Are inputs validated and sanitised?
Is sensitive data handled correctly?
Are there any new dependencies — and are they necessary?

## What not to block on

- Style and formatting — these are handled by Prettier and markdownlint automatically
- Personal preference on naming if the name is clear and consistent with the codebase
- Minor refactoring that isn't related to the PR's goal

## Response time

Aim to review within one business day of the PR being assigned.
If you can't review in time, say so and suggest an alternative reviewer.

## See also

- `docs/checklists/code-review.md` — quick checklist for before you hit "Approve"
- `docs/guides/git-workflow.md` — PR process and branch conventions
