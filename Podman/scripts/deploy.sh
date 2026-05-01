#!/usr/bin/env bash

#Use This script to deploy quadlets from the repo to the user's systemd directory and restart the affected services.
set -e

REPO="$HOME/Git_Repos/Podman"
QUADLET_SRC="$REPO/quadlets_rootless"
QUADLET_DST="$HOME/.config/containers/systemd"

echo "== Updating repo =="
cd "$REPO"
git pull --ff-only

echo "== Ensuring quadlet folder exists =="
mkdir -p "$QUADLET_DST"

echo "== Copying files =="
rsync -av --delete \
    --include="*.container" \
    --include="*.pod" \
    --include="*.volume" \
    --exclude="*" \
    "$QUADLET_SRC"/ "$QUADLET_DST"/

echo "== Setting permissions =="
chmod 644 "$QUADLET_DST"/* || true

echo "== Reloading systemd =="
systemctl --user daemon-reload

echo "== Recreating generators =="
#systemctl --user restart podman-system-generator.service || true
echo "== Generators handled by daemon-reload =="


echo "== Restarting updated services =="
for file in "$QUADLET_DST"/*.container "$QUADLET_DST"/*.pod; do
    [ -e "$file" ] || continue
    name=$(basename "$file")
    service="${name%.*}.service"
    echo "Restarting $service"
    systemctl --user restart "$service" || true
done

echo "== Done =="