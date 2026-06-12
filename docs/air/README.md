# Architecture Issue Records (AIR)

AIR documents capture **conflicts between ADRs**: when a new decision contradicts an existing one,
or when two existing ADRs conflict when applied together.

Unlike ADRs, AIRs are always **temporary**. The goal of an AIR is to document the conflict,
analyse resolution paths, and reach a decision. Once the decision is made and reflected in the
affected ADRs, the AIR is considered resolved and moved to `archive/` — every AIR must
eventually be resolved; there is no "permanently open" state.

> **Looking for AI interaction records?** Those are [AID documents](../aid/README.md) —
> a separate document type for capturing significant AI interactions and their project impact.

---

## Current AIRs

### Open

_No open AIRs._

### Resolved (archive)

| #                                                               | Conflict                                                              | Affected ADRs      | Resolved   |
| --------------------------------------------------------------- | --------------------------------------------------------------------- | ------------------ | ---------- |
| [AIR-0001](archive/AIR-0001-pnpm-wsl2-global-tools-conflict.md) | pnpm isolated linker on WSL2 conflicts with native development policy | ADR-0002, ADR-0003 | 2026-05-18 |

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
Open → Resolved → archive/
     ↘ Deferred
```

| Status       | Meaning                                                                  |
| ------------ | ------------------------------------------------------------------------ |
| **Open**     | Conflict identified; resolution not yet decided — needs attention        |
| **Resolved** | Decision made, reflected in affected ADRs, file moved to `archive/`      |
| **Deferred** | Resolution deliberately postponed, with an explicit condition to revisit |

---

## How to create an AIR

### 1. Copy the template

```bash
cp docs/air/template/AIR-TEMPLATE.md docs/air/AIR-XXXX-short-conflict-description.md

# Fix the INDEX link — the template lives one level deeper than the real AIR:
sed -i 's|](\.\./INDEX\.md)|](INDEX.md)|' docs/air/AIR-XXXX-short-conflict-description.md
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
   - Conflict resolved by: [AIR-XXXX](../air/archive/AIR-XXXX-....md) — one-line summary
   ```

3. Change the AIR status to `Resolved`.
4. Move the file to `archive/`: `mv docs/air/AIR-XXXX-...md docs/air/archive/`
   (remember to adjust relative links inside the file — ADR links become `../../adr/...`).
5. Update the **Resolved** table above and in [INDEX.md](INDEX.md).

---

## File naming

```text
AIR-XXXX-short-conflict-description.md
```

- `XXXX` — zero-padded 4-digit number (`0001`, `0042`) — same convention as ADR, AID, and RFC
- `short-conflict-description` — kebab-case, English

Open AIRs live in `docs/air/`; resolved AIRs are moved to `docs/air/archive/`,
so the main folder always shows only what still needs attention.

**Examples:**

- ✅ `AIR-0002-redis-cluster-vs-single-instance.md`
- ✅ `archive/AIR-0001-docker-requirement-vs-no-docker-policy.md` (resolved)
- ❌ `air-002.md` (wrong format — lowercase, no description)
