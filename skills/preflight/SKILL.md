---
name: preflight
description: Verify external tools and environment before depending on them. Use at the start of any session that will use MCP servers, external CLIs (gh, docker, kubectl, aws, etc.), or third-party APIs. Trigger when the user says "preflight", "check tools", "verify setup", "is everything working", or when the planned work depends on a tool that has failed before. Lists available tools, tests each with a trivial call, and proposes fallbacks if anything is down before any real work begins.
---

# Preflight Skill

Catch tool failures before they kill mid-session work.

## When to run

- At the start of any session that depends on MCP servers, external CLIs, or APIs.
- After noticing two or more tool errors in a session.
- Before kicking off a long autonomous loop that cannot recover from a missing tool.

## The check

1. **List MCP servers in scope.** Read `.mcp.json` or the equivalent project config. Enumerate the names.
2. **Probe each MCP server.** Send a trivial, side-effect-free call (a list, a get, a search with a benign query). Note response time and any errors.
3. **List CLI dependencies the task needs.** Examples: `gh`, `docker`, `kubectl`, `aws`, `gcloud`, `cargo`, `npm`, `python`. Read the project's README or scripts for hints.
4. **Test each CLI.** `<cli> --version` is enough. Capture the output.
5. **List API dependencies.** Anything the task will call over the network beyond MCP servers (e.g. a TradingView desktop app, a local model server, a custom internal API).
6. **Check auth state where relevant.** `gh auth status`, `docker login`, AWS credentials. Do not print secrets.

## Report

7. Output a short status table:
   - Tool name
   - Status: ok / down / missing / auth-required
   - Notes (version, response time, error if any)
8. If everything is green, say so in one line and proceed.
9. If any tool is down or missing, stop. Propose:
   - The fallback approach for that tool
   - Whether to abort, switch to fallback, or wait while the user fixes the issue
10. Wait for the user's decision before continuing with the planned work.

## Output discipline

- Be terse. The preflight report is a tool, not a story. One line per tool, one line of summary.
- Do not run the actual task work as part of preflight. Preflight ends and the real plan begins.

## Anti-patterns

- Running preflight, finding a failure, and proceeding with the original plan anyway.
- Probing tools with calls that have side effects (sending messages, creating resources, modifying state).
- Re-running preflight inside the same session unless something changed.
- Treating a slow response as a failure. Note the latency, do not abort.
