#!/usr/bin/env python3
"""Split a pre-existing ~/.zshrc into managed prefix + local tail.

The playbook used to overwrite ~/.zshrc outright, so on an already-provisioned
machine the file is [some older copy of defaults/.zshrc] + [whatever the user
appended]. This recovers that tail into ~/.zshrc.local before the overwrite,
which defaults/.zshrc now sources.

Bias is toward keeping too much: if the files diverge on line 1, the whole
current .zshrc is treated as local. Duplicated config is recoverable, a wiped
PATH export is not.

ponytail: longest common line prefix, not a real 3-way merge. Only runs once
(guarded by `creates:` on ~/.zshrc.local) - after that the marker file exists
and edits go in it directly.
"""

import pathlib
import sys


def main():
    current, managed, out = (pathlib.Path(p).expanduser() for p in sys.argv[1:4])

    if not current.exists():
        return  # fresh machine, nothing to preserve

    cur = current.read_text().splitlines(keepends=True)
    mgd = managed.read_text().splitlines(keepends=True) if managed.exists() else []

    i = 0
    while i < len(cur) and i < len(mgd) and cur[i] == mgd[i]:
        i += 1

    tail = "".join(cur[i:]).strip("\n")
    out.write_text(tail + "\n" if tail else "")
    print(f"preserved {len(cur) - i} local line(s) into {out}")


if __name__ == "__main__":
    main()
