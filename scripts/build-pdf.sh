#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPOSITORY_ROOT="$(cd -- "${SCRIPT_DIR}/.." && pwd)"
INPUT_FILE="${REPOSITORY_ROOT}/README.md"
OUTPUT_FILE="${1:-${REPOSITORY_ROOT}/report.pdf}"
TEMP_DIR="$(mktemp -d)"
HTML_FILE="${TEMP_DIR}/report.html"

cleanup() {
  rm -rf -- "${TEMP_DIR}"
}

trap cleanup EXIT

if ! command -v pandoc >/dev/null 2>&1; then
  printf 'Error: pandoc is not installed or is not available in PATH.\n' >&2
  exit 1
fi

if ! command -v weasyprint >/dev/null 2>&1; then
  printf 'Error: weasyprint is not installed or is not available in PATH.\n' >&2
  exit 1
fi

if [[ ! -f "${INPUT_FILE}" ]]; then
  printf 'Error: report file not found: %s\n' "${INPUT_FILE}" >&2
  exit 1
fi

mkdir -p "$(dirname -- "${OUTPUT_FILE}")"

pandoc \
  --from=gfm \
  --to=html5 \
  --standalone \
  --css="${SCRIPT_DIR}/report.css" \
  --resource-path="${REPOSITORY_ROOT}" \
  "${INPUT_FILE}" \
  --output="${HTML_FILE}"

weasyprint \
  --base-url="${REPOSITORY_ROOT}/" \
  "${HTML_FILE}" \
  "${OUTPUT_FILE}"

printf 'PDF created: %s\n' "${OUTPUT_FILE}"
