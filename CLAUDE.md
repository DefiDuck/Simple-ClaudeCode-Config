# Global CLAUDE.md

## Output Discipline
- Chunk large work: complete one TodoWrite item, summarize in <=3 bullets, move to next. Never dump full plans or full file contents in a single response.
- For edits >50 lines, use Edit/Write tool calls, not inline code blocks.

## Git Hygiene
- Run `git status` before the first edit of any session and confirm the branch matches the task.
- Atomic commits: one logical change per commit, conventional prefix (feat/fix/chore/docs).
- Never silently drop or revert an Edit — re-apply and confirm.

## Verify Before Implementing
- For domain-specific work (MTG rules, trading semantics, CV thresholds, etc.), state your assumptions before coding and ask if unsure. Do not guess.
- Pre-flight external tools (MCP servers, CLIs) at session start; propose a fallback if any are down.

## Use Subagents
- For independent work strands (parallel cataloging, parameter sweeps, multi-source extraction), dispatch parallel agents instead of doing it serially.
