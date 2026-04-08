# TypeScript Engineering Plugin

Claude Code plugin providing an opinionated TypeScript client-server architecture inspired by DDD. Enforces layered architecture, project structure, and technology choices.

## Plugin Structure

- `.claude-plugin/plugin.json` - Plugin manifest
- `skills/bootstrap/` - Scaffolds new projects (`/tseng:bootstrap`)
- `skills/review/` - Audits existing projects (`/tseng:review`)
- `skills/adopt/` - Adopts architecture in existing projects (`/tseng:adopt`)
- `skills/upgrade/` - Upgrades adopted/bootstrapped projects when architecture evolves (`/tseng:upgrade`)
- `commands/` - Slash command definitions
- `architecture/` - Architecture documentation (the rules, source of truth)

## Architecture (Source of Truth)

The architecture rules live in `architecture/`. The entry point is `architecture/index.md` — skills read the index first and progressively load specific files as needed.

## Skills

### `bootstrap`
Bootstrap a new greenfield project following the architecture. Creates the full monorepo scaffold with sample code in each layer.

### `review`
Audit an existing project against the architecture. Produces a structured report of conformance, violations, and suggestions.

### `adopt`
Incrementally adopt the architecture in an existing project. Runs review first, proposes changes, tracks accepted/discarded decisions in `tseng/adoption.md`, and updates the project's CLAUDE.md.

### `upgrade`
Upgrade a previously bootstrapped or adopted project when the architecture rules evolve. Diffs current architecture against the existing review checklist, identifies new/changed rules, and runs the adopt-style proposal workflow for those items only.
