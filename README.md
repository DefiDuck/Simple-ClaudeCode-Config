# claude-code-config

My global Claude Code configuration. Rules and reusable skills, codified from analyzing my own usage.

## What's in here

- **`CLAUDE.md`**: Global rules every Claude Code session inherits. Output discipline, git hygiene, verify-before-implementing, parallel sub-agents.
- **`skills/diagnose/SKILL.md`**: Reusable evidence-driven debugging skill. Triggers automatically on vague bug reports.
- **`install.ps1`**: Windows installer. Copies everything into `~/.claude/`.

## Why this exists

I ran an analytics report on 22 days of my own Claude Code usage. The audit was uncomfortable:

- 5 of 11 sessions died mid-work to output token limits.
- 5 outcomes flagged "unclear". I literally didn't know if the work landed.
- I corrected the same domain rule twice in one session because I never wrote it down.
- I dispatched parallel sub-agents only 19 times in 305 messages. Most multi-strand work was serial when it didn't have to be.

Thirty minutes of configuration later, every future session inherits the fixes automatically. This repo is that config.

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
mkdir -p ~/.claude/skills/diagnose
cp CLAUDE.md ~/.claude/CLAUDE.md
cp skills/diagnose/SKILL.md ~/.claude/skills/diagnose/SKILL.md
```

Restart Claude Code. Done.

## Principle

AI tools are infrastructure. Most people use them like a search engine.

The leverage isn't the model getting better. It's *you* removing your own friction. Codify your conventions. Capture your repeated corrections. Build reusable skills out of your recurring workflows.

## License

MIT. Do whatever you want with it.
