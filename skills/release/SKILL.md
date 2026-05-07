---
name: release
description: Ship a versioned release with discipline. Use when the user wants to ship, cut, tag, publish, or release a new version (v0.1.5, 1.2.0, etc.), when they mention "release" or "version bump" or "ship it" or updating CHANGELOG, or when they ask to tag a release. Runs the full release loop. Verify clean tree, run tests, decide semver bump, update CHANGELOG with the new entry, atomic commits with conventional prefixes, annotated git tag, and push tags. Refuses to ship if tests fail or working tree is dirty.
---

# Release Skill

Disciplined release loop. No shipping if anything is dirty or broken.

## Pre-flight

1. Confirm working tree is clean: run `git status --porcelain`. If output is non-empty, stop and ask the user whether to commit, stash, or abort.
2. Confirm current branch is the release branch (typically `main` or `release/*`). If not, stop and ask.
3. Pull latest from origin to avoid stale-local releases.

## Decide the version

4. Read the most recent tag with `git describe --tags --abbrev=0` (or `git tag --list --sort=-v:refname | head -1`).
5. Inspect commits since that tag: `git log <last-tag>..HEAD --oneline`.
6. Propose a semver bump based on conventional commit prefixes:
   - `feat:` -> minor bump
   - `fix:` -> patch bump
   - Any `BREAKING CHANGE:` footer -> major bump
   - `chore:` / `docs:` only -> patch (or skip the release entirely, ask)
7. State the proposed version and reasoning. Wait for user confirmation before proceeding.

## Run the release

8. Run the full test suite. Stop on any failure.
9. Update `CHANGELOG.md` with a new section under `## [vX.Y.Z] - YYYY-MM-DD`. Group entries by type (Added, Changed, Fixed, Removed). Use commit messages and PR titles as source material. Be concise.
10. Stage CHANGELOG and any version-bump files (e.g. `package.json`, `Cargo.toml`, `pyproject.toml`).
11. Commit: `chore(release): vX.Y.Z`.
12. Tag: `git tag -a vX.Y.Z -m "vX.Y.Z\n\n<short summary of changes>"`.
13. Push branch and tag: `git push && git push --tags`.

## Confirm

14. Verify the tag is on origin: `git ls-remote --tags origin | grep vX.Y.Z`.
15. If a release platform is involved (GitHub Releases, npm, crates.io, etc.), prompt the user with the next step. Do not auto-publish.

## Anti-patterns

- Tagging a dirty working tree.
- Skipping the test run because "the change is small".
- Squashing CHANGELOG updates into the same commit as feature work.
- Inferring version bumps without showing the user the commit list first.
- Force-pushing tags. Tags are immutable.
