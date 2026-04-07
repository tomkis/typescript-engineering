---
name: tseng-review
description: >
  Review an existing TypeScript project against the opinionated architecture rules.
  Use when the user asks to review, audit, check, or validate their project's architecture.
  Triggers on phrases like "review my project", "check the architecture",
  "audit my code structure", "validate my project", or "does my project follow the rules".
  Also invocable via the /project:tseng-review slash command.
---

# TSEng Review

Reviews an existing TypeScript project against the opinionated architecture and stack conventions.

## Prerequisites

Before reviewing, read the following practice documents — they define the rules you are auditing against:

1. **`agents/practices/architecture.md`** — the three-layer architecture and dependency rules
2. **`agents/practices/stack.md`** — technology choices (tRPC, Zod, strict TypeScript)
3. **`agents/practices/project-structure.md`** — monorepo layout, package responsibilities, workspace config

## What This Skill Does

Analyze the user's existing project and produce a structured review that identifies conformance and violations against the practices.

### 1. Discover Project Layout

- Read `tseng/project-structure.md` if it exists (for machine-readable metadata).
- Otherwise, scan the root for `package.json`, `tsconfig.base.json`, workspace config, and `packages/` directory to infer the layout.

### 2. Check Project Structure

Compare the actual layout against `agents/practices/project-structure.md`:

- [ ] Monorepo with workspace configuration
- [ ] `tsconfig.base.json` with strict mode at the root
- [ ] Server, client, and shared packages present
- [ ] Each package has its own `tsconfig.json` extending the base

### 3. Check Architecture Layers

For the server package, verify compliance with `agents/practices/architecture.md`:

- [ ] `src/routers/` exists and contains tRPC routers with Zod input validation
- [ ] `src/services/` exists and contains business services
- [ ] `src/domain/` exists and contains pure domain logic
- [ ] **Dependency rule**: routers → services → domain (no reverse imports)
- [ ] Domain layer has zero external dependencies (no framework imports)
- [ ] Errors use Result types in the domain, not thrown exceptions

### 4. Check Stack Compliance

Verify technology choices against `agents/practices/stack.md`:

- [ ] `@trpc/server` and `zod` in server dependencies
- [ ] `@trpc/client` in client dependencies
- [ ] Shared package exports `AppRouter` type
- [ ] TypeScript strict mode enabled

### 5. Produce Report

Output a structured review with:

- **Summary** — one-line overall assessment (conformant / partially conformant / non-conformant)
- **Passes** — rules that the project satisfies
- **Violations** — rules that are broken, with the specific file or import that violates them
- **Suggestions** — actionable steps to fix each violation

### 6. Update Project Metadata

If `tseng/project-structure.md` is missing or outdated, offer to create or update it with the discovered layout, following the metadata format in `agents/practices/project-structure.md`.

## Important Guidelines

- This is a **read-only audit** by default. Do not modify project files unless the user explicitly asks you to fix violations.
- Be specific — cite file paths and line numbers for violations.
- If the project doesn't use the expected stack at all (e.g., no tRPC, no monorepo), say so clearly and suggest whether bootstrapping from scratch would be more appropriate.
- The dependency rule check is the most important architectural check — flag any inward-dependency violations prominently.
