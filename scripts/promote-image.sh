#!/usr/bin/env bash
# Promote a service's image digest from one overlay to another, e.g.
#   scripts/promote-image.sh manifests/anonymizer/overlays/dev manifests/anonymizer/overlays/staging
#   scripts/promote-image.sh manifests/anonymizer/overlays/staging manifests/anonymizer/overlays/prod
# Then commit and open a pull request; merging it is the promotion. dev pins are written
# by Argo CD Image Updater; staging and prod only ever change through this path.
set -Eeuo pipefail
[ "$#" -eq 2 ] || { echo "Usage: $(basename "$0") FROM_OVERLAY_DIR TO_OVERLAY_DIR" >&2; exit 1; }
from="$1/kustomization.yaml"; to="$2/kustomization.yaml"
name=$(yq -r '.images[0].name' "$from"); digest=$(yq -r '.images[0].digest' "$from")
[[ "$digest" =~ ^sha256:[0-9a-f]{64}$ ]] || { echo "no digest pin in $from" >&2; exit 1; }
[ "$(yq -r '.images[0].name' "$to")" = "$name" ] || { echo "$to pins $(yq -r '.images[0].name' "$to"), not $name" >&2; exit 1; }
yq -i ".images[0].digest = \"$digest\"" "$to"
echo "$to: $name -> $digest"
