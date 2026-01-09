ARG BUN_VERSION

FROM oven/bun:${BUN_VERSION:-1.3}-alpine AS base

WORKDIR /app

RUN apk add --no-cache curl git
COPY . .

RUN --mount=type=cache,target=/root/.bun \
    --mount=type=cache,target=/app/build/node_modules \
    bun install --frozen-lockfile \
    && bun nx run-many --target=build

