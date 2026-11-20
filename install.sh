#!/usr/bin/env bash
# Install pkstack's skills plus the skills they call from other stacks.
#
# Usage: ./install.sh [skills-dir ...]
# Default: ~/.claude/skills and ~/.codex/skills, whichever exist.
#
# Skills already present in a target directory are left alone, so this never
# overwrites your own copies or edits.
set -euo pipefail

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Skills from other stacks that pkstack skills call: "repo path-in-repo".
deps=(
  "t3dotgg/tstack skills/council"
  "mattpocock/skills skills/engineering/tdd"
)

targets=("$@")
if [ ${#targets[@]} -eq 0 ]; then
  for d in "$HOME/.claude/skills" "$HOME/.codex/skills"; do
    [ -d "$d" ] && targets+=("$d")
  done
fi
if [ ${#targets[@]} -eq 0 ]; then
  echo "No skills directory found. Pass one, e.g. ./install.sh ~/.claude/skills" >&2
  exit 1
fi

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

install_skill() { # src-dir target-dir
  local name dest
  name="$(basename "$1")"
  dest="$2/$name"
  if [ -e "$dest" ] || [ -L "$dest" ]; then
    echo "  skip    $name (already installed)"
  else
    cp -R "$1" "$dest"
    echo "  install $name"
  fi
}

for dep in "${deps[@]}"; do
  read -r repo path <<<"$dep"
  clone="$tmp/${repo//\//_}"
  [ -d "$clone" ] || git clone -q --depth 1 "https://github.com/$repo" "$clone"
done

for target in "${targets[@]}"; do
  mkdir -p "$target"
  echo "$target"
  for skill in "$here"/skills/*/; do
    install_skill "${skill%/}" "$target"
  done
  for dep in "${deps[@]}"; do
    read -r repo path <<<"$dep"
    install_skill "$tmp/${repo//\//_}/$path" "$target"
  done
done
