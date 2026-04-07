# Project Structure

The project is organized as a monorepo with workspace support.

## Monorepo Layout

```
project-root/
├── package.json                  # Workspace root with "workspaces" field
├── tsconfig.base.json            # Shared strict TypeScript config
├── pnpm-workspace.yaml           # (if using pnpm)
├── packages/
│   ├── server/
│   │   ├── package.json          # @trpc/server, zod
│   │   ├── tsconfig.json         # Extends ../../tsconfig.base.json
│   │   └── src/
│   │       ├── routers/          # Validation layer — tRPC + Zod
│   │       ├── services/         # Application layer — business services
│   │       └── domain/           # Domain layer — pure TypeScript
│   ├── client/
│   │   ├── package.json          # @trpc/client (+ framework deps)
│   │   ├── tsconfig.json         # Extends ../../tsconfig.base.json
│   │   └── src/
│   │       └── ...               # UI + tRPC client setup
│   └── shared/
│       ├── package.json
│       ├── tsconfig.json         # Extends ../../tsconfig.base.json
│       └── src/
│           └── index.ts          # Re-exports AppRouter type
└── tseng/
    └── project-structure.md      # Auto-generated project metadata
```

## Package Responsibilities

### `packages/server/`

The server package contains the API and all backend logic, organized into the three architectural layers (see `architecture.md`).

**Required dependencies:** `@trpc/server`, `zod`

### `packages/client/`

The client package consumes the API via a typed tRPC client. The UI framework is flexible.

**Required dependencies:** `@trpc/client`

### `packages/shared/`

A lightweight package that re-exports the `AppRouter` type from the server. This enables end-to-end type safety without coupling the client directly to server internals.

## Workspace Configuration

- **pnpm** (default): Uses `pnpm-workspace.yaml` with `packages: ["packages/*"]`
- **npm/yarn**: Uses `"workspaces": ["packages/*"]` in root `package.json`
- **bun**: Uses `"workspaces": ["packages/*"]` in root `package.json`

## TypeScript Configuration

The root `tsconfig.base.json` provides shared strict settings. Each package extends it:

```json
{
  "extends": "../../tsconfig.base.json",
  "compilerOptions": {
    "rootDir": "./src",
    "outDir": "./dist"
  },
  "include": ["src"]
}
```

## Project Metadata (`tseng/project-structure.md`)

After bootstrapping or reviewing, a `tseng/project-structure.md` file records the project layout with machine-readable HTML comments for tooling:

```markdown
<!-- package_manager: pnpm -->
<!-- server_path: packages/server -->
<!-- server_package_name: @myapp/server -->
<!-- client_path: packages/client -->
<!-- client_package_name: @myapp/client -->
<!-- workspace_root: . -->
<!-- workspace_config: pnpm-workspace.yaml -->
```

This file is the source of truth for other skills that need to locate packages.
