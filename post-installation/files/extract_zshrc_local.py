#!/usr/bin/env python3
"""Split a pre-existing ~/.zshrc into managed prefix + local tail.

The playbook used to overwrite ~/.zshrc outright, so on an already-provisioned
machine the file is [some older copy of defaults/.zshrc] + [whatever the user
appended]. This recovers that tail into <zshrc>.local before the overwrite,
which defaults/.zshrc now sources.

Bias is toward keeping too much: if the files diverge on line 1, the whole
current .zshrc is treated as local. Duplicated config is recoverable, a wiped
PATH export is not.

ponytail: longest common line prefix, not a real 3-way merge. Only runs once
(guarded by `creates:` on the .local file) - after that the marker exists and
edits go in it directly.

Usage: extract_zshrc_local.py <current-zshrc> <shipped-zshrc>
Writes <current-zshrc>.local
"""

import pathlib
import sys


def local_tail(current, managed):
    """Lines of `current` past the point it stops matching `managed`."""
    common = 0
    for mine, theirs in zip(current, managed):
        if mine != theirs:
            break
        common += 1
    return current[common:]


def main():
    current = pathlib.Path(sys.argv[1]).expanduser()
    managed = pathlib.Path(sys.argv[2]).expanduser()

    if not current.exists():
        return  # fresh machine, nothing to preserve

    # Derived, never passed in: this only ever writes alongside the file it read.
    out = current.with_name(current.name + ".local")

    tail = local_tail(
        current.read_text().splitlines(keepends=True),
        managed.read_text().splitlines(keepends=True) if managed.exists() else [],
    )
    body = "".join(tail).strip("\n")
    out.write_text(body + "\n" if body else "")
    print(f"preserved {len(tail)} local line(s) into {out}")


if __name__ == "__main__":
    main()
