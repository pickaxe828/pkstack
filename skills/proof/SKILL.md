---
name: proof
description: Gather direct evidence that code changes work and report it in the PR or handoff. Use when the user says "with prove", "with proof", "proof in PR", "prove it works", or otherwise asks for proof of an implementation or fix. Excludes mathematical proofs.
---

# Proof

Base confidence on evidence you personally observe during this task. Cover each behavior changed by the diff, using the most direct verification available.

## Gather evidence

1. Read the diff and identify the changed behaviors and their expected results. Choose a reproduction, check, or runtime observation for each; shared evidence can cover related changes.
2. For a bug fix, demonstrate the reported failure on the original code when feasible, then repeat the same steps with the fix. When existing coverage misses the bug and the repository has a test setup, add a focused regression test and verify that it fails without the fix and passes with it. Preserve unrelated working changes when comparing versions.
3. Run the relevant repository CI commands, discovering their actual definitions from the repository. Record the commands and results. Separate failures caused by this change from existing failures using observed evidence.
4. For changes to UI or runtime behavior, exercise the affected flow in the running application and inspect the outcome. Choose browser, device, simulator, CLI, or API checks to match the behavior. Mocked tests alone cannot establish that the real flow works. Capture screenshots or other artifacts when they make the result easier to review.
5. Fix failures within the task's scope and repeat affected checks after edits. Evidence must describe the final code; rerun checks invalidated by subsequent changes.

Use the testing tools and permissions available in the current session. This skill adds verification to the requested task; it does not grant the unrelated merge, force-push, or production permissions of full-send.

## Report the proof

When the task includes creating or updating a PR, put a concise **Proof** section in its description, preserving unrelated content. If the user requests only draft PR text, provide the section without publishing it. Otherwise include proof in the final handoff.

For each distinct behavior, report what you exercised, the command or reproduction steps, and the observed outcome. Include before/after results for fixes when available. Link useful screenshots, recordings, or logs using a supported upload method; a local path is not an attachment accessible to PR reviewers. If uploading is unavailable, identify the local artifact in the handoff and state that it is not attached to the PR.

Distinguish checks actually run from proposed checks. Identify any unverified behavior and the concrete blocker. Try another suitable method when one fails; if direct proof remains unavailable, ask a focused question about the missing access or environment and leave that part explicitly unproven.

Finish when the final diff's changed behaviors have observed evidence and the report is delivered, or when remaining gaps are clearly disclosed with the input needed to resolve them. Keep completion claims within what the evidence supports.

Adapted from the [Proof section of t3dotgg/tstack's full-send skill](https://github.com/t3dotgg/tstack/blob/main/skills/full-send/SKILL.md#proof).
