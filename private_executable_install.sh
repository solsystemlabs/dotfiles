#!/bin/bash

if [[ $(dpkg -l | grep fuse3) ]]; then
  echo "fuse installed, installing nvim.appimage"
  
  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
  chmod u+x nvim.appimage
  mkdir -p /opt/nvim
  mv nvim.appimage /opt/nvim/nvim
  
  echo "\nnvim appimage installed"
else
  echo "fuse not installed, installing extracted nvim.appimage"
  
  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
  chmod u+x nvim.appimage
  
  ./nvim.appimage --appimage-extract
  .squashfs-root/AppRun --version

  sudo mv squashfs-root /
  sudo ln -s /squashfs-root/AppRun /usr/bin/nvim
  
  echo "\nextracted nvim appimage installed"
fi
