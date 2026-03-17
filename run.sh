#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(pwd)"

FLAVOR="${1:-min}"

if [[ $FLAVOR != "dev" && $FLAVOR != "min" ]]; then
  echo "Error: Invalid flavor provided ('$1')."
  echo "Usage: $0 [dev|min]"
  exit 1
fi

nix build "#${FLAVOR}"

RUNTIME_DIR="${REPO_DIR}/.runtime/${FLAVOR}"
export XDG_CONFIG_HOME="${RUNTIME_DIR}"
export XDG_DATA_HOME="${RUNTIME_DIR}/data"
export XDG_STATE_HOME="${RUNTIME_DIR}/state"
export XDG_CACHE_HOME="${RUNTIME_DIR}/cache"

mkdir -p "${XDG_DATA_HOME}" "${XDG_STATE_HOME}" "${XDG_CACHE_HOME}"
trap 'rm -rf "${RUNTIME_DIR}"' EXIT

./result/bin/"synnax-${FLAVOR}"
