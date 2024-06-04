#!/bin/bash

if [[ $(dpkg -l | grep fuse3) ]]; then
  printf "\nfuse installed, installing nvim.appimage\n\n"

  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
  chmod u+x nvim.appimage
  mv nvim.appimage ~/.local/bin/nvim

  printf "\nnvim appimage installed\n\n"
else
  printf "\nfuse not installed, installing extracted nvim.appimage\n\n"

  if [ ! -d "/usr/bin/nvim" ]; then
    if [ ! -L "/usr/bin/nvim" ]; then
      curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
      chmod u+x nvim.appimage

      ./nvim.appimage --appimage-extract
      ./squashfs-root/AppRun --version

      mv squashfs-root ~/.local/bin/
      ln -s ~/.local/bin/squashfs-root/AppRun ~/.local/bin/nvim

      printf "\nextracted nvim appimage installed"
    fi
    printf "\nnvim already installed\n\n"
  fi
fi
