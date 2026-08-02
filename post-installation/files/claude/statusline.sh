#!/usr/bin/env bash
# ponytail status line: high-signal monitoring for Claude Code
# Identity: ~/.claude.json account > git email | Features: OSC 8 links, usage limits

[ -t 0 ] && exit 0
in=$(cat)
[ -z "$in" ] && exit 0

if ! command -v jq >/dev/null 2>&1; then
  printf '⚠️ jq missing\n'
  exit 1
fi

export LC_NUMERIC=C # printf '%.2f' must emit '.', not a locale decimal comma

C_R='\033[31m'   # Red
C_Y='\033[33m'   # Yellow
C_G='\033[32m'   # Green
C_M='\033[1;35m' # Magenta
C_C='\033[36m'   # Cyan
C_D='\033[90m'   # Dark Gray
C_X='\033[0m'    # Reset

# Single-pass jq extraction (official statusline schema only)
eval "$(printf '%s' "$in" | jq -r '
  @sh "model=\(.model.display_name // "")",
  @sh "cost=\(.cost.total_cost_usd // "")",
  @sh "ctx=\(.context_window.used_percentage // "")",
  @sh "h5=\(.rate_limits.five_hour.used_percentage // "")",
  @sh "h5r_ts=\(.rate_limits.five_hour.resets_at // "")",
  @sh "wk=\(.rate_limits.seven_day.used_percentage // "")",
  @sh "wkr_ts=\(.rate_limits.seven_day.resets_at // "")",
  @sh "repo=\((.workspace.current_dir // .cwd // "") | sub(".*/"; ""))"
' 2>/dev/null)"

time_until() {
  local t=${1%.*} now d h m
  # resets_at may be epoch seconds or milliseconds; normalise to seconds
  case $t in
    '' | *[!0-9]*) return ;;
  esac
  [ "${#t}" -gt 11 ] && t=$((t / 1000))
  now=$(date +%s)
  d=$((t - now)); [ "$d" -lt 0 ] && d=0
  h=$((d/3600)); m=$(((d%3600)/60))
  printf '%dh%02dm' "$h" "$m"
}

colorize_pct() {
  local pct=${1%.*} label=$2
  case $pct in
    '' | *[!0-9]*) return ;;
  esac
  if [ "$pct" -ge 85 ]; then printf '%b%s %s%%%b' "$C_R" "🚨 $label" "$pct" "$C_X"
  elif [ "$pct" -ge 65 ]; then printf '%b%s %s%%%b' "$C_Y" "⚠️  $label" "$pct" "$C_X"
  else printf '%b%s %s%%%b' "$C_G" "$label" "$pct" "$C_X"; fi
}

linkify() {
  local text=$1 url=$2
  # OSC 8 hyperlink syntax supported by modern terminals
  printf '\033]8;;%s\033\\%s\033]8;;\033\\' "$url" "$text"
}

h5r=$(time_until "$h5r_ts")
wkr=$(time_until "$wkr_ts")
pony=${PONYTAIL_LEVEL:-full}

# Identity: Claude account if readable, else git, else nothing
email=$(jq -r '.oauthAccount.emailAddress // empty' "$HOME/.claude.json" 2>/dev/null)
[ -z "$email" ] && email=$(git config user.email 2>/dev/null)

parts=()

# 1. Identity & Context
parts+=("🐴 ${C_M}${pony}${C_X}")
[ -n "$email" ] && parts+=("${C_C}👤 ${email}${C_X}")

# 2. Workspace
[ -n "$repo" ] && parts+=("📁 $repo")

# 3. Model
[ -n "$model" ] && parts+=("🤖 $model")

# 4. Telemetry & Cost
[ -n "$ctx" ]  && parts+=("$(colorize_pct "$ctx" "🧠 ctx")")

case $cost in
  '' | *[!0-9.]*) ;;
  *) parts+=("$(linkify "💰 \$$(printf '%.2f' "$cost")" "https://console.anthropic.com/settings/billing")") ;;
esac

if [ -n "$h5" ]; then
  h5_str="$(colorize_pct "$h5" "⚡ 5h")"
  [ -n "$h5_str" ] && [ -n "$h5r" ] && h5_str="${h5_str} ${C_D}(⏳ ${h5r})${C_X}"
  [ -n "$h5_str" ] && parts+=("$h5_str")
fi

if [ -n "$wk" ]; then
  wk_str="$(colorize_pct "$wk" "📅 wk")"
  [ -n "$wk_str" ] && [ -n "$wkr" ] && wk_str="${wk_str} ${C_D}(⏳ ${wkr})${C_X}"
  [ -n "$wk_str" ] && parts+=("$wk_str")
fi

# Join array safely
out=""
for part in "${parts[@]}"; do
  if [ -z "$out" ]; then out="$part"
  else out="$out │ $part"; fi
done

printf '%b\n' "$out"
