---
name: review
description: >
  Review an existing TypeScript project against the opinionated architecture rules.
  Use when the user asks to review, audit, check, or validate their project's architecture.
  Triggers on phrases like "review my project", "check the architecture",
  "audit my code structure", "validate my project", or "does my project follow the rules".
  Also invocable via the /tseng:review slash command.
---

# TSEng Review

Audits an existing TypeScript project against the architecture rules using a two-phase approach to prevent hallucination.

## Phase 1 — Generate Checklist

You (the main agent) generate a strict checklist from the architecture docs.

1. Read `architecture/index.md` from the plugin directory.
2. Read every file linked from the index.
3. Extract every concrete, verifiable rule from the docs. Each rule becomes a checklist item.
4. Write the checklist to `tseng/review-checklist.md` in the **target project**.

### Checklist format

Each item must be a single, unambiguous yes/no check. No vague or subjective items.

```markdown
# Review Checklist

Generated from architecture docs. Each item is a concrete rule to verify.

## Stack
- [ ] Uses tRPC for API layer
- [ ] Uses Zod for input validation
- [ ] TypeScript strict mode enabled (`strict: true` in tsconfig)
- [ ] ...

## Architecture
- [ ] ...

## Project Structure
- [ ] ...
```

Rules for generating the checklist:
- **ONLY** include rules explicitly stated in the architecture docs. Do not infer, extrapolate, or add "best practices" that aren't written down.
- Do not include `tseng/` files (index.md, project-structure.md, adoption.md) as checklist items — those are generated outputs, not architecture rules.
- Each item must be verifiable by reading files (checking imports, config values, directory structure, etc.)
- Use the exact terminology from the docs
- Group items by source file (Stack, Architecture, Project Structure)

## Phase 2 — Audit via Subagent

Launch a subagent (using the Agent tool) to perform the actual audit. The subagent prompt must:
- Include the full contents of the generated checklist (copy-paste it into the prompt)
- Tell the subagent the project root path
- Instruct the subagent to go through each checklist item, check pass/fail, and cite specific files/lines as evidence
- **Do NOT include architecture docs, plugin context, or any other instructions in the subagent prompt**

Use this exact subagent prompt template:

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

## Phase 3 — Report

Take the subagent's output and present the final report to the user:
- **Summary** — one-line overall assessment
- **Passes** — rules the project satisfies
- **Violations** — rules that are broken, with file/line citations from the subagent
- **Suggestions** — actionable fix for each violation

## Guidelines

- This is a **read-only audit** by default. Don't modify files unless the user asks you to fix violations.
- The server runtime is pluggable (Hono or Express). Accept either as valid.
- If a `tseng/project-structure.md` exists, check whether it is outdated and offer to update it.
- Do not flag the absence of `tseng/` — it is a generated folder.
- If the project doesn't use the expected stack at all, say so and suggest whether bootstrapping from scratch would be more appropriate.
