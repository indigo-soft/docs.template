# Architecture Issue Records (AIR)

AIR documents capture **conflicts between ADRs**: when a new decision contradicts an existing one,
or when two existing ADRs conflict when applied together.

Unlike ADRs, AIRs are always **temporary**. The goal of an AIR is to document the conflict,
analyse resolution paths, and reach a decision. Once the decision is made and reflected in the
affected ADRs, the AIR is considered resolved.

> **Looking for AI interaction records?** Those are [AID documents](../aid/README.md) —
> a separate document type for capturing significant AI interactions and their project impact.

There is no separate archive for AIRs. Resolved AIRs stay in this directory with a `done-`
prefix in the filename — open ones always appear first in a sorted listing.

---

## Current AIRs

### Open

_No open AIRs._

### Resolved

| #   | Conflict | Affected ADRs | Resolved |
| --- | -------- | ------------- | -------- |
| —   | —        | —             | —        |

---

## When to create an AIR

Create an AIR when:

- A new ADR **directly contradicts** an existing one
  (e.g. requires Docker when another ADR forbids it)
- Two existing ADRs **conflict in practice** when applied together
- An external requirement contradicts the current architecture and the trade-off must be documented

**Do not create an AIR** when:

- One decision simply depends on another (use `Depends on:` in the ADR)
- One decision extends or complements another (use `Related to:`)
- The conflict can be resolved in a PR comment without a dedicated document

---

## AIR Lifecycle

```text
Open → Resolved
     ↘ Deferred
```

| Status       | Meaning                                                                  |
| ------------ | ------------------------------------------------------------------------ |
| **Open**     | Conflict identified; resolution not yet decided — needs attention        |
| **Resolved** | Decision made, reflected in affected ADRs, file renamed to `done-`       |
| **Deferred** | Resolution deliberately postponed, with an explicit condition to revisit |

---

## How to create an AIR

### 1. Copy the template

```bash
cp docs/air/template/AIR-TEMPLATE.md docs/air/air-00N-short-conflict-description.md
```

### 2. Fill in the sections

- **Status:** `Open`
- **Affected ADRs:** table of conflicting ADRs
- **Conflict description:** what contradicts what, and why it matters
- **Severity:** Critical / Moderate / Low
- **Resolution paths:** at least 2 options with trade-offs
- **Decision taken:** leave empty until resolved

### 3. Open a PR and discuss

An AIR is a prompt for the team to discuss the conflict explicitly, not resolve it silently.

### 4. After the decision is made

1. Fill in the **Decision taken** section.
2. Update each **affected ADR** — add to its Related section:

   ```markdown
   - Conflict resolved by: [AIR-00N](../air/done-air-00N-....md) — one-line summary
   ```

3. Change the AIR status to `Resolved`.
4. Rename the file: `air-00N-...md` → `done-air-00N-...md`
5. Update the **Resolved** table above and in [INDEX.md](INDEX.md).

---

## File naming

```text
air-00N-short-conflict-description.md       ← open
done-air-00N-short-conflict-description.md  ← resolved
```

Resolved AIRs get the `done-` prefix — alphabetical sorting keeps open ones above resolved ones
in any file listing.

**Examples:**

- ✅ `air-002-redis-cluster-vs-single-instance.md`
- ✅ `done-air-001-docker-requirement-vs-no-docker-policy.md`
- ❌ `AIR-002.md` (wrong format)
