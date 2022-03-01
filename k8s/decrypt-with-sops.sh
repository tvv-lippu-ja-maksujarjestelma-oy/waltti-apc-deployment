#!/bin/bash
#
# Decrypt all files with paths ending in '-secret.end.yaml'. The resulting files
# will have paths ending in '-secret.yaml'.
#
# The script expects the private key for age to be available for sops in
# "${XDG_CONFIG_HOME}/sops/age/keys.txt".

set -Eeuo pipefail

SEARCH_PATTERN='-secret.enc.yaml'
REPLACE_PATTERN='-secret.yaml'

find \
  . \
  -type f \
  -name "*${SEARCH_PATTERN}" |
  LC_ALL=C sort |
  while IFS= read -r encrypted_path; do
    plaintext_path="$(
      sed -E "s/${SEARCH_PATTERN}$/${REPLACE_PATTERN}/" \
        <<<"${encrypted_path}"
    )"
    sops \
      --decrypt \
      "${encrypted_path}" \
      >"${plaintext_path}"
  done
