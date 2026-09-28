#!/usr/bin/env bash
# Deploy script for jasonwoodardresearch (Firebase Hosting)
#
# Usage:
#   ./deploy.sh                       # deploys the default target below
#   ./deploy.sh "commit message"      # also commits+pushes pending changes first
#   ./deploy.sh "message" landline    # deploy a specific hosting target
#
# Run from your machine (repo root) — this session can't reach your
# Firebase project directly.

set -euo pipefail
cd "$(dirname "$0")"

MSG="${1:-}"
TARGET="${2:-landline}"   # change default, or pass a target name as $2

if [[ -n "$MSG" ]]; then
  echo "==> Staging and committing"
  git add -A
  if ! git diff --cached --quiet; then
    git commit -m "$MSG"
    git push
  else
    echo "    nothing staged, skipping commit"
  fi
fi

echo "==> Deploying hosting target: $TARGET"
firebase deploy --only "hosting:$TARGET"

echo "==> Done"