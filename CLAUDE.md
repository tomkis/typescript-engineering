# TypeScript Engineering Plugin

This is a Claude Code plugin that provides an opinionated stack and architecture for TypeScript projects, inspired by Domain-Driven Design (DDD). It enforces consistent layered architecture, project structure, and best practices.

## Plugin Structure

- `agents/practices/` - Shared architecture documentation (the rules)
- `agents/skills/` - Skills that execute against those rules
- `.claude/skills/` - Symlinks making skills available in Claude Code
- `.claude/commands/` - Slash commands (e.g., `/project:tseng-bootstrap`, `/project:tseng-review`)

## Practices (Source of Truth)

The architecture rules and conventions live in `agents/practices/`. All skills read from these documents — they are the single source of truth.

- **`architecture.md`** — Three-layer DDD architecture: validation (tRPC) → application (services) → domain (pure TS). Dependency rules, error handling.
- **`stack.md`** — Technology choices: tRPC, Zod, strict TypeScript, pnpm. Rationale for each.
- **`project-structure.md`** — Monorepo layout, package responsibilities, workspace config, TypeScript config, project metadata format.

## Skills

### `tseng-bootstrap`
Bootstrap a new greenfield project following the practices. Creates the full monorepo scaffold with sample code in each layer.

### `tseng-review`
Audit an existing project against the practices. Produces a structured report of conformance, violations, and suggestions.
