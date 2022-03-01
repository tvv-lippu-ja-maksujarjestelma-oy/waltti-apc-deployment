#!/bin/bash
#
# Encrypt all files with paths ending in '-secret.yaml'. The resulting files
# will have paths ending in '-secret.enc.yaml'.

set -Eeuo pipefail

SEARCH_PATTERN='-secret.yaml'
REPLACE_PATTERN='-secret.enc.yaml'

find \
  . \
  -type f \
  -name "*${SEARCH_PATTERN}" |
  LC_ALL=C sort |
  while IFS= read -r plaintext_path; do
    encrypted_path="$(
      sed -E "s/${SEARCH_PATTERN}$/${REPLACE_PATTERN}/" \
        <<<"${plaintext_path}"
    )"
    SOPS_AGE_RECIPIENTS="$(cat ./sops-age-recipients)" \
      sops \
      --encrypt \
      --encrypted-regex '^(data)$' \
      "${plaintext_path}" \
      >"${encrypted_path}"
  done
