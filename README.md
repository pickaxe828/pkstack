# pkstack

Personal agent skills and harness tooling.

## Compatibility

pkstack is meant to be installed alongside [mattpocock/skills](https://github.com/mattpocock/skills) and [t3dotgg/tstack](https://github.com/t3dotgg/tstack). Its skills avoid the names those stacks use, so all three can share one skills directory. They also build on those skills rather than copying them: `spec-to-pr` calls `tdd` from mattpocock/skills, and `proof` is adapted from the Proof section of tstack's `full-send`.

Before adding a skill, check that its name isn't already taken in either stack.

## Skills

- [`proof`](skills/proof/SKILL.md) — gather observed evidence that a change works and report it in the PR. Triggers: "with proof", "with prove", "proof in PR".
- [`spec-to-pr`](skills/spec-to-pr/SKILL.md) — user-invoked: implement a spec issue with TDD, run a review council to a target score, and open a draft PR with proof. Usage: `/spec-to-pr #4`.
