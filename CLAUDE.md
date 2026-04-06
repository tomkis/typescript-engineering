# TypeScript Engineering Plugin

This is a Claude Code plugin that provides an opinionated stack and architecture for TypeScript projects, inspired by Domain-Driven Design (DDD). It enforces consistent layered architecture, project structure, and best practices.

## Plugin Structure

- `.claude/commands/` - Slash commands (e.g., `/project:tseng-bootstrap`)
- `.claude/skills/` - Skills available in Claude Code (e.g., `tseng-bootstrap` for architecture validation)

## Layered Architecture

The architecture follows a strict three-layer model inspired by DDD. Each layer has a clear responsibility and dependencies only flow inward (toward the domain).

### 1. Validation Layer (tRPC)

- tRPC routers define the API surface and handle input validation via Zod schemas
- This layer is responsible for parsing, validating, and sanitizing external input
- No business logic lives here — routers delegate immediately to business services
- tRPC context provides dependency injection of services

### 2. Application Layer (Business Services)

- Business services orchestrate use cases and coordinate domain objects
- Services are pure functions or classes that receive dependencies via injection
- This layer translates between the outside world and the domain — mapping validated input into domain operations and domain results back into API responses
- Transaction boundaries and cross-cutting concerns (logging, auth checks) live here

### 3. Domain Layer (Pure Domain)

- The innermost layer — pure TypeScript with zero external dependencies
- Contains domain entities, value objects, aggregates, and domain events
- All business rules and invariants are enforced here
- Domain logic is pure and deterministic — no side effects, no I/O, no framework imports
- Use Result types to represent domain errors as values, not thrown exceptions
