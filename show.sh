#!/usr/bin/env bash
set -euo pipefail

FLAVOR="${1:-min}"

if [[ $FLAVOR != "dev" && $FLAVOR != "min" ]]; then
  echo "Error: Invalid flavor provided ('$1')."
  echo "Usage: $0 [dev|min]"
  exit 1
fi

nix build "#print-${FLAVOR}"

./result/bin/nvf-print-config | stylua - | bat --language lua --style plain
