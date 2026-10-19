#!/usr/bin/env bash
# Render every overlay under manifests/ (the paths the Argo CD Applications point at),
# validate the output against the Kubernetes API schemas, and enforce immutable images.
#
# Image policy: a container image must be pinned by digest (@sha256:) or an immutable
# sha-<commit> tag. Violations fail the build for the namespaces in
# ENFORCE_PINNED_NAMESPACES and are only reported for the rest. staging and prod join the
# enforced list when GitOps step 6 moves their digests from the live Argo override into Git.
set -Eeuo pipefail
cd "$(dirname "$0")/../.."
export PATH="$PWD/scripts/ci:$PATH" # the ksops stand-in
ENFORCE_PINNED_NAMESPACES="${ENFORCE_PINNED_NAMESPACES:-dev}"
out=$(mktemp -d)
status=0

overlays=$(find manifests -type d -path '*/overlays/*' -exec test -f '{}/kustomization.yaml' ';' -print | sort)

echo "## Render + schema"
for o in $overlays; do
  f="$out/${o//\//_}.yaml"
  if ! kustomize build --enable-alpha-plugins --enable-exec "$o" >"$f" 2>"$f.err"; then
    echo "FAIL render $o"; sed 's/^/  /' "$f.err"; status=1; continue
  fi
  if ! kubeconform -strict -summary -ignore-missing-schemas "$f" >"$f.kc" 2>&1; then
    echo "FAIL schema $o"; sed 's/^/  /' "$f.kc"; status=1; continue
  fi
  echo "ok $o"
done

echo "## Digest format in kustomization.yaml"
if grep -rn --include=kustomization.yaml -E '^\s*digest:' manifests | grep -vE 'digest: sha256:[0-9a-f]{64}$'; then
  echo "FAIL malformed digest(s) above"; status=1
fi

echo "## Immutable images (enforced in: $ENFORCE_PINNED_NAMESPACES)"
for f in "$out"/*.yaml; do
  [ -s "$f" ] || continue
  yq -N '.metadata.namespace as $ns | [.. | select(tag == "!!map" and has("image")) | .image] | .[] | $ns + " " + .' "$f" |
  while read -r ns image; do
    if [[ "$image" == *@sha256:* || "$image" =~ :sha-[0-9a-f]{40}$ ]]; then continue; fi
    if [[ " $ENFORCE_PINNED_NAMESPACES " == *" $ns "* ]]; then
      echo "FAIL mutable image in $ns: $image ($(basename "$f" .yaml))"; echo 1 >"$out/.policy-failed"
    else
      echo "warn mutable image in $ns: $image ($(basename "$f" .yaml))"
    fi
  done
done
[ -f "$out/.policy-failed" ] && status=1

rm -rf "$out"
exit $status
