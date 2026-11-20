---
name: spec-to-pr
description: Implement a spec issue test-first, iterate a cross-model review council to a target score, and open a draft PR with proof.
disable-model-invocation: true
argument-hint: "<issue> [council <score>] [members...]"
---

# Spec to PR

Arguments: $ARGUMENTS

Read these inputs from the arguments, using the defaults for any left out:

- **Spec:** an issue number or URL. Fetch it and state its title before starting. If the reference is ambiguous, ask.
- **Council bar:** the score out of 10 that every member must reach in the same round. Default: 9.
- **Council members:** default GPT-6.2 Sol at medium effort and Claude Sonnet 5.5 at medium effort.
- **Helper subagents:** Claude Sonnet 5.5 at medium effort, for implementation or testing work you hand off.

## Boundaries

- Work in the current worktree on its own branch. Never push to, merge into, or rebase the default branch.
- The PR stays a draft. Never mark it ready or merge it.
- If a requested model is unavailable, say so and ask. Do not substitute another model.

## Steps

1. **Read the spec.** Read the issue and any linked sub-issues. When sub-issues block one another, implement them in dependency order. Otherwise implement the spec as one unit.
2. **Build test-first.** Call the Skill tool with `tdd`. Run the typecheck and single test files as you go, and the full suite at the end. Hand work to helper subagents only when it is independent of what you are doing. Brief them with pointers (the issue, files, commits), not restated context.
3. **Open the draft PR.** Commit, push the branch, and open a draft PR that closes the spec issue.
4. **Prove it.** Call the Skill tool with `proof`. The proof goes in the PR description.
5. **Convene the council.** Start one fresh review delegate per member, in parallel, using the harness's mechanism for running other providers' models (in T3 Code, `delegate_task`). Brief each with the issue, the PR, the branch and its base, and the bar. Ask for a score out of 10 and findings ranked by severity, each with a concrete failure scenario.
6. **Act on findings.** Check each finding against the code before acting. Fix the ones that hold up, test-first. Record a reason for each one you reject. Rerun the proof checks the fixes affect, then push.
7. **Repeat rounds.** If any member scored below the bar, start a new round with new delegates. Their brief includes the previous findings and how you handled each. Stop when every member meets the bar in the same round. Any behavior change after that round needs another round. If findings repeat across rounds or conflict with the spec, stop and ask the user instead of looping.
8. **Keep the PR current.** Its description holds the proof and a council table of each member's score per round. Preserve unrelated content when updating it.

## Report

End with:

- the PR link and branch;
- the council table;
- what the reviews changed;
- a proof summary;
- decisions for the user, including any departure from the spec;
- confirmation that the default branch is untouched.
