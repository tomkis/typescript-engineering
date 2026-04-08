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

Audits an existing TypeScript project against the architecture rules.

## How It Works

1. Read `architecture/index.md` — it describes the overall architecture and points to deeper dives on each topic.
2. Read the specific architecture files relevant to what you're auditing. Load them as needed rather than all at once.
3. Discover the project layout: check `tseng/project-structure.md` if it exists, otherwise scan the codebase.
4. Compare what you find against every rule and convention in the architecture. Derive the checklist from the docs — don't use a hardcoded list.
5. Produce a structured report:
   - **Summary** — one-line overall assessment
   - **Passes** — rules the project satisfies
   - **Violations** — rules that are broken, citing specific files and lines
   - **Suggestions** — actionable steps to fix each violation
5. If a `tseng/` folder exists with metadata files, check whether they are outdated and offer to update them. Do not flag the absence of `tseng/` — it is a generated folder created only when the project adopts tseng.

## Guidelines

- This is a **read-only audit** by default. Don't modify files unless the user asks you to fix violations.
- Be specific — cite file paths and line numbers.
- If the project doesn't use the expected stack at all, say so and suggest whether bootstrapping from scratch would be more appropriate.
- The architecture docs are the source of truth — derive all checks from them.
