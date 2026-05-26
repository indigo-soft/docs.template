# RFC — Request for Comments

RFCs capture ideas and proposals **before** a decision is made.
Use an RFC when you want to think something through, park an idea for later,
or flag something that needs a decision but you're not ready to commit yet.

An ADR records a decision that **has been made**.
An RFC is the space **before** that decision — or a place for ideas that may never become decisions.

## When to write an RFC

- You have an idea worth capturing, but you're not sure yet if it's the right move
- A decision involves trade-offs that benefit from written-out alternatives
- You want to park something for later without losing it
- A change is significant enough that others should weigh in before it's locked in

When a small decision is already clear, skip the RFC and write an ADR directly.

## Lifecycle

```text
Draft → Under Review → Accepted / Rejected → Archived
```

| Status       | Meaning                                                               |
| ------------ | --------------------------------------------------------------------- |
| Draft        | Work in progress, not ready for review                                |
| Under Review | Ready for feedback — add comments or open a PR discussion             |
| Accepted     | Decision made — an ADR or AID should be created, then archive the RFC |
| Rejected     | Decided against — move to archive with a note explaining why          |
| Parked       | Good idea, wrong time — revisit later                                 |

## Naming

```text
RFC-XXXX-kebab-case-title.md
```

Four-digit zero-padded number, same convention as ADR and AID.
Example: `RFC-0001-add-rfc-process.md`

## After a decision

- **Accepted** → create the corresponding ADR or AID, link it in the RFC, move RFC to `archive/`
- **Rejected** → add a short outcome note to the RFC, move to `archive/`
- **Parked** → leave in the main folder with status updated to `Parked`

## Files

| File                       | Purpose                            |
| -------------------------- | ---------------------------------- |
| `INDEX.md`                 | List of all open and archived RFCs |
| `template/RFC-TEMPLATE.md` | Template for new RFCs              |
| `archive/`                 | Closed RFCs (accepted or rejected) |
