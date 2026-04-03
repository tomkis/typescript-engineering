# Architecture Reference

## Layered Architecture

This plugin enforces a strict layered architecture for TypeScript projects:

```
┌─────────────────────────────────┐
│         infrastructure/         │  Route handlers, DB clients, API clients
│  (imperative shell - side       │  Adapters for external systems
│   effects live here)            │
├─────────────────────────────────┤
│         application/            │  Use cases / orchestration
│  (wires core + infrastructure)  │  Accepts dependencies as parameters
├─────────────────────────────────┤
│            core/                │  Pure business logic
│  (functional core - no side     │  Domain types, validation, rules
│   effects, no I/O)              │
├─────────────────────────────────┤
│           shared/               │  Result type, shared utilities
│  (zero dependencies on other    │  Common type definitions
│   layers)                       │
└─────────────────────────────────┘
```

### Dependency Rule

Dependencies flow **inward** only:

- `infrastructure/` → `application/` → `core/` → `shared/`
- Inner layers NEVER import from outer layers
- `core/` defines interfaces (ports) that `infrastructure/` implements (adapters)

## Key Patterns

### Result Type (Error as Values)

```typescript
type Result<T, E> = { ok: true; value: T } | { ok: false; error: E };
```

Use for any operation that can fail with an **expected** error. Reserve thrown exceptions for programmer errors only.

### Dependency Injection

```typescript
// application/create-user.ts
function createUser(
  input: CreateUserInput,
  deps: { userRepo: UserRepository; emailService: EmailService }
): Promise<Result<User, CreateUserError>> {
  // orchestrate using injected deps
}
```

Infrastructure dependencies are passed explicitly. No singletons, no service locators, no DI containers.

### Ports and Adapters

```typescript
// core/user.port.ts — the interface (port)
interface UserRepository {
  findById(id: UserId): Promise<Result<User, NotFoundError>>;
  save(user: User): Promise<Result<void, PersistenceError>>;
}

// infrastructure/postgres-user.adapter.ts — the implementation (adapter)
function createPostgresUserRepository(pool: Pool): UserRepository {
  return {
    async findById(id) { /* ... */ },
    async save(user) { /* ... */ },
  };
}
```
