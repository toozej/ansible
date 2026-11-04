#!/usr/bin/env python3
"""Check playbooks without provisioning the controller or managed hosts."""

import os
from pathlib import Path
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[1]


def run(*arguments: str) -> None:
    print("+", *arguments, flush=True)
    subprocess.run(arguments, cwd=ROOT, env=os.environ.copy(), check=True)


def main() -> None:
    os.environ["ANSIBLE_ROLES_PATH"] = str(ROOT / "roles")
    os.environ["ANSIBLE_INJECT_FACT_VARS"] = "false"
    run("ansible-playbook", "--version")
    for directory in ("playbooks", "tests"):
        for playbook in sorted((ROOT / directory).glob("*.yml")):
            run(
                "ansible-playbook",
                "-i", "tests/inventory",
                "--syntax-check",
                str(playbook.relative_to(ROOT)),
            )
    run(
        "ansible-playbook",
        "-i", "tests/inventory",
        "--check",
        "-e", f"ansible_python_interpreter={sys.executable}",
        "tests/compatibility.yml",
    )


if __name__ == "__main__":
    main()
