---
name: tseng-bootstrap
description: >
  Bootstrap a new greenfield TypeScript client-server project with an opinionated
  monorepo architecture. Use when the user asks to bootstrap, scaffold, or initialize
  a new project. Triggers on phrases like "bootstrap my project", "scaffold a new project",
  "start a new typescript project", "set up my project", or "create a new app".
  Also invocable via the /project:tseng-bootstrap slash command.
---

# TSEng Bootstrap

Scaffolds a new greenfield TypeScript client-server monorepo.

## How It Works

1. Read `agents/architecture/index.md` — it describes the overall architecture and points to deeper dives on each topic.
2. Read the specific architecture files you need for the current step of bootstrapping. You will likely need all of them, but load them as you go rather than all at once.
3. Ask the user for a project name (or infer from the directory name) and package manager preference (default: pnpm).
4. Scaffold the full monorepo with working sample code in every layer, conforming to the architecture.
5. Write `tseng/project-structure.md` with the project metadata format described in the architecture docs.
6. Tell the user what was created and suggest next steps.

## Guidelines

- Greenfield projects only — the directory should be empty or near-empty.
- Include working sample code in each layer, not just empty directories.
- The architecture docs are the source of truth — don't deviate from them.
