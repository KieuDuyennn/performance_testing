#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUT_DIR="${ROOT_DIR}/load-tests/reports/results"
mkdir -p "${OUT_DIR}"

BASE_URL="${BASE_URL:-http://localhost:3000}"

k6 run \
  "${ROOT_DIR}/load-tests/k6/baseline.js" \
  --summary-export "${OUT_DIR}/baseline-summary.json" \
  -e BASE_URL="${BASE_URL}"
