# Context Files

> Files in this directory are written and updated by Claude during project setup and ongoing work.
> They serve as persistent project memory — both for Claude to read at the start of a session,
> and for the team to browse when asking "why did we do it this way?".

## Files

| File           | Purpose                                                  | Updated by                           |
| -------------- | -------------------------------------------------------- | ------------------------------------ |
| `project.md`   | Core project facts (stack, team, infra)                  | Onboarding prompt, manually          |
| `decisions.md` | Append-only log of decisions (ADR-level and below)       | Claude after each significant change |
| `sessions/`    | Optional per-session summaries for long working sessions | Claude at end of session             |

## How to use

**At the start of a new session**, tell Claude:

> "Read docs/context/project.md and decisions.md to get up to speed."

**When running any prompt** from `docs/prompts/`, Claude reads `project.md` automatically.

**When a small decision is made** that doesn't warrant a full ADR, Claude appends it to `decisions.md`.

**After a long working session**, ask Claude to write a session summary to `sessions/YYYY-MM-DD-topic.md`.
