# TypeScript Engineering Skills

Distributable Claude Code skills providing an opinionated TypeScript client-server architecture inspired by DDD. Enforces layered architecture, project structure, and technology choices.

## Repository Structure

- `VERSION` - Current version; skills embed this in every review record
- `skills/bootstrap/` - Scaffolds new projects
- `skills/review/` - Audits existing projects
- `skills/adopt/` - Adopts architecture in existing projects
- `skills/upgrade/` - Upgrades adopted/bootstrapped projects when architecture evolves
- `architecture/` - Architecture documentation (the rules, source of truth)

## Shared Static Files

The `architecture/` directory contains the architecture rules that all skills read. Each skill directory contains symlinks (`architecture -> ../../architecture`, `VERSION -> ../../VERSION`) so that when skills are installed via `npx skills add`, the shared files travel with each skill.

Skills use a bash injection block (`` ```! ``) at the top of each SKILL.md to resolve these paths via `${CLAUDE_SKILL_DIR}`, making the architecture docs and version available at invocation time regardless of where the skill is installed.

## Architecture (Source of Truth)

The architecture rules live in `architecture/`. The entry point is `architecture/index.md` — skills read the index first and progressively load specific files as needed.

## Skills

### `tseng:bootstrap`
Bootstrap a new greenfield project following the architecture. Creates the full monorepo scaffold with sample code in each layer.

### `tseng:review`
Audit an existing project against the architecture. Creates an immutable review record in `tseng/reviews/` and produces a structured report. The record stays open (read-only audit).

### `tseng:adopt`
Incrementally adopt the architecture in an existing project. Creates a review record, proposes changes, tracks accepted/discarded decisions in `tseng/adoption.md`, and **locks** the review once the user finalizes. Locked reviews are never modified.

### `tseng:upgrade`
Upgrade a previously bootstrapped or adopted project when the architecture rules evolve. Reads the last **locked** review from `tseng/reviews/`, diffs against current architecture, creates a new review record for the delta, and runs the adopt-style proposal workflow.

### `tseng:spec`
Spec out a feature or change with full architecture knowledge and project adoption context. Conducts a discovery interview to understand domain concerns, bounded contexts, and layer responsibilities, then produces a high-level architectural specification. Maintains ubiquitous language in `tseng/vocabulary.md`. Can store the approved spec as a GitHub issue.

### `tseng:build-it`
Implement an architectural specification as working code. Takes the output of the spec skill (from a GitHub issue, conversation context, or pasted text) and produces concrete TypeScript modules, services, domain objects, events, and routers. Discovers project conventions, creates an implementation plan for approval, then implements module by module in dependency order with verification.

## Review Records

Reviews are append-only immutable records stored in `tseng/reviews/` in target projects. Each record is a numbered markdown file (`001.md`, `002.md`, ...) containing a versioned checklist. Records are `open` while being worked on and `locked` once finalized. Locked records are never modified — new runs always create a new record. The `tseng/reviews/index.md` file tracks all reviews.
