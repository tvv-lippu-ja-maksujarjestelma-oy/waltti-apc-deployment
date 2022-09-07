#!/bin/bash

set -Eeuo pipefail

[ "$#" -ne 1 ] && {
  echo "Usage: $(basename "$0") KUSTOMIZE_OVERLAY_DIR" 1>&2
  exit 1
}

KUSTOMIZE_OVERLAY_DIR="$1"

echo '*** Run yamllint while accepting errors'
# Expect file extension 'yaml'.
# Accept yamllint errors.
yamllint ./base/*.yaml || true
(
  find "${KUSTOMIZE_OVERLAY_DIR}" -type f -iname '*.yaml' -print0 |
    xargs -0 yamllint
) || true
echo '*** Run kubeval'
./run-kubeval.sh "${KUSTOMIZE_OVERLAY_DIR}"
echo '*** Run polaris'
./run-polaris.sh "${KUSTOMIZE_OVERLAY_DIR}"
echo '*** Run kube-score'
./run-kube-score.sh "${KUSTOMIZE_OVERLAY_DIR}"
# kube-linter is not there yet.
#echo '*** Run kube-linter'
#./run-kube-linter.sh "${KUSTOMIZE_OVERLAY_DIR}"
