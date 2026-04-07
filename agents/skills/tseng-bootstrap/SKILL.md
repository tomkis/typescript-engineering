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

1. Read all files in `agents/practices/` — they define the architecture, stack, and project structure you must follow.
2. Ask the user for a project name (or infer from the directory name) and package manager preference (default: pnpm).
3. Scaffold the full monorepo with working sample code in every layer, conforming to everything described in the practices.
4. Write `tseng/project-structure.md` with the project metadata format described in the practices.
5. Tell the user what was created and suggest next steps.

## Guidelines

- Greenfield projects only — the directory should be empty or near-empty.
- Include working sample code in each layer, not just empty directories.
- The practices are the source of truth — don't deviate from them.
