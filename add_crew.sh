#!/usr/bin/env bash
YELLOW='\033[0;33m'
RESET='\033[0m'
newcrew() {
  if [ -n "$1" ]; then
    PROJECT="$1"
    deactivate
    echo -e "${YELLOW} Creating $PROJECT${RESET}"
    crewai create crew "$PROJECT"
    cd $PWD/$PROJECT
    uv lock
    uv sync
    uv venv
    chmod +x .venv/bin/activate && source .venv/bin/activate

  else
    echo -e "${YELLOW}Please provide a project name${RESET}"
  fi
}
