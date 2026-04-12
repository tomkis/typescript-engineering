# TypeScript Engineering Skills

Distributable Claude Code skills providing an opinionated TypeScript client-server architecture inspired by DDD. Enforces layered architecture, project structure, and technology choices.

## Repository Structure

- `VERSION` - Current version; skills embed this in every review record
- `scripts/version.sh` - Outputs the current version
- `skills/bootstrap/` - Scaffolds new projects
- `skills/review/` - Audits existing projects
- `skills/adopt/` - Adopts architecture in existing projects
- `skills/upgrade/` - Upgrades adopted/bootstrapped projects when architecture evolves
- `architecture/` - Architecture documentation (the rules, source of truth)

## Shared Static Files

The `architecture/` directory contains the architecture rules that all skills read. Skills reference these files via `${CLAUDE_SKILL_DIR}/../../architecture/` — this resolves relative to each skill's directory back to the repo root, allowing all four skills to share a single copy of the architecture docs.

The same pattern applies to `scripts/version.sh` — skills invoke it via `${CLAUDE_SKILL_DIR}/../../scripts/version.sh`.

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
