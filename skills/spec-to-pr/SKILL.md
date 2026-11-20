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

## Dependencies

This skill calls `tdd` from [mattpocock/skills](https://github.com/mattpocock/skills), `council` from [t3dotgg/tstack](https://github.com/t3dotgg/tstack), and `proof` from pkstack. Before step 1, check that all three are in your available skills. If any is missing, stop and tell the user which one, and that pkstack's `install.sh` installs it. Do not imitate a missing skill from memory.

## Boundaries

- Work in the current worktree on its own branch. Never push to, merge into, or rebase the default branch.
- The PR stays a draft. Never mark it ready or merge it.
- If a requested model is unavailable, say so and ask. Do not substitute another model.

## Steps

1. **Read the spec.** Read the issue and any linked sub-issues. When sub-issues block one another, implement them in dependency order. Otherwise implement the spec as one unit.
2. **Build test-first.** Call the Skill tool with `tdd`. Run the typecheck and single test files as you go, and the full suite at the end. Hand work to helper subagents only when it is independent of what you are doing. Brief them with pointers (the issue, files, commits), not restated context.
3. **Open the draft PR.** Commit, push the branch, and open a draft PR that closes the spec issue.
4. **Prove it.** Call the Skill tool with `proof`. The proof goes in the PR description.
5. **Convene the council.** Call the Skill tool with `council` to review the PR. Name the council members, and set "satisfied" as every member scoring at least the bar in the same round. Brief the members with the issue, the PR, and the branch and its base. `council` runs the rounds and puts the score table in the PR description.
6. **Within each round:** fix findings that hold up test-first, rerun the proof checks the fixes affect, and push before the next round. Any behavior change after the final round needs another round. If findings repeat across rounds or conflict with the spec, stop and ask the user instead of looping.
7. **Keep the PR current.** Its description holds the proof and the council table. Preserve unrelated content when updating it.

## Report

End with:

- the PR link and branch;
- the council table;
- what the reviews changed;
- a proof summary;
- decisions for the user, including any departure from the spec;
- confirmation that the default branch is untouched.
