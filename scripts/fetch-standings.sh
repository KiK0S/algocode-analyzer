#!/usr/bin/env bash
set -euo pipefail

OUT_DIR=${1:-standings_data}
mkdir -p "${OUT_DIR}"
TARGET="${OUT_DIR%/}/bp_fall_2025.json"
TMP_FILE=$(mktemp)

cleanup() {
  rm -f "$TMP_FILE"
}
trap cleanup EXIT

echo "Fetching standings into ${TARGET}"
if curl -fsSL "https://algocode.ru/standings_data/bp_fall_2025" -o "$TMP_FILE"; then
  mv "$TMP_FILE" "$TARGET"
  echo "Saved latest standings snapshot." 
else
  echo "Failed to download standings." >&2
  exit 1
fi
