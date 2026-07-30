#!/usr/bin/env bash
# ponytail status line: mode + session/usage + reset times + email
# ponytail: git email as the identity source; swap to /account if CC ever exposes it on stdin
in=$(cat)

j() { printf '%s' "$in" | jq -r "$1 // empty" 2>/dev/null; }
ago() { # unix-epoch -> "3h12m" until reset
  local t=$1 now d h m
  [ -z "$t" ] && return
  now=$(date +%s); d=$((t - now)); [ "$d" -lt 0 ] && d=0
  h=$((d/3600)); m=$(((d%3600)/60)); printf '%dh%02dm' "$h" "$m"
}

model=$(j '.model.display_name')
cost=$(j '.cost.total_cost_usd')
ctx=$(j '.context_window.used_percentage')
h5=$(j '.rate_limits.five_hour.used_percentage')
h5r=$(ago "$(j '.rate_limits.five_hour.resets_at')")
wk=$(j '.rate_limits.seven_day.used_percentage')
wkr=$(ago "$(j '.rate_limits.seven_day.resets_at')")
email=$(git config user.email 2>/dev/null)
pony=${PONYTAIL_LEVEL:-full}

out="🐴 ${pony}"
[ -n "$model" ] && out="$out │ $model"
[ -n "$ctx" ] && out="$out │ ctx ${ctx}%"
[ -n "$cost" ] && out="$out │ \$$(printf '%.2f' "$cost")"
[ -n "$h5" ] && out="$out │ 5h ${h5%.*}%${h5r:+ (${h5r})}"
[ -n "$wk" ] && out="$out │ wk ${wk%.*}%${wkr:+ (${wkr})}"
[ -n "$email" ] && out="$out │ $email"
printf '%s' "$out"
