#!/bin/bash

set -Eeuo pipefail

[ "$#" -ne 1 ] && {
  echo "Usage: $(basename "$0") KUSTOMIZE_OVERLAY_DIR" 1>&2
  exit 1
}

KUSTOMIZE_OVERLAY_DIR="$1"

./kustomize-build.sh "${KUSTOMIZE_OVERLAY_DIR}" |
  kubeval --ignore-missing-schemas
