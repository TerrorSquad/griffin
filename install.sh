#!/usr/bin/env bash
# Interactive picker for Griffin's feature flags.
#
# The flag list is read from post-installation/defaults/main.yaml, so adding a
# flag there is the only edit needed - this script picks it up automatically.

set -euo pipefail

cd "$(dirname "$0")"

DEFAULTS="post-installation/defaults/main.yaml"
[ -f "$DEFAULTS" ] || { echo "Run this from the Griffin checkout." >&2; exit 1; }

case "$(uname -s)" in
  Darwin) PLAYBOOK="playbook_macos.yaml" ;;
  *) PLAYBOOK="playbook.yaml" ;;
esac

# mapfile is bash 4+; macOS ships bash 3.2 and this script runs before
# Homebrew provides a newer one. `while read` works on both.
#
# Boolean flags, in file order. Skips `all` - it is the "everything" shortcut,
# not a per-feature choice.
FLAGS=()
while IFS= read -r flag; do
  FLAGS+=("$flag")
done < <(awk '/^[a-z_]+: (true|false)$/ {
                split($0, f, ":")
                if (f[1] != "all") print f[1]
              }' "$DEFAULTS")

[ ${#FLAGS[@]} -gt 0 ] || { echo "No flags found in $DEFAULTS." >&2; exit 1; }

# Default-on flags get pre-selected so the picker reflects current behaviour.
PRESELECTED=()
while IFS= read -r flag; do
  PRESELECTED+=("$flag")
done < <(awk '/^[a-z_]+: true$/ {split($0, f, ":"); if (f[1] != "all") print f[1]}' "$DEFAULTS")

if ! command -v gum >/dev/null 2>&1; then
  echo "gum is not installed. Either install it (brew install gum) or run:"
  echo "  ansible-playbook ./$PLAYBOOK -K -e all=true"
  exit 1
fi

gum style --border rounded --padding "0 1" \
  "Griffin" "Pick what to install. Space selects, Enter confirms."

selected_csv=$(IFS=,; echo "${PRESELECTED[*]-}")
CHOSEN=()
while IFS= read -r choice; do
  CHOSEN+=("$choice")
done < <(gum choose --no-limit --height 20 \
           --selected "$selected_csv" \
           --header "Feature flags (Ctrl-C to abort):" \
           "${FLAGS[@]}")

# gum exits 0 with no output if the user selects nothing.
if [ ${#CHOSEN[@]} -eq 0 ]; then
  echo "Nothing selected - installing core CLI tools and shell environment only."
fi

# Every flag is passed explicitly, on or off. Passing only the chosen ones
# would let a default-true flag (kde, remove_snap) survive being deselected.
ARGS=()
for flag in "${FLAGS[@]}"; do
  value=false
  for chosen in ${CHOSEN[@]+"${CHOSEN[@]}"}; do
    [ "$chosen" = "$flag" ] && value=true && break
  done
  ARGS+=(-e "$flag=$value")
done

echo
echo "ansible-playbook ./$PLAYBOOK -K ${ARGS[*]}"
echo
gum confirm "Run it?" || exit 0

exec ansible-playbook "./$PLAYBOOK" -K "${ARGS[@]}"
