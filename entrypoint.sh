#!/usr/bin/env bash

YELLOW='\033[0;33m'
RESET='\033[0m' #Reset

setup() {
  if [ ! -d "$P" ]; then
    poetry config virtualenvs.in-project true
    echo -e "${YELLOW}Creating $P in $PWD${RESET}"
    crewai create "$P"
    echo -e "${YELLOW}Changing directory to $P${RESET}"
    cd "$P" || exit
    echo -e "${YELLOW}Runnning poetry lock${RESET}"
    poetry lock
    echo -e "${YELLOW}Installing dependencies${RESET}"
    poetry install
    poetry shell
  else
    echo -e "${YELLOW}Changing directory to $P${RESET}"
    cd "$P" || exit
  fi
}

if [ -n "$P" ]; then
  echo -e "${YELLOW}Setting up $P${RESET}"
  setup
fi
exec "$@"
