# TypeScript Engineering Skills

Coding agents produce little to no architecture in greenfield TypeScript projects. You get a flat pile of files, no separation of concerns, and no structure you'd want to maintain long-term.

These Claude Code skills fill that gap. They provide an opinionated architecture — monorepo layout, tRPC for the API layer, and a DDD-inspired separation of domain, application, and validation layers — documented as shared architecture docs that multiple skills can execute against.

## Usage

Bootstrap a new project:

```
/bootstrap
```

Review an existing project against the architecture rules:

```
/review
```

Adopt the architecture in an existing project:

```
/adopt
```

Upgrade a previously bootstrapped or adopted project when architecture evolves:

```
/upgrade
```

## How It Works

The architecture rules live in `architecture/` as standalone documentation. Skills read the index first to understand the full picture, then drill into specific files as needed. Rules are defined once and enforced consistently whether you're scaffolding from scratch, auditing an existing codebase, or incrementally adopting the architecture.

All four skills share the same architecture docs via `${CLAUDE_SKILL_DIR}/../../architecture/` — each skill resolves this relative to its own directory back to the repo root.

### Immutable Review Records

Every review, adopt, and upgrade run produces an **immutable review record** in the target project's `tseng/reviews/` directory. Each record is a numbered file (`001.md`, `002.md`, ...) that embeds the version and a full checklist. Records are locked once finalized and never modified — new runs always append. This gives you a complete audit trail of architectural compliance over time.
