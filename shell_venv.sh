#!/usr/bin/env bash

set -euo pipefail

function sv() {
  if [ -d ".venv" ]; then
    # shellcheck disable=SC1091
    source ".venv/bin/activate"
  fi
}
sv
