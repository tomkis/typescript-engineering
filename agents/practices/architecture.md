# Layered Architecture

The architecture follows a strict three-layer model inspired by Domain-Driven Design (DDD). Each layer has a clear responsibility and dependencies only flow inward — toward the domain.

```
  External input
       │
       ▼
┌──────────────────────┐
│  Validation Layer    │  tRPC routers + Zod schemas
│  (src/routers/)      │  Parse, validate, sanitize — no business logic
└──────────┬───────────┘
           │
           ▼
┌──────────────────────┐
│  Application Layer   │  Business services
│  (src/services/)     │  Orchestrate use cases, coordinate domain objects
└──────────┬───────────┘
           │
           ▼
┌──────────────────────┐
│  Domain Layer        │  Pure TypeScript — zero external deps
│  (src/domain/)       │  Entities, value objects, aggregates, domain events
└──────────────────────┘
```

## Layer Rules

### 1. Validation Layer (`src/routers/`)

- tRPC routers define the API surface and handle input validation via Zod schemas.
- Responsible for parsing, validating, and sanitizing external input.
- **No business logic lives here** — routers delegate immediately to business services.
- tRPC context provides dependency injection of services.
- Each router file maps to a bounded context or resource (e.g., `userRouter`, `orderRouter`).

### 2. Application Layer (`src/services/`)

- Business services orchestrate use cases and coordinate domain objects.
- Services are pure functions or classes that receive dependencies via injection.
- Translates between the outside world and the domain — mapping validated input into domain operations and domain results back into API responses.
- Transaction boundaries and cross-cutting concerns (logging, auth checks) live here.
- Services never import from the validation layer.

### 3. Domain Layer (`src/domain/`)

- The innermost layer — pure TypeScript with **zero external dependencies**.
- Contains domain entities, value objects, aggregates, and domain events.
- All business rules and invariants are enforced here.
- Domain logic is pure and deterministic — no side effects, no I/O, no framework imports.
- Use `Result` types to represent domain errors as values, not thrown exceptions.
- The domain layer never imports from any other layer.

## Dependency Rule

Dependencies flow strictly inward:

```
routers → services → domain
```

- **routers** may import from services and domain.
- **services** may import from domain only.
- **domain** imports from nothing outside itself.

Violating this rule (e.g., a domain entity importing from a service, or a service importing a router) is always an error.

## Error Handling

- Domain errors are represented as `Result<T, E>` values — never thrown exceptions.
- Services unwrap or propagate `Result` types.
- Routers translate domain errors into appropriate tRPC error codes.
