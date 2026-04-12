# TypeScript Engineering Plugin

Claude Code plugin providing an opinionated TypeScript client-server architecture inspired by DDD. Enforces layered architecture, project structure, and technology choices.

## Plugin Structure

- `.claude-plugin/plugin.json` - Plugin manifest (includes version)
- `scripts/version.sh` - Outputs the current plugin version; skills embed this in every review record
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
Audit an existing project against the architecture. Creates an immutable review record in `tseng/reviews/` and produces a structured report. The record stays open (read-only audit).

### `adopt`
Incrementally adopt the architecture in an existing project. Creates a review record, proposes changes, tracks accepted/discarded decisions in `tseng/adoption.md`, and **locks** the review once the user finalizes. Locked reviews are never modified.

### `upgrade`
Upgrade a previously bootstrapped or adopted project when the architecture rules evolve. Reads the last **locked** review from `tseng/reviews/`, diffs against current architecture, creates a new review record for the delta, and runs the adopt-style proposal workflow.

## Review Records

Reviews are append-only immutable records stored in `tseng/reviews/` in target projects. Each record is a numbered markdown file (`001.md`, `002.md`, ...) containing a versioned checklist. Records are `open` while being worked on and `locked` once finalized. Locked records are never modified — new runs always create a new record. The `tseng/reviews/index.md` file tracks all reviews.
