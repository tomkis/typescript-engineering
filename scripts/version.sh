#!/usr/bin/env bash
# Prints the current tseng plugin version from plugin.json.
# Usage: bash scripts/version.sh
#
# Skills embed this version in every review record so that
# each checklist is traceable to the architecture revision
# that produced it.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PLUGIN_JSON="$SCRIPT_DIR/../.claude-plugin/plugin.json"

if [ ! -f "$PLUGIN_JSON" ]; then
  echo "ERROR: plugin.json not found at $PLUGIN_JSON" >&2
  exit 1
fi

# Extract version — works with grep+sed so we don't require jq.
VERSION=$(grep '"version"' "$PLUGIN_JSON" | sed 's/.*"version"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/')

if [ -z "$VERSION" ]; then
  echo "ERROR: could not extract version from $PLUGIN_JSON" >&2
  exit 1
fi

echo "$VERSION"
