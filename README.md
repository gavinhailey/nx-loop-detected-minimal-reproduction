# NX Loop Detected Minimal Reproduction

## Issue Description

This repository demonstrates a loop detection error that occurs when using **Nx v22+** with **Bun** in a **Docker Alpine Linux** environment. The same configuration works without issues on Nx v21.6.10.

### Error Message

```
NX   Project graph construction cannot be performed due to a loop detected in the call stack.
This can happen if 'createProjectGraphAsync' is called directly or indirectly during project graph construction.

To avoid this, you can add a check against "global.NX_GRAPH_CREATION" before calling "createProjectGraphAsync".
Call stack:
buildProjectGraphAndSourceMapsWithoutDaemon (/app/node_modules/.bun/nx@22.3.3/node_modules/nx/src/project-graph/project-graph.js:81:62)
createProjectGraphAndSourceMapsAsync (/app/node_modules/.bun/nx@22.3.3/node_modules/nx/src/project-graph/project-graph.js:274:31)
createProjectGraphAndSourceMapsAsync (/app/node_modules/.bun/nx@22.3.3/node_modules/nx/src/project-graph/project-graph.js:225:53)
createProjectGraphAsync (/app/node_modules/.bun/nx@22.3.3/node_modules/nx/src/project-graph/project-graph.js:222:45)
createProjectGraphAsync (/app/node_modules/.bun/nx@22.3.3/node_modules/nx/src/project-graph/project-graph.js:205:40)
runMany (/app/node_modules/.bun/nx@22.3.3/node_modules/nx/src/command-line/run-many/run-many.js:27:52)
processTicksAndRejections (native)
```

## Environment

- **Nx Version**: 22.3.3 (issue occurs on v22+)
- **Working Nx Version**: 21.6.10 (no issues)
- **Bun Version**: 1.3.5
- **Docker Base Image**: `oven/bun:1.3-alpine`
- **OS**: Alpine Linux
- **Docker Version**: 29.1.3

## Repository Structure

This is a minimal monorepo setup with two packages:

```
.
├── packages/
│   ├── package-1/
│   │   ├── index.ts
│   │   ├── package.json
│   │   └── tsconfig.json
│   └── package-2/
│       ├── index.ts
│       ├── package.json
│       └── tsconfig.json
├── Dockerfile
├── package.json
└── tsconfig.json
```

## Reproduction Steps

1. Clone this repository
2. Run the Docker build:
   ```bash
   docker build .
   ```
3. Observe the loop detection error during `bun nx run-many --target=build`

## Expected Behavior

The build should complete successfully, as it does with Nx v21.6.10.

## Actual Behavior

Nx fails with a recursive call stack error during project graph construction, suggesting that `createProjectGraphAsync` is being called recursively within itself.

## Notes

- This issue is specific to the combination of Nx v22+, Bun, and Alpine Linux in Docker
- The same configuration works on Nx v21.6.10
- The error suggests a potential issue with how Nx v22+ handles project graph construction in this specific environment

