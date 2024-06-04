#!/bin/bash

if [[ $(dpkg -l | grep fuse3) ]]; then
  echo "fuse installed, installing nvim.appimage"
  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
  chmod u+x nvim.appimage
else
  echo "not installed"
fi
