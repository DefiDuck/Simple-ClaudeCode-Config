---
name: commit
description: Atomic conventional commits. Use when the user says "commit", "commit this", "save this", "wrap this up", asks to write a commit message, or finishes a logical chunk of work and the working tree has unstaged or staged changes. Groups related changes into atomic commits with conventional prefixes (feat, fix, chore, docs, refactor, test), verifies the branch matches the task, and refuses to dump unrelated changes into a single commit.
---

# Commit Skill

Disciplined commit loop. Atomic. Conventional. Branch-aware.

## Pre-flight

1. Run `git status` and `git branch --show-current`.
2. State the current branch. Confirm it matches the task at hand. If the user said they were working on `track-a/pipeline` and the current branch is `track-b/ui-shell`, stop and flag it before doing anything else.
3. Run `git diff --stat` to see what changed.

## Group the changes

4. Read the full diff (`git diff` for unstaged, `git diff --cached` for staged).
5. Identify logical groups. A group is a set of changes that serve a single purpose. Examples:
   - All edits implementing one feature plus its test
   - One bug fix and the regression test for it
   - Documentation updates touching multiple files but covering one topic
6. If everything serves one purpose, propose a single commit.
7. If the diff covers multiple unrelated purposes, propose multiple commits and explain the grouping.

## Write the messages

8. Use Conventional Commits format: `<type>(<scope>): <subject>`.
   - `feat`, `fix`, `chore`, `docs`, `refactor`, `test`, `style`, `perf`, `build`, `ci`
9. Subject: imperative mood, lowercase, no trailing period. Under 72 characters.
10. Body (optional): explain *why*, not *what*. The diff already shows what.
11. Footer (optional): `BREAKING CHANGE:` for breaking changes, `Closes #123` for issue refs.

## Execute

12. Show the user the full plan: which files go in which commit, what the messages will be.
13. Wait for confirmation.
14. For each planned commit:
    - `git add <files>`
    - `git commit -m "<subject>" -m "<body>"` (use multiple `-m` flags or a heredoc for multi-line bodies; do not use shell escaping that breaks subjects)
15. Run `git log --oneline -<n>` after to confirm.

## Anti-patterns

- One mega-commit covering "various improvements" with twelve unrelated changes.
- Vague subjects: `update`, `fixes`, `wip`, `stuff`.
- Committing without confirming the branch.
- Force-pushing to shared branches.
- Adding files you have not inspected (`git add -A` without first reviewing `git status`).
- Letting Claude pick a commit message based only on filenames; always read the actual diff content first.
