---
name: upgrade
description: >
  Upgrade a previously bootstrapped or adopted project when the architecture evolves.
  Diffs the current architecture rules against the project's existing review checklist,
  identifies new or changed rules, and proposes incremental changes.
  Triggers on phrases like "upgrade my project", "sync with latest architecture",
  "update to new rules", "upgrade tseng", or "architecture changed, update my project".
  Also invocable via the /tseng:upgrade slash command.
---

# TSEng Upgrade

Upgrades an existing project that previously ran bootstrap or adopt to reflect evolved architecture rules. Detects new and changed rules by diffing the current architecture docs against the project's last review checklist, then runs the adopt-style proposal workflow for those items only.

## Prerequisites

The target project must have `tseng/review-checklist.md` from a prior review or adopt run. If it doesn't exist, tell the user to run `/tseng:adopt` first — there's nothing to upgrade from.

## Phase 1 — Regenerate Checklist

Generate a fresh checklist from the current architecture docs:

1. Read `architecture/index.md` from the plugin directory.
2. Read every file linked from the index.
3. Extract every concrete, verifiable rule into a checklist (same rules as review/adopt — no `tseng/` files, no inferred rules).

Do NOT write this checklist to disk yet.

## Phase 2 — Diff Against Existing Checklist

Read the project's existing `tseng/review-checklist.md`.

Compare the freshly generated checklist against the existing one:
- **New rules** — items in the fresh checklist that have no corresponding item in the existing checklist.
- **Changed rules** — items where the wording or criteria meaningfully changed (not just cosmetic reformatting).
- **Removed rules** — items in the existing checklist that no longer appear in the architecture docs. Flag these for the user but take no action.

If there are no new or changed rules, tell the user the project is already up to date and stop.

## Phase 3 — Load Adoption State

Read `tseng/adoption.md` if it exists. Previously discarded proposals for **unchanged rules** must not be re-proposed. However, if a rule has **changed** since it was discarded, it IS eligible for re-proposal — the user's original rejection may no longer apply.

## Phase 4 — Audit New & Changed Rules

Write the full updated checklist to `tseng/review-checklist.md` (replacing the old one).

Launch a subagent to audit **only the new and changed items** against the project:

```
You are auditing a TypeScript project at {project_path} against a checklist of architecture rules.

Go through EVERY item below. For each one:
- Check the project files to determine if the rule is satisfied
- Mark it ✅ (pass) or ❌ (fail) or ⚠️ (partially met / not applicable)
- Cite the specific file and line that proves your assessment
- If it fails, briefly say what's wrong

Do NOT check anything beyond this list. Do NOT add suggestions, improvements, or opinions. Only verify what's listed.

CHECKLIST:
{new_and_changed_items}
```

## Phase 5 — Propose Changes

From the audit results, collect all ❌ and ⚠️ items that are NOT in the discarded list (respecting the changed-rule exception from Phase 3). Group them into concrete change proposals:

Present proposals to the user as a numbered list. Each proposal should include:
- Whether this is a **new rule** or a **changed rule**
- The rule being violated
- What needs to change (specific files/directories)
- Rough scope of the change (one-liner)

Ask the user which proposals to **accept** and which to **discard**. The user can respond with numbers, ranges, "all", or "none".

## Phase 6 — Apply Accepted Changes

For each accepted proposal, make the actual code changes. Follow the architecture docs as the source of truth.

## Phase 7 — Update State

Update `tseng/adoption.md` — merge new applied/discarded items with existing content. Don't lose previously recorded items. Use the same format:

```markdown
# Adoption State

## Applied
- [rule description] — applied on [date]
- ...

## Discarded
- [rule description] — discarded on [date]
- ...

## Remaining
- [rule description]
- ...
```

If any rules were **removed** from the architecture, move their entries from Applied/Remaining to a note or remove them — they no longer apply.

Update `tseng/review-checklist.md` with the full audit results (merging new results with unchanged items from the previous audit).

## Guidelines

- Only for projects that have previously run adopt or bootstrap + review. If `tseng/review-checklist.md` doesn't exist, redirect to `/tseng:adopt`.
- Changed rules override prior discards — if a rule evolved, the user should reconsider it.
- Removed rules are informational — flag them but don't revert applied changes.
- Apply changes incrementally, same as adopt.
- The architecture docs are the source of truth.
- The server runtime is pluggable (Hono or Express). Accept either as valid.
- Upgrade is iterative — the user can run `/tseng:upgrade` multiple times.
