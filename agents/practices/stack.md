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

## Server Runtime

The server uses Express with the tRPC Express adapter (`@trpc/server/adapters/express`). The app router is always mounted at `/trpc`:

```ts
app.use("/trpc", createExpressMiddleware({ router: appRouter }));
```

**Required dependencies:** `express`, `@trpc/server`
**Required dev dependencies:** `@types/express`, `@types/node`

## Client

The client connects to the server via a tRPC client. The specific UI framework is flexible (React, Vue, Solid, etc.), but the tRPC client setup is always present to guarantee end-to-end type safety.

When React is used, prefer `@trpc/react-query` for data fetching.

## Dev Proxy

In development, the client dev server (e.g., Vite) proxies `/trpc` to the backend. This avoids CORS entirely — no CORS headers on the server.

```ts
// vite.config.ts
server: {
  proxy: {
    "/trpc": {
      target: "http://localhost:3000",
      changeOrigin: true,
    },
  },
}
```

The tRPC client URL should be `/trpc` (relative), not an absolute URL.

## Shared Types

The `AppRouter` type is exported from the server and consumed by the client through a shared package. This is the single source of truth for the API contract — no manual type duplication.
