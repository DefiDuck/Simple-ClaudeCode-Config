---
name: diagnose
description: Evidence-driven debugging via diagnostic instrumentation. Use when the user reports a vague bug ("detection is bad", "the metric flatlined", "this isn't working"), when symptoms suggest a silent failure (no error, wrong output), when prior fixes only marginally improved things, or any time the user says "instrument", "diagnose", "isolate", "find the root cause", or asks why something is misbehaving. Replaces guess-and-patch with a structured loop: instrument the suspect boundary, run a repro, capture output, propose a hypothesis with evidence, then remove instrumentation after the fix lands.
---

# Diagnose Skill

Evidence-driven debugging loop. Never guess at fixes. Isolate the root cause first, then patch.

## When to use
- Vague bug reports ("detection is bad", "the metric flatlined")
- Silent failures (no error, wrong output)
- Prior fixes that only marginally improved things
- Anywhere the symptom-cause link isn't already obvious

## The loop

1. **Identify the suspect boundary.** State explicitly which function/module/stage you suspect and why. If unsure, list 2-3 candidate boundaries and pick the one with the best signal-to-effort ratio.

2. **Add structured instrumentation.** Insert prefixed log statements at the boundary. Use a unique, greppable prefix (e.g. `[DIAG-canny]`, `dbg!("[DIAG-route]"...)`). Log inputs, outputs, intermediate state, and shape/size where relevant. Keep instrumentation cheap and bounded — no unbounded loops, no PII.

3. **Run the minimal repro.** Identify or build the smallest command that reproduces the issue. Capture stdout/stderr to a tmp file (`/tmp/diag-<timestamp>.log` or equivalent on the platform).

4. **Propose a hypothesis with evidence.** Quote the exact log lines that support the hypothesis. Format: "Hypothesis: X. Evidence: lines N-M show Y, which means Z." If the evidence is ambiguous, return to step 2 and add more instrumentation — do not advance to a fix.

5. **Implement the fix.** Atomic commit with a metrics-tagged or evidence-tagged message (e.g. `fix(canny): restore edge map after blur — was zeroed by stride mismatch`).

6. **Remove instrumentation.** Search the codebase for the unique prefix you used and strip every line. Confirm with a final grep — leftover diagnostic logging is a code smell. Commit the cleanup separately.

## Output discipline within this skill
- Don't try to do all six steps in one response. Drive the loop one step at a time, checkpointing with TodoWrite if the session is long.
- Quote evidence; do not paraphrase log output when proving a hypothesis.

## Anti-patterns to avoid
- Guessing at parameter tweaks before isolating the boundary (the "marginal patch" trap)
- Adding instrumentation everywhere instead of at the suspect boundary
- Forgetting to remove instrumentation after the fix lands
- Advancing to a fix when the evidence is ambiguous
