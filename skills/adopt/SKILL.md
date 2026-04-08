---
name: adopt
description: >
  Adopt the opinionated TypeScript architecture in an existing project.
  Runs a review first, then proposes incremental changes the user can accept or discard.
  Remembers discarded proposals so they aren't re-suggested.
  Triggers on phrases like "adopt the architecture", "migrate my project",
  "align my project with the rules", "adopt tseng", or "make my project conform".
  Also invocable via the /tseng:adopt slash command.
---

# TSEng Adopt

Incrementally adopts the opinionated TypeScript architecture in an existing project. Unlike bootstrap (greenfield only), adopt works with existing code and lets the user control which changes to apply.

## Phase 1 — Review

Run the full review process to understand the current state:

1. Read `architecture/index.md` from the plugin directory.
2. Read every file linked from the index.
3. Extract every concrete, verifiable rule into a checklist. Do not include `tseng/` files (index.md, project-structure.md, adoption.md) in the checklist — those are outputs of the adopt process, not rules to audit.
4. Write the checklist to `tseng/review-checklist.md` in the target project.
5. Launch a subagent to audit every checklist item (same as review skill).

Use the same subagent prompt template as review:

```
You are auditing a TypeScript project at {project_path} against a checklist of architecture rules.

Go through EVERY item below. For each one:
- Check the project files to determine if the rule is satisfied
- Mark it ✅ (pass) or ❌ (fail) or ⚠️ (partially met / not applicable)
- Cite the specific file and line that proves your assessment
- If it fails, briefly say what's wrong

Do NOT check anything beyond this list. Do NOT add suggestions, improvements, or opinions. Only verify what's listed.

CHECKLIST:
{checklist_contents}
```

## Phase 2 — Load Adoption State

Check if `tseng/adoption.md` exists in the target project. If it does, read it. This file tracks previously discarded proposals — any violation listed there under `## Discarded` must NOT be re-proposed.

## Phase 3 — Propose Changes

From the audit results, collect all ❌ and ⚠️ items that are NOT in the discarded list. Group them into concrete change proposals:

Present proposals to the user as a numbered list. Each proposal should include:
- The rule being violated
- What needs to change (specific files/directories)
- Rough scope of the change (one-liner)

Ask the user which proposals to **accept** and which to **discard**. The user can respond with numbers, ranges, "all", or "none".

## Phase 4 — Apply Accepted Changes

For each accepted proposal, make the actual code changes. Follow the architecture docs as the source of truth.

After applying changes:
- Write or update `tseng/project-structure.md` with project metadata.
- Write or update `tseng/adoption.md` (see format below).
- Write or update `tseng/index.md` using the template from the architecture docs. Include sections for all files that now exist in `tseng/`.

## Phase 5 — Update Adoption State

Write `tseng/adoption.md` with the current state:

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

Merge with any existing content — don't lose previously recorded items.

## Phase 6 — Update Project CLAUDE.md

Ensure the project's root `CLAUDE.md` includes a reference to `tseng/index.md` so future Claude sessions pick up adoption context. If `CLAUDE.md` doesn't exist, create it. If it exists, append only if the reference is missing.

Add this block:

```markdown
## TSEng

This project follows the [TypeScript Engineering](tseng/index.md) architecture.
```

## Guidelines

- Existing projects only — if the directory is empty, suggest using the `bootstrap` skill instead.
- Never re-propose discarded items. The user said no; respect it.
- Apply changes incrementally. Don't rewrite the entire project in one shot.
- The architecture docs are the source of truth — don't deviate from them.
- The server runtime is pluggable (Hono or Express). Accept either as valid.
- If the project doesn't use tRPC/Zod at all, propose adding them as the first step rather than trying to restructure everything at once.
- Adoption is iterative — the user can run `/tseng:adopt` multiple times to chip away at remaining violations.
