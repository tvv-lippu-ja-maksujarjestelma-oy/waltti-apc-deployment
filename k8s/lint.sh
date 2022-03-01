#!/bin/bash

set -Eeuo pipefail

[ "$#" -ne 1 ] && {
  echo "Usage: $(basename "$0") KUSTOMIZE_OVERLAY_DIR" 1>&2
  exit 1
}

KUSTOMIZE_OVERLAY_DIR="$1"

# Expect file extension 'yaml'.
# Accept yamllint errors.
yamllint ./base/*.yaml || true
(
  find "${KUSTOMIZE_OVERLAY_DIR}" -type f -iname '*.yaml' -print0 |
    xargs -0 yamllint
) || true
./run-kubeval.sh "${KUSTOMIZE_OVERLAY_DIR}"
./run-polaris.sh "${KUSTOMIZE_OVERLAY_DIR}"
./run-kube-score.sh "${KUSTOMIZE_OVERLAY_DIR}"
