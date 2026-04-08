---
name: bootstrap
description: >
  Bootstrap a new greenfield TypeScript client-server project with an opinionated
  monorepo architecture. Use when the user asks to bootstrap, scaffold, or initialize
  a new project. Triggers on phrases like "bootstrap my project", "scaffold a new project",
  "start a new typescript project", "set up my project", or "create a new app".
  Also invocable via the /tseng:bootstrap slash command.
---

# TSEng Bootstrap

Scaffolds a new greenfield TypeScript client-server monorepo.

## How It Works

1. **Greenfield check** — List the target directory contents. If it contains existing source code, `package.json`, or a `packages/` directory, **stop immediately** and tell the user this skill is for greenfield projects only. Suggest using the `review` skill instead to audit their existing project. Only allow proceeding if the directory is empty or contains only dotfiles (`.git`, `.gitignore`, etc.), `README.md`, or `LICENSE`.
2. Read `architecture/index.md` — it describes the overall architecture and points to deeper dives on each topic.
3. Read the specific architecture files you need for the current step of bootstrapping. You will likely need all of them, but load them as you go rather than all at once.
4. Ask the user for a project name (or infer from the directory name), server runtime (Hono or Express, default: Hono), and package manager preference (default: pnpm).
5. Scaffold the full monorepo with working sample code in every layer, conforming to the architecture.
6. Write `tseng/project-structure.md` with the project metadata format described in the architecture docs.
7. Write `tseng/index.md` using the template from the architecture docs (include only the "Project Metadata" section since this is a fresh project).
8. Add a `## TSEng` section to the project's root `CLAUDE.md` pointing to `tseng/index.md`. If `CLAUDE.md` doesn't exist, create it.
9. Tell the user what was created and suggest next steps.

## Guidelines

- Greenfield projects only — the directory should be empty or near-empty.
- Include working sample code in each layer, not just empty directories.
- The architecture docs are the source of truth — don't deviate from them.
