#!/usr/bin/env bash
# Interactive picker for Griffin's feature flags.
#
# Deliberately dependency-free: this runs on a fresh system, before Homebrew
# has installed anything. Plain bash builtins only - no gum, no dialog, no
# whiptail. bash 3.2 compatible (macOS ships 3.2 and this runs before brew
# provides a newer one).
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

# Current state, parallel array to FLAGS. Defaults come from the YAML, so
# accepting everything reproduces a standard install.
STATE=()
for flag in "${FLAGS[@]}"; do
  if grep -q "^$flag: true$" "$DEFAULTS"; then
    STATE+=(true)
  else
    STATE+=(false)
  fi
done

# The comment lines above a flag document it. Show the first one as help text.
describe() {
  awk -v want="$1" '
    /^#/ { comment = comment ? comment " " substr($0, 3) : substr($0, 3); next }
    /^[a-z_]+:/ {
      split($0, f, ":")
      if (f[1] == want && comment) { print substr(comment, 1, 70); exit }
      comment = ""
      next
    }
    { comment = "" }
  ' "$DEFAULTS"
}

toggle() {
  local idx=$1
  if [ "${STATE[idx]}" = true ]; then STATE[idx]=false; else STATE[idx]=true; fi
}

print_menu() {
  echo
  echo "  Griffin - select what to install"
  echo "  ────────────────────────────────────────────────────────"
  local i=0
  for flag in "${FLAGS[@]}"; do
    local mark=" "
    [ "${STATE[$i]}" = true ] && mark="x"
    printf "  %2d) [%s] %s\n" "$((i + 1))" "$mark" "$flag"
    local help
    help=$(describe "$flag")
    [ -n "$help" ] && printf "         %s\n" "$help"
    i=$((i + 1))
  done
  echo "  ────────────────────────────────────────────────────────"
  echo "  number = toggle   a = all on   n = none   q = quit"
  echo
}

# Non-interactive (piped, CI): skip the menu and use the YAML defaults.
if [ ! -t 0 ]; then
  echo "Not a terminal - using defaults from $DEFAULTS."
else
  while true; do
    print_menu
    printf "  Toggle, or press Enter to continue: "
    read -r reply || break
    case "$reply" in
      "") break ;;
      q|Q) echo "Aborted."; exit 0 ;;
      a|A) for i in "${!STATE[@]}"; do STATE[i]=true; done ;;
      n|N) for i in "${!STATE[@]}"; do STATE[i]=false; done ;;
      *[!0-9\ ]*) echo "  ! Enter a number, a, n, or q." ;;
      *)
        # Accept several numbers at once: "1 4 7"
        for num in $reply; do
          if [ "$num" -ge 1 ] 2>/dev/null && [ "$num" -le ${#FLAGS[@]} ]; then
            toggle $((num - 1))
          else
            echo "  ! No option $num."
          fi
        done
        ;;
    esac
  done
fi

# Every flag is passed explicitly, on or off. Passing only the enabled ones
# would let a default-true flag (kde, remove_snap) survive being switched off.
ARGS=()
for i in "${!FLAGS[@]}"; do
  ARGS+=(-e "${FLAGS[$i]}=${STATE[$i]}")
done

echo
echo "  ansible-playbook ./$PLAYBOOK -K ${ARGS[*]}"
echo

if [ -t 0 ]; then
  printf "  Run it? [Y/n] "
  read -r confirm || true
  case "$confirm" in
    [nN]*) echo "Aborted."; exit 0 ;;
  esac
fi

exec ansible-playbook "./$PLAYBOOK" -K "${ARGS[@]}"
