#!/usr/bin/env bash
# Reclaim disk space from developer tool caches.
#
# Every entry below delegates to the cache's OWN prune command. Nothing here
# rm -rf's a guessed path: the tool that wrote the cache is the only thing that
# reliably knows which parts are still referenced. Adding a `rm -rf ~/.some/cache`
# line to this file is how it becomes dangerous — don't.
#
# Dry run by default. Pass --yes to actually delete.
set -uo pipefail

DRY_RUN=1
[[ "${1:-}" == "--yes" ]] && DRY_RUN=0

if ((DRY_RUN)); then
  echo "DRY RUN — showing what would be pruned. Re-run with --yes to delete."
  echo
fi

have() { command -v "$1" >/dev/null 2>&1; }

before=$(df -k / | awk 'NR==2 {print $4}')

# run <label> <dry-run cmd...> ::: <real cmd...>
run() {
  local label=$1; shift
  local -a dry=() real=()
  local seen=0
  for arg in "$@"; do
    if [[ $arg == ":::" ]]; then seen=1; continue; fi
    if ((seen)); then real+=("$arg"); else dry+=("$arg"); fi
  done

  printf '\n=== %s ===\n' "$label"
  if ((DRY_RUN)); then
    if ((${#dry[@]})); then "${dry[@]}" 2>&1 | tail -5; else echo "(no dry-run mode; would run: ${real[*]})"; fi
  else
    "${real[@]}" 2>&1 | tail -5
  fi
}

have brew   && run "Homebrew"      brew cleanup --prune=all --dry-run ::: brew cleanup --prune=all
have uv     && run "uv"            ::: uv cache prune
have pnpm   && run "pnpm"          ::: pnpm store prune
have npm    && run "npm"           ::: npm cache clean --force
have yarn   && run "yarn"          ::: yarn cache clean
have go     && run "Go modules"    ::: go clean -modcache
# `cargo cache` is a separate crate, not built in — skip unless it's installed
cargo cache --version >/dev/null 2>&1 && run "Cargo" ::: cargo cache --autoclean
have pip3   && run "pip"           ::: pip3 cache purge
# the composer shim exists even without php, and errors out if php is missing
have php && have composer && run "Composer" composer clear-cache --dry-run ::: composer clear-cache
# Deliberately not `-a` (would delete every image not attached to a running
# container) and not `--volumes` (would delete database data). Dangling layers
# and stopped containers only. Run those flags by hand if you mean them.
have docker && run "Docker"        docker system df ::: docker system prune -f
have gradle && run "Gradle daemon" ::: gradle --stop

# Playwright/Puppeteer keep every browser build they ever downloaded; their CLIs
# expose no prune, so this only reports. Delete old versions by hand.
printf '\n=== browser automation caches (manual) ===\n'
du -sh ~/Library/Caches/ms-playwright ~/.cache/puppeteer 2>/dev/null || true

if ((DRY_RUN == 0)); then
  after=$(df -k / | awk 'NR==2 {print $4}')
  printf '\nReclaimed: %s\n' "$(( (after - before) / 1024 )) MB"
fi

cat <<'EOF'

Not covered here: leftover config/support files from apps you have deleted.
Use Pearcleaner (brew install --cask pearcleaner) or AppCleaner for those —
they track which files belong to which bundle, which this script cannot.
EOF
