#!/usr/bin/env bash
# Prints the current tseng version from the VERSION file.
# Usage: bash scripts/version.sh
#
# Skills embed this version in every review record so that
# each checklist is traceable to the architecture revision
# that produced it.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
VERSION_FILE="$SCRIPT_DIR/../VERSION"

if [ ! -f "$VERSION_FILE" ]; then
  echo "ERROR: VERSION file not found at $VERSION_FILE" >&2
  exit 1
fi

VERSION=$(tr -d '[:space:]' < "$VERSION_FILE")

if [ -z "$VERSION" ]; then
  echo "ERROR: VERSION file is empty" >&2
  exit 1
fi

echo "$VERSION"
