# Technology Stack

The opinionated stack for TypeScript client-server projects.

## Core Technologies

| Layer | Technology | Purpose |
|-------|-----------|---------|
| API | [tRPC](https://trpc.io/) | End-to-end typesafe APIs without code generation |
| Validation | [Zod](https://zod.dev/) | Schema declaration and input validation |
| Language | TypeScript (strict mode) | Type safety across the entire stack |
| Package management | pnpm (default) | Fast, disk-efficient package manager with native workspace support |

## Why These Choices

### tRPC over REST/GraphQL

- Full type inference from server to client — no codegen step.
- Router definitions double as API documentation.
- Pairs naturally with Zod for input validation.

### Zod for Validation

- Runtime validation that produces TypeScript types via `z.infer`.
- Composable schemas — build complex validations from simple pieces.
- First-class tRPC integration as input validators.

### Strict TypeScript

The base `tsconfig.json` enables strict mode and additional checks:

- `strict: true` (enables `strictNullChecks`, `noImplicitAny`, etc.)
- `noUncheckedIndexedAccess: true`
- `noEmit: true` (type-checking only; bundler handles emit)
- Path aliases via `paths` for clean imports between layers

## Client

The client connects to the server via a tRPC client. The specific UI framework is flexible (React, Vue, Solid, etc.), but the tRPC client setup is always present to guarantee end-to-end type safety.

When React is used, prefer `@trpc/react-query` for data fetching.

## Shared Types

The `AppRouter` type is exported from the server and consumed by the client through a shared package. This is the single source of truth for the API contract — no manual type duplication.
