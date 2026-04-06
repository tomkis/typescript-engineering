# TypeScript Engineering Plugin

Coding agents produce little to no architecture in greenfield TypeScript projects. You get a flat pile of files, no separation of concerns, and no structure you'd want to maintain long-term.

This Claude Code plugin fills that gap. When you're starting a new client-server TypeScript project, it gives the agent an opinionated architecture to follow — monorepo layout, tRPC for the API layer, and a DDD-inspired separation of domain, application, and validation layers.

Bootstrap a new project or validate an existing one:

```
/project:tseng-bootstrap
```
