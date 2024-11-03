#!/usr/bin/env bash

YELLOW='\033[0;33m'
RESET='\033[0m' #Reset

setup() {
  if [ ! -d "$P" ]; then

    echo -e "${YELLOW}Creating $P in $PWD${RESET}"
    crewai create crew "$P"
    echo -e "${YELLOW}Changing directory to $P${RESET}"
    cd "$P" || exit
    echo -e "${YELLOW}Running uv lock${RESET}"
    uv lock
    echo -e "${YELLOW}Installing dependencies${RESET}"
    uv sync
  else
    echo -e "${YELLOW}Changing directory to $P${RESET}"
    cd "$P" || exit
  fi
echo -e "${YELLOW}Activating Environment${RESET}"

}

if [ -n "$P" ]; then
  echo -e "${YELLOW}Setting up $P${RESET}"
  setup
fi
exec "$@"
