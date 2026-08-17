# Scope Clarity and CI Coverage Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Separate the `all` flag's three conflated jobs (CI coverage, "install everything", opt-in tools), give the untested default install path CI coverage, and align the project's stated vision with what it actually is.

**Architecture:** Introduce a new `ci` flag that means "exercise every code path cheaply" — distinct from `all`, which keeps meaning "install everything I use." CI workflows switch from `all=true` to a matrix of two runs: default (no flags) and `ci=true`. Task inclusion conditions that currently read `or (all | bool)` gain `or (ci | bool)` only where the code path is worth exercising; heavy GUI/IDE installs stay out of CI. The vision change is documentation-only.

**Tech Stack:** Ansible (ansible-core 2.20), GitHub Actions, ansible-lint (production profile), Nuxt Content docs.

**Spec:** No separate spec document — this plan is the spec. It derives from a repo audit recorded in the "Findings" section below.

## Findings (audit basis)

Measured on 2026-08-17 at commit `7cfb1bf`:

- Default run (no flags) = 8 apt prerequisites + 43 Homebrew CLI = **51 packages**. **Zero CI coverage.**
- `all=true` adds 36 optional CLI tools plus every GUI app, Xcode, Android Studio. **All three CI workflows run only this.**
- `all | bool` appears at **20 task-inclusion sites**.
- `tests/assert_claude_and_uv.yaml` exists but **is not referenced by any workflow** — manual-only.
- 855 of 926 commits are by one author; repo ships author-specific config (`.p10k.zsh`, KDE layout, MX Master 3 remap, Zscaler certs, `terrorsquad/tap/forge-git`).

## Global Constraints

- **ansible-lint `production` profile must pass.** Config at `.ansible-lint`; `docs/` and `.github/` are excluded from linting.
- **All new variables must have a default in `post-installation/defaults/main.yaml`.** An undefined flag referenced in a `when:` breaks the run.
- **`ci` defaults to `false`** and must never be implied by `all`. They are independent.
- **Do not change behaviour of `all=true`** for a human running it locally. Its package set stays identical.
- **Commit messages follow Conventional Commits** (`<type>[scope]: <description>`), short, no body unless necessary.
- **Do not touch** `post-installation/tasks/debian/general_use_software_gui.yaml` or `post-installation/tasks/debian/gui_applications.yaml`. Branch `feat/optional-gui-apps` already rewrites both; editing them here guarantees a merge conflict. See "Out of Scope".

## Out of Scope

**Gating personal-taste GUI apps behind flags is already implemented** on branch `feat/optional-gui-apps` (commits `f23d9bb`, `2c4ddf5`, `120c655`): RescueTime/Zoom/UnifiedRemote moved into `tool_sets.gui_apps_debian_optional`, Viber behind `viber`, Tixati and ModernCSV behind `all`, mailspring removed. Do not re-implement. That branch merges independently.

## File Structure

| File | Responsibility | Change |
|---|---|---|
| `post-installation/defaults/main.yaml` | Flag defaults, tool sets | Add `ci: false` with comment |
| `post-installation/tasks/main.yaml` | Feature-flag plumbing, task coordination | Map `ci` tag; add `ci` to language/GUI conditions |
| `post-installation/tasks/shared/shell_environment.yaml` | Homebrew CLI package list | Optional CLI list also under `ci` |
| `post-installation/tasks/shared/development_tools.yaml` | Docker/DDEV/fonts/VPN inclusion | Add `ci` to docker + ddev only |
| `post-installation/tasks/shared/programming_languages.yaml` | Rust/Go inclusion | Add `ci` to both |
| `tests/assert_flag_semantics.yaml` | **New.** Asserts `ci`/`all` independence and list composition | Create |
| `.github/workflows/ubuntu.yaml` | Ubuntu CI | Matrix: default + ci |
| `.github/workflows/macos.yaml` | macOS CI | Matrix: default + ci |
| `.github/workflows/wsl.yaml` | WSL CI | Switch `all=true` → `ci=true` |
| `.github/workflows/reviewdog.yaml` | Lint CI | Add assertion-test step |
| `docs/content/1.getting_started/4.configuration.md` | Flag documentation | Document `ci`; correct `all` |
| `README.md` | Project framing | Vision correction |
| `docs/content/1.getting_started/1.introduction.md` | Project framing | Vision correction |
| `CLAUDE.md` | Contributor/agent rules | Add tool-inclusion criterion |
| `docs/content/2.features/1.whats_installed.md` | Installed-software catalogue | Remove tools no longer installed |
| `docs/content/1.getting_started/3.usage.md` | Usage examples | Add `ci` context to `all=true` examples |
| `docs/content/3.support/1.faq.md` | FAQ | Fix stale "use flags instead of all" advice |

---

### Task 1: Add the `ci` flag with test coverage

**Files:**
- Modify: `post-installation/defaults/main.yaml` (flag block, around line 22)
- Create: `tests/assert_flag_semantics.yaml`

**Interfaces:**
- Consumes: `tool_sets.modern_cli_homebrew`, `tool_sets.modern_cli_homebrew_optional` (existing keys in `defaults/main.yaml`)
- Produces: variable `ci` (boolean, default `false`), consumed by Tasks 2–4. Test playbook `tests/assert_flag_semantics.yaml`, run by Task 6.

- [ ] **Step 1: Write the failing test**

Create `tests/assert_flag_semantics.yaml`:

```yaml
---
# Flag-semantics regression checks. `ci` and `all` are independent: `ci` exercises
# code paths cheaply, `all` installs everything the author uses. Neither implies
# the other, and the CI package set must stay a subset of the `all` set.
# Run: ansible-playbook tests/assert_flag_semantics.yaml
- name: Assert ci and all flag semantics
  hosts: localhost
  gather_facts: false
  vars_files:
    - ../post-installation/defaults/main.yaml

  tasks:
    - name: Both flags default to false
      ansible.builtin.assert:
        that:
          - not (ci | bool)
          - not (all | bool)
        fail_msg: "ci and all must both default to false"

    - name: The optional CLI list is included under all, and under ci
      vars:
        set_default: "{{ tool_sets.modern_cli_homebrew }}"
        set_all: "{{ tool_sets.modern_cli_homebrew + tool_sets.modern_cli_homebrew_optional }}"
      ansible.builtin.assert:
        that:
          - set_default | length > 0
          - set_all | length > set_default | length
          - set_default | difference(set_all) == []
        fail_msg: "the optional CLI list must extend, not replace, the base list"

    - name: No tool is listed in both the base and optional CLI sets
      ansible.builtin.assert:
        that:
          - tool_sets.modern_cli_homebrew | intersect(tool_sets.modern_cli_homebrew_optional) == []
        fail_msg: >-
          duplicated between base and optional:
          {{ tool_sets.modern_cli_homebrew | intersect(tool_sets.modern_cli_homebrew_optional) }}

    - name: Every tool set is a list with no empty or duplicated entries
      ansible.builtin.assert:
        that:
          - item.value | length == item.value | unique | length
          - item.value | select('==', '') | list == []
        fail_msg: "tool_sets.{{ item.key }} has duplicate or empty entries"
      loop: "{{ tool_sets | dict2items }}"
      loop_control:
        label: "{{ item.key }}"
      when: item.value | type_debug == 'list'
```

- [ ] **Step 2: Run test to verify it fails**

Run: `cd /home/gninkovic/Projects/ansible-post-installation && ansible-playbook tests/assert_flag_semantics.yaml`

Expected: FAIL on the first assertion with an undefined-variable error naming `ci` — the variable does not exist yet.

- [ ] **Step 3: Add the `ci` flag**

In `post-installation/defaults/main.yaml`, directly below the `all: false` line, add:

```yaml
# Exercise every code path cheaply for CI: installs the optional CLI tools and
# the language/container toolchains, but no GUI apps, IDEs, or SDKs. Independent
# of `all` — neither implies the other. Not intended for human use.
ci: false
```

- [ ] **Step 4: Run test to verify it passes**

Run: `cd /home/gninkovic/Projects/ansible-post-installation && ansible-playbook tests/assert_flag_semantics.yaml`

Expected: PASS — every assert task `ok`, zero failed.

- [ ] **Step 5: Verify lint is clean**

Run: `cd /home/gninkovic/Projects/ansible-post-installation && ansible-lint tests/assert_flag_semantics.yaml post-installation/defaults/main.yaml`

Expected: no violations. If `ansible-lint` reports `schema[vars]` on the test file, the cause is `vars_files` pointing outside the playbook dir — that is correct and expected here; only fix real violations.

- [ ] **Step 6: Commit**

```bash
git add post-installation/defaults/main.yaml tests/assert_flag_semantics.yaml
git commit -m "feat: add ci flag distinct from all"
```

---

### Task 2: Wire `ci` into the tag mapper and language toolchains

**Files:**
- Modify: `post-installation/tasks/main.yaml` (the "Enable features based on specific tags" `set_fact`, lines 16-27)
- Modify: `post-installation/tasks/shared/programming_languages.yaml` (both `when:` conditions)

**Interfaces:**
- Consumes: `ci` (from Task 1)
- Produces: `ci=true` now enables Rust and Go installation. Task 5's Ubuntu/macOS `ci` matrix leg depends on this.

- [ ] **Step 1: Add `ci` to the tag mapper**

In `post-installation/tasks/main.yaml`, inside the `set_fact` block that begins `- name: Enable features based on specific tags`, add this line after the `prune_caches:` line and before the closing `when:`:

```yaml
    ci: "{{ true if 'ci' in ansible_run_tags else ci }}"
```

- [ ] **Step 2: Add `ci` to Rust and Go conditions**

In `post-installation/tasks/shared/programming_languages.yaml`, change the Rust condition from:

```yaml
  when: (rust | bool) or (all | bool)
```

to:

```yaml
  when: (rust | bool) or (all | bool) or (ci | bool)
```

And change the Go condition from:

```yaml
  when: (golang | bool) or (all | bool)
```

to:

```yaml
  when: (golang | bool) or (all | bool) or (ci | bool)
```

- [ ] **Step 3: Add `ci` to the programming-languages include gate**

In `post-installation/tasks/main.yaml`, the block named `Programming language environments` currently reads:

```yaml
  when: (rust | bool) or (golang | bool) or (all | bool)
```

Change it to:

```yaml
  when: (rust | bool) or (golang | bool) or (all | bool) or (ci | bool)
```

- [ ] **Step 4: Verify syntax and lint**

Run:
```bash
cd /home/gninkovic/Projects/ansible-post-installation
ansible-playbook --syntax-check ./playbook.yaml
ansible-lint post-installation/tasks/main.yaml post-installation/tasks/shared/programming_languages.yaml
```

Expected: syntax check prints `playbook: ./playbook.yaml` with no error; lint reports no violations.

- [ ] **Step 5: Verify the conditions were edited in all three places**

Do **not** try to verify this with `ansible-playbook --list-tasks`. Ansible does not expand dynamic `include_tasks` at list time, so the task count is identical (21 lines) regardless of flags — this was measured, not assumed. Grep the conditions directly instead:

```bash
cd /home/gninkovic/Projects/ansible-post-installation
grep -c "ci | bool" post-installation/tasks/shared/programming_languages.yaml
grep -c "ci | bool" post-installation/tasks/main.yaml
```

Expected: `2` from `programming_languages.yaml` (Rust and Go), and at least `1` from `main.yaml` (the language include gate). The tag-mapper line assigns `ci:` rather than testing it, so it does not count toward the `main.yaml` total.

- [ ] **Step 6: Commit**

```bash
git add post-installation/tasks/main.yaml post-installation/tasks/shared/programming_languages.yaml
git commit -m "feat: enable language toolchains under ci flag"
```

---

### Task 3: Include optional CLI tools and container tooling under `ci`

**Files:**
- Modify: `post-installation/tasks/shared/shell_environment.yaml` (the `homebrew_cli_packages` `set_fact`, lines 12-19)
- Modify: `post-installation/tasks/shared/development_tools.yaml` (Docker and DDEV conditions)

**Interfaces:**
- Consumes: `ci` (Task 1), `tool_sets.modern_cli_homebrew_optional` (existing)
- Produces: `ci=true` installs the 36 optional CLI tools, Docker, and DDEV. No GUI, no IDEs, no mobile SDKs.

- [ ] **Step 1: Include the optional CLI list under `ci`**

In `post-installation/tasks/shared/shell_environment.yaml`, change:

```yaml
      {{ tool_sets.modern_cli_homebrew
         + (tool_sets.modern_cli_homebrew_optional if all | bool else [])
```

to:

```yaml
      {{ tool_sets.modern_cli_homebrew
         + (tool_sets.modern_cli_homebrew_optional if (all | bool) or (ci | bool) else [])
```

Leave the `cli_macos` and `cli_mobile_macos` lines unchanged — mobile SDKs stay out of CI.

- [ ] **Step 2: Add `ci` to Docker and DDEV**

In `post-installation/tasks/shared/development_tools.yaml`, change the Docker condition from:

```yaml
  when: (docker | default(false) | bool) or (all | bool)
```

to:

```yaml
  when: (docker | default(false) | bool) or (all | bool) or (ci | bool)
```

And the DDEV condition from:

```yaml
  when: (ddev | default(false) | bool) or (all | bool)
```

to:

```yaml
  when: (ddev | default(false) | bool) or (all | bool) or (ci | bool)
```

Leave the **fonts** and **VPN** conditions unchanged. Fonts are a large download with no logic worth exercising; VPN installs vendor packages that are slow and flaky in CI.

- [ ] **Step 3: Verify syntax and lint**

Run:
```bash
cd /home/gninkovic/Projects/ansible-post-installation
ansible-playbook --syntax-check ./playbook.yaml
ansible-lint post-installation/tasks/shared/shell_environment.yaml post-installation/tasks/shared/development_tools.yaml
```

Expected: syntax check passes; lint reports no violations.

- [ ] **Step 4: Verify the package list grows under each flag independently**

Add this task to `tests/assert_flag_semantics.yaml`, before the final loop task:

```yaml
    - name: Each flag independently pulls in the optional CLI list
      vars:
        base: "{{ tool_sets.modern_cli_homebrew }}"
        with_flag: "{{ tool_sets.modern_cli_homebrew + tool_sets.modern_cli_homebrew_optional }}"
      ansible.builtin.assert:
        that:
          - with_flag | length == (base | length) + (tool_sets.modern_cli_homebrew_optional | length)
          - with_flag | unique | length == with_flag | length
        fail_msg: "optional CLI tools overlap the base list, so the flag would not grow it cleanly"
```

Then confirm the real expression behaves correctly under each flag:

```bash
cd /home/gninkovic/Projects/ansible-post-installation
for f in "" "-e ci=true" "-e all=true"; do
  ansible-playbook tests/assert_flag_semantics.yaml $f >/dev/null 2>&1 \
    && echo "flags[$f] assertions pass" || echo "flags[$f] FAILED"
done
```

Expected: all three lines report `assertions pass`.

Baseline for reference, measured at plan time: the CLI package list is **43** entries by default and **79** under either `ci=true` or `all=true`. If your numbers differ, the tool sets changed — that is fine, but the two flags must still produce the *same* count as each other.

- [ ] **Step 5: Confirm GUI apps stay out of the `ci` path**

GUI inclusion lives in `post-installation/tasks/main.yaml` and `debian/gui_applications.yaml`. Verify no GUI gate mentions `ci`:

```bash
cd /home/gninkovic/Projects/ansible-post-installation
grep -rn "ci | bool" post-installation/tasks/ | grep -i gui || echo "no GUI gate references ci (correct)"
```

Expected: prints the "correct" message. A hit here means CI would install GUI apps — the exact cost this plan exists to avoid.

- [ ] **Step 6: Commit**

```bash
git add post-installation/tasks/shared/shell_environment.yaml post-installation/tasks/shared/development_tools.yaml
git commit -m "feat: install optional CLI and container tooling under ci"
```

---

### Task 4: Give the default install path CI coverage

**Files:**
- Modify: `.github/workflows/ubuntu.yaml`
- Modify: `.github/workflows/macos.yaml`

**Interfaces:**
- Consumes: `ci` flag (Tasks 1–3)
- Produces: two-leg CI matrix per OS. Task 6 does not depend on this.

- [ ] **Step 1: Convert Ubuntu to a two-leg matrix**

Replace the entire `jobs:` block of `.github/workflows/ubuntu.yaml` with:

```yaml
jobs:
  ansible:
    runs-on: ubuntu-24.04
    strategy:
      fail-fast: false
      matrix:
        include:
          # The config most users actually get: CLI + shell, no flags.
          - name: default
            flags: ""
          # Every code path worth exercising, minus GUI apps and SDKs.
          - name: ci
            flags: "-e ci=true"
    name: ansible (${{ matrix.name }})
    steps:
      - uses: actions/checkout@v4

      - name: Install Ansible collections
        run: |
          ansible-galaxy collection install -r requirements.yaml

      - name: Run ansible playbook
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        run: |
          cd ${{ github.workspace }}
          ansible-playbook ./playbook.yaml ${{ matrix.flags }} -e github_token=$GITHUB_TOKEN
```

- [ ] **Step 2: Convert macOS to a two-leg matrix**

Replace the entire `jobs:` block of `.github/workflows/macos.yaml` with:

```yaml
jobs:
  ansible:
    runs-on: macos-latest
    strategy:
      fail-fast: false
      matrix:
        include:
          - name: default
            flags: ""
          - name: ci
            flags: "-e ci=true"
    name: ansible (${{ matrix.name }})
    steps:
      - uses: actions/checkout@v4

      - name: Install Ansible
        run: |
          brew install ansible

      - name: Install Ansible collections
        run: |
          ansible-galaxy collection install -r requirements.yaml

      - name: Run ansible playbook
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        run: |
          cd ${{ github.workspace }}
          ansible-playbook ./playbook_macos.yaml ${{ matrix.flags }} -e github_token=$GITHUB_TOKEN
```

- [ ] **Step 3: Switch WSL from `all` to `ci`**

In `.github/workflows/wsl.yaml`, in the final `Run ansible playbook` step, change the line:

```yaml
            -e all=true \
```

to:

```yaml
            -e ci=true \
```

Leave the rest of that workflow alone — WSL stays a single leg because the runner is slow.

- [ ] **Step 4: Validate the workflow YAML parses**

Run:
```bash
cd /home/gninkovic/Projects/ansible-post-installation
python3 -c "
import yaml, sys
for f in ['.github/workflows/ubuntu.yaml', '.github/workflows/macos.yaml', '.github/workflows/wsl.yaml']:
    d = yaml.safe_load(open(f))
    job = d['jobs']['ansible']
    print(f, '->', job.get('strategy', {}).get('matrix', 'single leg'))
"
```

Expected: ubuntu and macos each print a matrix with two `include` entries named `default` and `ci`; wsl prints `single leg`.

- [ ] **Step 5: Confirm no workflow still references `all=true`**

Run: `cd /home/gninkovic/Projects/ansible-post-installation && grep -rn "all=true" .github/workflows/ || echo "clean"`

Expected: prints `clean`. Any remaining hit is a workflow that would still install Android Studio.

- [ ] **Step 6: Commit**

```bash
git add .github/workflows/ubuntu.yaml .github/workflows/macos.yaml .github/workflows/wsl.yaml
git commit -m "ci: test default path and swap all=true for ci=true"
```

---

### Task 5: Run the assertion tests in CI

**Files:**
- Modify: `.github/workflows/reviewdog.yaml`

**Interfaces:**
- Consumes: `tests/assert_flag_semantics.yaml` (Task 1), `tests/assert_claude_and_uv.yaml` (already exists, currently unreferenced by any workflow)
- Produces: nothing downstream.

- [ ] **Step 1: Read the current workflow**

Run: `cd /home/gninkovic/Projects/ansible-post-installation && cat .github/workflows/reviewdog.yaml`

Note the existing job name, its `runs-on`, and its steps. You are adding a **second job** alongside the existing `ansible-lint` job — do not modify or reorder the existing job.

- [ ] **Step 2: Append the assertions job**

Add this job to the `jobs:` mapping in `.github/workflows/reviewdog.yaml`, at the same indentation level as the existing `ansible-lint:` job key:

```yaml
  assertions:
    name: runner / assertions
    runs-on: ubuntu-24.04
    steps:
      - uses: actions/checkout@v4

      - name: Install Ansible
        run: pipx install ansible-core || pip install ansible-core

      - name: Run assertion playbooks
        run: |
          ansible-playbook tests/assert_flag_semantics.yaml
          ansible-playbook tests/assert_claude_and_uv.yaml

      - name: Run Python unit tests
        run: python3 -m unittest discover -s tests -p 'test_*.py' -v
```

- [ ] **Step 3: Verify the workflow parses and has two jobs**

Run:
```bash
cd /home/gninkovic/Projects/ansible-post-installation
python3 -c "
import yaml
d = yaml.safe_load(open('.github/workflows/reviewdog.yaml'))
print('jobs:', list(d['jobs']))
"
```

Expected: prints a list containing both the pre-existing lint job key and `assertions`.

- [ ] **Step 4: Run the same commands locally**

Run:
```bash
cd /home/gninkovic/Projects/ansible-post-installation
ansible-playbook tests/assert_flag_semantics.yaml
ansible-playbook tests/assert_claude_and_uv.yaml
python3 -m unittest discover -s tests -p 'test_*.py' -v
```

Expected: both playbooks report `failed=0`; the unittest run reports `OK`. If the Python test fails on an import path, run it as `python3 -m unittest discover -s tests -t .` and use that form in the workflow instead.

- [ ] **Step 5: Commit**

```bash
git add .github/workflows/reviewdog.yaml
git commit -m "ci: run assertion playbooks and unit tests"
```

---

### Task 6: Document the `ci` flag and correct the vision

**Files:**
- Modify: `docs/content/1.getting_started/4.configuration.md` (the `all` card, ~line 26)
- Modify: `README.md` (Overview + Key Features, lines 7-16)
- Modify: `docs/content/1.getting_started/1.introduction.md` (intro section, lines 9-22)
- Modify: `CLAUDE.md` (add a section before "## Commit Conventions")

**Interfaces:**
- Consumes: the `ci` flag's meaning as defined in Task 1.
- Produces: nothing downstream. Docs-only; `docs/` is excluded from ansible-lint.

- [ ] **Step 1: Document `ci` and sharpen `all` in the configuration docs**

In `docs/content/1.getting_started/4.configuration.md`, replace the `all` card:

```markdown
  ::::card{title="all" icon="i-heroicons-star"}
  Installs **everything** (CLI + GUI + Dev Tools). The full experience.

  :badge[Default: false]{color="gray" variant="soft"} :badge[Type: boolean]{color="gray" variant="outline"}
  ::::
```

with these two cards:

```markdown
  ::::card{title="all" icon="i-heroicons-star"}
  Installs **everything the author uses** — CLI, GUI apps, dev tools, and optional extras. This is a maintainer's full workstation, not a recommended default.

  :badge[Default: false]{color="gray" variant="soft"} :badge[Type: boolean]{color="gray" variant="outline"}
  ::::

  ::::card{title="ci" icon="i-heroicons-beaker"}
  Exercises every code path worth testing — optional CLI tools, Docker, DDEV, and language toolchains — while skipping GUI apps, IDEs, and mobile SDKs. Used by CI; not intended for human use.

  :badge[Default: false]{color="gray" variant="soft"} :badge[Type: boolean]{color="gray" variant="outline"}
  ::::
```

- [ ] **Step 2: Correct the README framing**

In `README.md`, replace the `## Overview` paragraph and the `## Key Features` block (from the line beginning `Griffin is an Ansible playbook designed to automate` through the last `* **Highly Customizable:**` bullet) with:

```markdown
## Overview

Griffin is one developer's Linux and macOS workstation, expressed as an Ansible playbook. It turns a fresh install into a working environment in a single command.

It is published because it is useful to read and fork, not because it is a general-purpose provisioner. The tool choices, dotfiles, and desktop tweaks are opinionated and personal — expect to remove things you don't want.

## Key Features

* **One command, whole machine:** Shell, CLI tooling, languages, containers, and desktop config in a single run.
* **Idempotent:** Safe to re-run. Re-running is the intended way to update an existing machine.
* **Modular:** Feature flags and tags let you install only the parts you want.
* **Cross-platform:** The same role covers Ubuntu, Mint, Debian, WSL, and macOS.

## Forking

The fastest path to your own setup:

1. Edit `tool_sets` in `post-installation/defaults/main.yaml` — that's the single source of truth for what gets installed.
2. Replace the dotfiles in `post-installation/defaults/` with your own.
3. Run `ansible-playbook ./playbook.yaml -K` and iterate.
```

- [ ] **Step 3: Correct the docs introduction**

In `docs/content/1.getting_started/1.introduction.md`, replace the section from `## Tired of Tedious Linux Setups?` through the end of the `Griffin is your all-in-one solution` bullet list (ending with the `- Customize your setup with ease:` line) with:

```markdown
## What Griffin Is

Griffin is one developer's Linux and macOS workstation, expressed as an Ansible playbook. A fresh install becomes a working environment in a single command, and the same command keeps an existing machine up to date.

It is shared because it is useful to read and fork — not as a general-purpose provisioner. The tool choices and dotfiles are opinionated and personal.

## What You Get

- **A configured shell:** Zsh with Powerlevel10k, Antidote plugins, and a curated set of modern CLI tools.
- **Working development tooling:** Git, editors, containers, and language toolchains behind feature flags.
- **Desktop configuration:** KDE and Cinnamon tweaks, fonts, and themes on Linux; Homebrew Casks on macOS.
- **Repeatability:** Every task is idempotent, so re-running updates rather than breaks.

## If You're Forking

Start with `tool_sets` in `post-installation/defaults/main.yaml` — it is the single source of truth for installed software. Swap the dotfiles under `post-installation/defaults/`, then iterate.
```

- [ ] **Step 4: Record the tool-inclusion criterion for future contributors**

In `CLAUDE.md`, insert this section immediately before the `## Commit Conventions` heading:

```markdown
## Tool Inclusion Criterion

This repo is one developer's workstation. The test for keeping a tool is **"do I
actually use it?"**, not "might someone want it". Apply it on every change:

- A tool with no shell-history usage, no alias, no keybinding, and no git-config
  path belongs in a `*_optional` list — or nowhere.
- Prefer removing over adding. A dependency that pulls in a language runtime
  (Python, Node) must earn that weight; check `brew deps <formula>` before adding.
- If apt or mise already provides a tool, do not also install it via Homebrew.

`all=true` means "everything the author uses". `ci=true` means "every code path
worth exercising, cheaply". They are independent — never make one imply the other.
```

- [ ] **Step 5: Verify no stale claims remain**

Run:
```bash
cd /home/gninkovic/Projects/ansible-post-installation
grep -rn "all-in-one solution\|Tired of Tedious" README.md docs/content/ || echo "clean"
grep -rn "ci" docs/content/1.getting_started/4.configuration.md | head -5
```

Expected: the first grep prints `clean`; the second shows the new `ci` card. If the first still prints hits, an edit was missed.

- [ ] **Step 6: Commit**

```bash
git add README.md docs/content/1.getting_started/1.introduction.md docs/content/1.getting_started/4.configuration.md CLAUDE.md
git commit -m "docs: document ci flag and clarify project scope"
```

---

---

### Task 7: Purge removed tools from the documentation site

**Files:**
- Modify: `docs/content/2.features/1.whats_installed.md` (lines 53, 119, 124, and the Communication/Office + System Utilities accordion items)
- Modify: `docs/content/1.getting_started/3.usage.md` (line ~48)
- Modify: `docs/content/3.support/1.faq.md` (line ~30)

**Interfaces:**
- Consumes: nothing. Docs-only, independent of Tasks 1–6 — may be executed in any order relative to them.
- Produces: nothing downstream.

**Context:** The docs site still advertises software the playbook no longer installs. Commit `7cfb1bf` removed `httpie`, `httpstat`, `thefuck`, `visidata`, `pipx`, `git-filter-repo`, `nmap`, `ansible-lint`, `gemini-cli`, and `python3-pip`. Branch `feat/optional-gui-apps` additionally removes Mailspring and moves RescueTime, Zoom, and UnifiedRemote behind `all`. Users read this page to decide whether to run Griffin, so stale entries are a correctness bug.

- [ ] **Step 1: Fix the APT prerequisites line**

In `docs/content/2.features/1.whats_installed.md`, replace line 53:

```markdown
  - **APT** for minimal system prerequisites (build-essential, curl, git, python3-pip, procps, file)
```

with:

```markdown
  - **APT** for minimal system prerequisites (build-essential, curl, git, gpg, procps, file, unzip, zip)
```

- [ ] **Step 2: Fix the CLI tools list**

Replace the `- **CLI Tools:**` line (line ~119) with this line, which drops `thefuck` and adds tools actually in `modern_cli_homebrew`:

```markdown
  - **CLI Tools:** bat, bottom, broot, curl, curlie, duf, dust, fastfetch, fx, gum, htmlq, htop, hyperfine, jq, lnav, make, mdcat, oha, pandoc, peco, ripgrep, sd, shellcheck, tealdeer, tokei, tree, uv, xh, yamlfmt, yazi, yq, zoxide
```

- [ ] **Step 3: Fix the networking tools list**

Replace the `- **Networking Tools:**` line (line ~124), dropping `httpie` and `httpstat`:

```markdown
  - **Networking Tools:** curl, curlie, doggo, gping, openconnect, xh
```

- [ ] **Step 4: Mark optional GUI apps and drop Mailspring**

In the `Communication & Office` accordion item, replace these two lines:

```markdown
  - **Email Client:** Mailspring :badge[Linux]{color="secondary"}
  - **Productivity:** TickTick :badge[macOS], RescueTime :badge[Linux]{color="secondary"}
```

with:

```markdown
  - **Productivity:** TickTick :badge[macOS], RescueTime :badge[Optional]{color="warning"} :badge[Linux]{color="secondary"}
```

In the same item, change the Communication line to mark the opt-in apps:

```markdown
  - **Communication:** Slack, Viber :badge[Optional]{color="warning"}, Zoom :badge[Optional]{color="warning"}, Microsoft Teams :badge[macOS], WhatsApp :badge[macOS]
```

In the `System Utilities & Customization` item, mark Unified Remote optional:

```markdown
  - **Linux Utilities:** Bleachbit, Redshift, Variety, Papirus Theme, Adapta Themes, Unified Remote :badge[Optional]{color="warning"}, input-remapper, libinput-gestures
```

In the `Internet & Networking` item, mark the torrent client optional:

```markdown
  - **Torrent Client:** Tixati :badge[Optional]{color="warning"}
```

Also update the `Communication & Office` card in the upper `card-group` (line ~90) from `**Slack**, **Zoom**, **Teams**, **Tixati**, **ONLYOFFICE**` to:

```markdown
  **Slack**, **Teams**, **ONLYOFFICE**, **VLC**
```

- [ ] **Step 5: Add a note explaining the Optional badge**

Immediately below the `## Detailed Breakdown` heading in the same file, insert:

```markdown
::callout{type="info" icon="i-heroicons-information-circle"}
Items marked :badge[Optional]{color="warning"} are **not** installed by default. They require `-e all=true`, or their own flag (for example `-e viber=true`).
::
```

- [ ] **Step 6: Clarify the `all=true` usage example**

In `docs/content/1.getting_started/3.usage.md`, find the line `ansible-playbook ./playbook.yaml -K -e all=true` (~line 48) and add this callout directly **above** the fenced code block containing it:

```markdown
::callout{type="warning" icon="i-heroicons-exclamation-triangle"}
`all=true` installs **everything the author uses**, including large GUI apps and IDEs. Most people want specific flags instead — see [Configuration](/getting_started/configuration).
::
```

- [ ] **Step 7: Verify no stale tool names remain**

Run:
```bash
cd /home/gninkovic/Projects/ansible-post-installation
grep -rn "thefuck\|httpie\|httpstat\|visidata\|pipx\|git-filter-repo\|Mailspring\|mailspring\|python3-pip" docs/content/ || echo "clean"
```

Expected: prints `clean`. Any hit is a doc line still advertising removed software. Note `ansible-lint` legitimately remains in `docs/content/2.features/2.testing.md` — it is still the project's linter, just no longer installed via Homebrew, so do not remove those references.

- [ ] **Step 8: Commit**

```bash
git add docs/content/2.features/1.whats_installed.md docs/content/1.getting_started/3.usage.md
git commit -m "docs: drop removed tools from installed-software list"
```

---

## Verification

After all tasks, from the repo root:

```bash
ansible-playbook --syntax-check ./playbook.yaml
ansible-playbook --syntax-check ./playbook_macos.yaml
ansible-lint
ansible-playbook tests/assert_flag_semantics.yaml
ansible-playbook tests/assert_claude_and_uv.yaml
python3 -m unittest discover -s tests -p 'test_*.py'
grep -rn "all=true" .github/workflows/ || echo "no workflow uses all=true"
grep -rn "thefuck\|httpie\|httpstat\|visidata\|pipx\|git-filter-repo\|mailspring" docs/content/ || echo "docs clean"
```

All must pass, and the final two greps must report that no workflow uses `all=true` and that the docs advertise no removed tools.

Optionally, build the docs site to confirm the Nuxt Content markdown still parses:

```bash
cd docs && pnpm install --frozen-lockfile && pnpm build
```

This is slow and needs network access. Skip it if the only docs changes were prose inside existing components; the custom `::callout` and `:badge[]` syntax used above already appears elsewhere in these files.

Then confirm the flags behave as specified:

```bash
# ci and all each pull in the optional CLI list; neither implies the other
for f in "" "-e ci=true" "-e all=true"; do
  ansible-playbook tests/assert_flag_semantics.yaml $f >/dev/null 2>&1 \
    && echo "flags[$f] pass" || echo "flags[$f] FAILED"
done

# no GUI gate may reference ci
grep -rn "ci | bool" post-installation/tasks/ | grep -i gui || echo "no GUI gate references ci (correct)"
```

Expected: three `pass` lines, then the "correct" message.

**Do not use `ansible-playbook --list-tasks` to verify flag behaviour.** Dynamic `include_tasks` is not expanded at list time, so the output is byte-identical (21 lines) whether or not flags are set. This was measured during planning; it is a property of Ansible, not a bug in the plan.

## Self-Review Notes

- **Coverage:** Audit items 1 (split `all`/`ci`) → Tasks 1–4; item 2 (default-path CI) → Task 4; item 3 (removal criterion) → Task 6 Step 4; item 5 (README vision) → Task 6; documentation-site drift → Task 7. Item 4 (GUI flag gating) is deliberately Out of Scope — already shipped on `feat/optional-gui-apps`.
- **Task independence:** Tasks 1→2→3 are strictly ordered (each consumes the `ci` flag). Task 4 depends on 1–3. Tasks 5, 6, and 7 are independent of each other and of 2–4, so they can be parallelised or reordered.
- **Type consistency:** the flag is spelled `ci` everywhere — `defaults/main.yaml`, the tag mapper, all `when:` conditions, the workflow `-e ci=true`, and the docs card.
- **Known gap:** Task 4 changes cannot be fully verified locally; GitHub Actions matrix behaviour is confirmed only once the PR runs. The YAML-parse check in Step 4 is the strongest available local signal.
- **Verified during planning:** the `vars_files` relative path and the `type_debug == 'list'` loop filter in Task 1's test both work against the real `defaults/main.yaml` (probe run, `failed=0`); the base and optional CLI lists have no overlap today; and the flag expression yields 43 packages by default vs 79 under either flag.
- **Falsified during planning:** an earlier draft verified flags via `ansible-playbook --list-tasks`. Measurement showed identical output (21 lines) across default/`ci`/`all`, because dynamic includes are not expanded at list time. All such steps were replaced with assertion-playbook runs and greps. Executors should not reintroduce them.
