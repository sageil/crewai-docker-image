#!/usr/bin/env bash
YELLOW='\033[0;33m'
RESET='\033[0m'
newcrew() {
  if [ -n "$1" ]; then
    PROJECT="$1"
    deactivate
    poetry config virtualenvs.in-project true
    echo -e "${YELLOW} Creating $PROJECT${RESET}"
    crewai create "$PROJECT"
    cd $PWD/$PROJECT
    poetry lock
    poetry install
    poetry shell
    source $(poetry env info -p)/bin/activate

  else
    echo -e "${YELLOW}Please provide a project name${RESET}"
  fi
}
