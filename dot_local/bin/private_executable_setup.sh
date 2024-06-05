#!/bin/bash

if [ ! -d "$HOME/.local/bin/squashfs-root" ]; then
  if [ ! -L "$HOME/.local/bin/nvim" ]; then
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    chmod u+x nvim.appimage

    ./nvim.appimage --appimage-extract
    ./squashfs-root/AppRun --version

    mv squashfs-root $HOME/.local/bin/
    ln -s $HOME/.local/bin/squashfs-root/AppRun $HOME/.local/bin/nvim

    rm $HOME/nvim.appimage

    printf "\n Neovim installed!!"
  fi
else
    printf "\nNeovim already installed\n\n"
fi
