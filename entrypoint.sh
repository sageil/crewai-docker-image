#!/usr/bin/env bash

set -euo pipefail

YELLOW='\033[0;33m'
RESET='\033[0m'

setup() {
  local project_name="$1"

  if [ ! -d "${project_name}" ]; then
    echo -e "${YELLOW}Creating ${project_name} in ${PWD}${RESET}"
    crewai create crew "${project_name}"
    echo -e "${YELLOW}Changing directory to ${project_name}${RESET}"
    cd "${project_name}" || exit
    echo -e "${YELLOW}Running uv lock${RESET}"
    uv lock
    echo -e "${YELLOW}Running uv sync${RESET}"
    uv sync
  else
    echo -e "${YELLOW}Changing directory to ${project_name}${RESET}"
    cd "${project_name}" || exit
  fi

  echo -e "${YELLOW}Activating environment (if present)${RESET}"
  sv
}

project="${P:-default_crew}"
setup "${project}"
source /shell_venv.sh
if command -v sv >/dev/null; then
  sv
fi
exec "$@"
