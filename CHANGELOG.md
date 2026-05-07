# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.2.0] - 2026-05-07

### Added

- `/release` skill: disciplined release loop. Verifies clean tree, runs tests, decides semver bump from conventional commits, updates CHANGELOG, atomic commit, annotated tag, push.
- `/commit` skill: atomic conventional commits. Branch verification, logical grouping of changes, conventional commit messages, refuses to dump unrelated changes into one commit.
- `/preflight` skill: tool and environment verification at session start. Probes MCP servers, CLIs, and APIs before depending on them. Proposes fallbacks if anything is down.
- `install.sh`: macOS and Linux installer.

### Changed

- `install.ps1` now copies every skill in `skills/` generically instead of only the `diagnose` skill.
- README expanded to document the full skill pack.

## [0.1.0] - 2026-05-06

### Added

- `CLAUDE.md`: global rules for output discipline, git hygiene, verify-before-implementing, and sub-agent usage.
- `/diagnose` skill: evidence-driven debugging loop. Identify boundary, instrument, run repro, hypothesis with evidence, fix, strip instrumentation.
- `install.ps1`: Windows installer.
- MIT license.
