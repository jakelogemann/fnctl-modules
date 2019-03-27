#!/usr/bin/env bash
set -euo pipefail

# Create a tempfile which is removed on Error or Exit.
f=$(mktemp); 
trap rm "$f" ERR EXIT

# Output the password into the temporary file.
pass show "$1" >"$f"

# Read the output value into the nix runtime.
nix-instantiate --eval -E "builtins.readFile $f"

