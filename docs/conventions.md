# Coding Conventions

## TypeScript Configuration

Required `tsconfig.json` settings:

```json
{
  "compilerOptions": {
    "strict": true,
    "noUncheckedIndexedAccess": true,
    "exactOptionalPropertyTypes": true,
    "noImplicitReturns": true,
    "noFallthroughCasesInSwitch": true,
    "forceConsistentCasingInFileNames": true,
    "moduleResolution": "bundler",
    "module": "ESNext",
    "target": "ES2022"
  }
}
```

## File Naming

- `kebab-case.ts` for all files
- `<name>.test.ts` for tests (colocated)
- `<name>.types.ts` for complex type definitions
- `<name>.port.ts` for interface/port definitions
- `<name>.adapter.ts` for adapter implementations
- **No `index.ts` barrel files**

## Import Rules

- Import directly from source module, never from barrel files
- Use relative imports within a layer
- Use path aliases for cross-layer imports (e.g., `@core/`, `@infrastructure/`)

## Function Design

- Prefer pure functions over classes
- Use classes only for stateful infrastructure resources
- Keep functions small and focused on a single task
- Accept dependencies as parameters, not module-level imports

## Type Design

- No `any` — use `unknown` and narrow with type guards
- No type assertions (`as`) unless justified with a comment
- Prefer discriminated unions over optional fields
- Use branded types for domain identifiers (e.g., `UserId`, `OrderId`)

## Error Handling

- Use `Result<T, E>` for expected/recoverable errors
- Use discriminated union error types: `type CreateUserError = { kind: "duplicate_email"; email: string } | { kind: "invalid_input"; field: string }`
- Reserve `throw` for truly unexpected programmer errors
- Never catch and swallow errors silently

## Testing

- Colocate tests: `user.ts` → `user.test.ts`
- Test pure core logic with unit tests (no mocks needed)
- Test application layer with injected test doubles
- Test infrastructure with integration tests
