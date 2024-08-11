#!/usr/bin/env bash

build_neovim() {
  mkdir -p /nvimbuild/
  git clone https://github.com/neovim/neovim.git /nvimbuild/
  #cd .. && mkdir build && cd build
  cd /nvimbuild || exit
  git checkout stable && make -j4 && make install

}

build_neovim
