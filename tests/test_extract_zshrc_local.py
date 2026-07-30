#!/usr/bin/env python3
"""Checks for extract_zshrc_local.py. Run: python3 tests/test_extract_zshrc_local.py"""

import pathlib
import subprocess
import sys
import tempfile

SCRIPT = pathlib.Path(__file__).resolve().parents[1] / "post-installation/files/extract_zshrc_local.py"
MANAGED = "line1\nline2\nline3\n"


def run(current):
    """Returns the rescued ~/.zshrc.local content, or None if it was not created."""
    with tempfile.TemporaryDirectory() as d:
        home = pathlib.Path(d)
        managed = home / "managed"
        managed.write_text(MANAGED)
        cur = home / ".zshrc"
        if current is not None:
            cur.write_text(current)
        out = home / ".zshrc.local"
        subprocess.run([sys.executable, str(SCRIPT), str(cur), str(managed)], check=True)
        return out.read_text() if out.exists() else None


# The case this exists for: managed prefix plus hand-added tail.
assert run(MANAGED + "export MINE=1\n") == "export MINE=1\n"

# Fresh machine: nothing to rescue, and no stray file left behind.
assert run(None) is None

# Nothing in common: keep the whole file rather than guess.
assert run("export A=1\nexport B=2\n") == "export A=1\nexport B=2\n"

# Already fully managed: empty marker file, so the one-time task stops re-running.
assert run(MANAGED) == ""

# Divergence mid-file must not strip the lines after it.
assert run("line1\nCHANGED\nexport MINE=1\n") == "CHANGED\nexport MINE=1\n"

print("ok")
