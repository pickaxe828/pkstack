# pkstack

Personal agent skills and harness tooling.

## Compatibility

pkstack is meant to be installed alongside [mattpocock/skills](https://github.com/mattpocock/skills) and [t3dotgg/tstack](https://github.com/t3dotgg/tstack). Its skills avoid the names those stacks use, so all three can share one skills directory. They also build on those skills rather than copying them: `spec-to-pr` calls `tdd` from mattpocock/skills and `council` from tstack, and `proof` is adapted from the Proof section of tstack's `full-send`.

Before adding a skill, check that its name isn't already taken in either stack.

## Dependencies

Some pkstack skills call skills from the other stacks:

| pkstack skill | Needs |
| --- | --- |
| `spec-to-pr` | `tdd` (mattpocock/skills), `council` (t3dotgg/tstack), `proof` (pkstack) |

`spec-to-pr` checks for these when it starts. If one is missing, it stops and names it instead of guessing.

## Install

```bash
git clone https://github.com/pickaxe828/pkstack
./pkstack/install.sh                    # ~/.claude/skills and ~/.codex/skills, whichever exist
./pkstack/install.sh ~/some/skills/dir  # or name the directories
```

The script installs every pkstack skill plus the dependencies above, fetched from their own repos. It skips any skill already in the target directory, so it never overwrites your copies or edits.

## Skills

- [`proof`](skills/proof/SKILL.md) — gather observed evidence that a change works and report it in the PR. Triggers: "with proof", "with prove", "proof in PR".
- [`spec-to-pr`](skills/spec-to-pr/SKILL.md) — user-invoked: implement a spec issue with TDD, run a review council to a target score, and open a draft PR with proof. Usage: `/spec-to-pr #4`.
