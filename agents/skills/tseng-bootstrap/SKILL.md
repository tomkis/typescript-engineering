---
name: tseng-bootstrap
description: >
  Bootstrap a new greenfield TypeScript client-server project with an opinionated
  monorepo architecture. Use when the user asks to bootstrap, scaffold, or initialize
  a new project. Triggers on phrases like "bootstrap my project", "scaffold a new project",
  "start a new typescript project", "set up my project", or "create a new app".
  Also invocable via the /project:tseng-bootstrap slash command.
---

# TSEng Bootstrap

Bootstraps a new greenfield TypeScript client-server project as an opinionated monorepo.

## Prerequisites

Before scaffolding, read the following practice documents to understand the architecture and conventions you must follow:

1. **`agents/practices/architecture.md`** — the three-layer architecture and dependency rules
2. **`agents/practices/stack.md`** — technology choices (tRPC, Zod, strict TypeScript)
3. **`agents/practices/project-structure.md`** — monorepo layout, package responsibilities, workspace config

These documents are the source of truth. Every file you create must conform to them.

## What This Skill Does

Ask the user for a project name (or infer from the directory name), then scaffold the full monorepo structure from scratch.

### 1. Root Setup

- Initialize `package.json` with `workspaces` field (or `pnpm-workspace.yaml` if using pnpm)
- Add a `tsconfig.base.json` with strict TypeScript settings and project references
- Detect or ask for the package manager (default to pnpm)

### 2. Server Package (`packages/server/`)

- `package.json` with `@trpc/server`, `zod` as dependencies
- `src/` directory with the three-layer structure:
  - `src/routers/` — tRPC router with a sample health-check procedure using Zod input validation
  - `src/services/` — sample business service
  - `src/domain/` — sample domain entity with a Result type
- `tsconfig.json` extending the base

### 3. Client Package (`packages/client/`)

- `package.json` with `@trpc/client` (and optionally `react`, `@trpc/react-query`)
- `src/` directory with a sample tRPC client setup
- `tsconfig.json` extending the base

### 4. Shared Package (`packages/shared/`)

- `package.json` for shared types
- `src/index.ts` exporting the `AppRouter` type from the server

### 5. Persist Project Layout

Write `tseng/project-structure.md` following the metadata format described in `agents/practices/project-structure.md`. Include both the machine-readable HTML comments and human-readable text.

### 6. Report

After scaffolding, tell the user what was created and suggest next steps (install deps, run dev server).

## Important Guidelines

- This skill is for **greenfield projects only**. The project directory should be empty or near-empty.
- Always ask or infer the project name before scaffolding.
- Default to pnpm as the package manager unless the user specifies otherwise.
- The server must follow the three-layer architecture defined in `agents/practices/architecture.md`.
- Include sample code in each layer so the user has a working starting point, not just empty directories.
- The shared package must export the `AppRouter` type for end-to-end type safety between client and server.
