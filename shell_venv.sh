#!/usr/bin/env bash
function sv() {
  if [ -d ".venv" ]; then
    # shellcheck disable=SC1091
    source ".venv/bin/activate"
  fi
}
sv
