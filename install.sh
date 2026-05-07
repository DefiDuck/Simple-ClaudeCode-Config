#!/usr/bin/env bash
# Installs the global CLAUDE.md and every skill in skills/ into ~/.claude/
# Run:  bash install.sh
# Safe to re-run.

set -euo pipefail

CLAUDE_ROOT="$HOME/.claude"
SKILLS_TARGET="$CLAUDE_ROOT/skills"
SOURCE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p "$CLAUDE_ROOT" "$SKILLS_TARGET"

# CLAUDE.md: append if exists, create if not
CLAUDE_MD_TARGET="$CLAUDE_ROOT/CLAUDE.md"
CLAUDE_MD_SOURCE="$SOURCE/CLAUDE.md"

if [ -f "$CLAUDE_MD_TARGET" ]; then
    if grep -q "Output Discipline" "$CLAUDE_MD_TARGET"; then
        echo "CLAUDE.md already contains the rules. Skipping append."
    else
        printf "\n\n" >> "$CLAUDE_MD_TARGET"
        cat "$CLAUDE_MD_SOURCE" >> "$CLAUDE_MD_TARGET"
        echo "Appended global rules to existing CLAUDE.md."
    fi
else
    cp "$CLAUDE_MD_SOURCE" "$CLAUDE_MD_TARGET"
    echo "Created CLAUDE.md at $CLAUDE_MD_TARGET"
fi

# Skills: copy every subfolder in skills/
for skill_dir in "$SOURCE/skills"/*/; do
    [ -d "$skill_dir" ] || continue
    skill_name="$(basename "$skill_dir")"
    target="$SKILLS_TARGET/$skill_name"
    mkdir -p "$target"
    cp -R "$skill_dir"* "$target/"
    echo "Installed /$skill_name skill at $target"
done

echo ""
echo "Done. Restart Claude Code for changes to take effect."
