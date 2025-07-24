#!/bin/bash

set -e

HOST="$1"
CONFIG_PATH="./x86_64/"

echo "Deploying to ${HOST}..."
echo "-> Syncing configurations..."
rsync -avz --delete --exclude=".git" --exclude='*.swp' --exclude='*~' "${CONFIG_PATH}" "${HOST}:/etc/nixos/"

echo "-> Testing configuration..."
ssh "${HOST}" "nixos-rebuild dry-run"


echo "-> Applying Configuration"
ssh "${HOST}" "nixos-rebuild switch -j 4"

echo "✅ Deployment complete"
