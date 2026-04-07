# TypeScript Engineering Plugin

This is a Claude Code plugin that provides an opinionated architecture for TypeScript projects, inspired by Domain-Driven Design (DDD). It enforces consistent layered architecture, project structure, and technology choices.

## Plugin Structure

- `agents/architecture/` - Architecture documentation (the rules)
- `agents/skills/` - Skills that execute against those rules
- `.claude/skills/` - Symlinks making skills available in Claude Code
- `.claude/commands/` - Slash commands (e.g., `/project:tseng-bootstrap`, `/project:tseng-review`)

## Architecture (Source of Truth)

The architecture rules and conventions live in `agents/architecture/`. The entry point is `agents/architecture/index.md` — skills read the index first and progressively load specific files as needed.

- **`index.md`** — Entry point. Describes the overall architecture and points to deeper dives.
- **`architecture.md`** — Three-layer DDD architecture: validation (tRPC) → application (services) → domain (pure TS). Dependency rules, error handling.
- **`stack.md`** — Technology choices: tRPC, Zod, strict TypeScript, pnpm. Rationale for each.
- **`project-structure.md`** — Monorepo layout, package responsibilities, workspace config, TypeScript config, project metadata format.

## Skills

### `tseng-bootstrap`
Bootstrap a new greenfield project following the architecture. Creates the full monorepo scaffold with sample code in each layer.

### `tseng-review`
Audit an existing project against the architecture. Produces a structured report of conformance, violations, and suggestions.
