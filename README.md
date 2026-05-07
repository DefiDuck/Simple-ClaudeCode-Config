# Simple Claude Code Config

A small, opinionated pack of global rules and reusable skills for Claude Code. Codified from analyzing my own usage patterns and the friction I kept hitting.

The principle: AI tools are infrastructure. Most people use them like a search engine. The leverage is in the configuration, not the model.

## What's in here

### Global rules

`CLAUDE.md` is read by every Claude Code session, in every project, automatically. Four sections:

- **Output Discipline**: chunk large work, never dump full files in one response.
- **Git Hygiene**: `git status` before edits, atomic commits, conventional prefixes.
- **Verify Before Implementing**: state assumptions for domain-specific work, do not guess.
- **Use Subagents**: dispatch parallel agents for independent work strands.

### Skills

Reusable skills that trigger automatically based on the task, or on demand by name.

| Skill | Triggers when | What it does |
|---|---|---|
| `/diagnose` | Vague bugs, silent failures, marginal fixes | Evidence-driven debugging loop. Instrument, repro, hypothesis with evidence, fix, strip. |
| `/release` | Shipping a version, tagging, "release", "bump" | Verifies clean tree, runs tests, decides semver bump, updates CHANGELOG, atomic commit, tag, push. |
| `/commit` | Ready to commit, "commit this", "save this" | Atomic conventional commits. Branch verification, logical grouping, conventional messages. |
| `/preflight` | Session start with external tool dependencies | Probes MCP servers, CLIs, APIs. Reports status. Proposes fallbacks before real work. |

## Why this exists

I ran an analytics report on 22 days of my own Claude Code usage. The audit was uncomfortable:

- 5 of 11 sessions died mid-work to output token limits.
- 5 outcomes flagged "unclear". I literally did not know if the work landed.
- I corrected the same domain rule twice in one session because I never wrote it down.
- I dispatched parallel sub-agents only 19 times in 305 messages. Most multi-strand work was serial when it didn't have to be.

I had been blaming the model. It wasn't the model.

Thirty minutes of configuration later, every future session inherits the fixes automatically. This repo is that config, expanded over time as I find new recurring patterns worth codifying.

## Install (Windows)

```powershell
git clone https://github.com/DefiDuck/Simple-ClaudeCode-Config.git
cd Simple-ClaudeCode-Config
& .\install.ps1
```

Restart Claude Code. Done.

## Install (macOS / Linux)

```bash
git clone https://github.com/DefiDuck/Simple-ClaudeCode-Config.git
cd Simple-ClaudeCode-Config
bash install.sh
```

Restart Claude Code. Done.

## What the installer does

- Creates `~/.claude/` if it does not exist.
- Copies `CLAUDE.md` to `~/.claude/CLAUDE.md`. If a CLAUDE.md is already there and does not contain these rules, appends. If it already contains them, leaves it alone.
- Copies every skill in `skills/` to `~/.claude/skills/`. Overwrites existing copies of the same skill so updates from `git pull` propagate.

Safe to re-run.

## Customizing

Fork the repo and edit. Each skill is a single self-contained markdown file with a frontmatter description that controls when Claude triggers it. The description is the only thing Claude sees when deciding whether to invoke a skill, so write it carefully (concrete trigger phrases, not abstract goals).

To add your own skill, create `skills/<your-skill>/SKILL.md` with a frontmatter block:

```markdown
---
name: my-skill
description: When to trigger this skill. Be specific. List the actual phrases the user might say. Describe the task category. Mention any files or tools that signal the skill should fire.
---

# My Skill

Whatever instructions Claude should follow when this skill fires.
```

Re-run the installer. Restart Claude Code. Done.

## Compatibility

- Tested with Claude Code on Windows 11 and macOS.
- Skills require Claude Code's skill support. If your version is older, the `/diagnose`, `/release`, `/commit`, and `/preflight` slash commands will not be available, but `CLAUDE.md` still applies.

## License

MIT. Do whatever you want with it.

## Background

The full story behind this repo is in this article: [I Audited 22 Days of My Own AI Coding. The Numbers Got Uncomfortable.](https://www.linkedin.com/in/your-article-link)
