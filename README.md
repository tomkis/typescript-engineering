# TypeScript Engineering Plugin

A Claude Code plugin that provides an opinionated stack and architecture for TypeScript projects, inspired by Domain-Driven Design (DDD).

## Quick Start

Install this plugin in your project, then run the bootstrap command:

```
/project:tseng-bootstrap
```

This will either **scaffold a new monorepo** from scratch or **validate an existing project** against the architecture requirements.

## What It Does

### Bootstrap (empty project)

When run against an empty or unstructured project, `tseng-bootstrap` scaffolds:

- A **monorepo** with workspaces (pnpm, npm, or yarn)
- A **server** package with tRPC, Zod, and a DDD-inspired layered architecture
- A **client** package with tRPC client integration
- A **shared** package for type-safe contracts (`AppRouter` type export)
- A `tseng/project-structure.md` file recording the project layout

### Validate (existing project)

When run against a project that already has structure, it checks:

| Check | What it validates |
|-------|-------------------|
| Monorepo structure | Workspaces config with 2+ packages |
| Server package | A server/API/backend package exists |
| Client package | A client/web/frontend package exists |
| tRPC installed | `@trpc/server` on server, `@trpc/client` on client |
| Layered architecture | Routers → Services → Domain separation |
| Zod validation | Zod schemas used in tRPC router inputs |
| Shared types | Optional shared package for contracts |

Each check reports **PASS**, **FAIL**, or **WARN** with fix recommendations.

## Architecture

The enforced architecture follows a strict three-layer model:

```
┌─────────────────────────────────────┐
│  Validation Layer (tRPC + Zod)      │  ← Input validation, API surface
├─────────────────────────────────────┤
│  Application Layer (Services)       │  ← Business logic orchestration
├─────────────────────────────────────┤
│  Domain Layer (Pure TypeScript)     │  ← Entities, value objects, rules
└─────────────────────────────────────┘
        Dependencies flow inward →
```

- **Validation Layer** — tRPC routers with Zod schemas. No business logic.
- **Application Layer** — Services that orchestrate domain operations. Dependency injection.
- **Domain Layer** — Pure TypeScript, zero dependencies. Business rules enforced here.

## Project Layout

After running `tseng-bootstrap`, the `tseng/project-structure.md` file records where key parts of the project live (server path, client path, package manager, workspaces). This file is read by other skills and future sessions to avoid re-scanning.

## Usage

| Method | How |
|--------|-----|
| Slash command | `/project:tseng-bootstrap` |
| Natural language | "bootstrap my project" or "validate my architecture" |
