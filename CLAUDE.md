# TypeScript Engineering Plugin

This is a Claude Code plugin that provides opinionated engineering skills for TypeScript projects. It enforces consistent architecture patterns, project structure, and best practices.

## Plugin Structure

- `.claude/commands/` - Slash commands available as `/project:<command>` in Claude Code
- `docs/` - Reference documentation for architecture decisions and patterns

## Architecture Principles

1. **Functional core, imperative shell** - Pure business logic, side effects at the edges
2. **Explicit over implicit** - No magic; prefer clear, traceable code paths
3. **Colocation** - Keep related code together (tests, types, styles next to implementation)
4. **Barrel-free** - No index.ts re-exports; import directly from source modules
5. **Strict TypeScript** - No `any`, no type assertions unless absolutely necessary
6. **Dependency injection** - Pass dependencies explicitly; no hidden singletons
7. **Error as values** - Use Result types over thrown exceptions for expected failures
