# TypeScript Engineering Plugin

Claude Code plugin providing an opinionated TypeScript client-server architecture inspired by DDD. Enforces layered architecture, project structure, and technology choices.

## Plugin Structure

- `.claude-plugin/plugin.json` - Plugin manifest
- `skills/bootstrap/` - Scaffolds new projects (`/tseng:bootstrap`)
- `skills/review/` - Audits existing projects (`/tseng:review`)
- `commands/` - Slash command definitions
- `architecture/` - Architecture documentation (the rules, source of truth)

## Architecture (Source of Truth)

The architecture rules live in `architecture/`. The entry point is `architecture/index.md` — skills read the index first and progressively load specific files as needed.

## Skills

### `bootstrap`
Bootstrap a new greenfield project following the architecture. Creates the full monorepo scaffold with sample code in each layer.

### `review`
Audit an existing project against the architecture. Produces a structured report of conformance, violations, and suggestions.
