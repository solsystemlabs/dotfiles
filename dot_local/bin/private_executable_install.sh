#!/bin/bash

printf "installing necessary packages\n\n"

apt update && apt upgrade -y
apt install git tmux zsh ripgrep make unzip gcc xclip curl -y

printf "\ninstalling nvim kickstart\n\n"
git clone https://github.com/solsystemlabs/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim


if [[ $(dpkg -l | grep fuse3) ]]; then
  printf "\nfuse installed, installing nvim.appimage\n\n"
  
  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
  chmod u+x nvim.appimage
  
  mkdir -p /opt/nvim
  mv nvim.appimage /opt/nvim/nvim

  printf "\nnvim appimage installed\n\n"
else
  printf "\nfuse not installed, installing extracted nvim.appimage\n\n"

  if [[$( ls -la /usr/bin/nvim | grep "No such file" )]]; then

    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    chmod u+x nvim.appimage

    ./nvim.appimage --appimage-extract
    .squashfs-root/AppRun --version

    sudo mv squashfs-root /
    sudo ln -s /squashfs-root/AppRun /usr/bin/nvim

    sudo rm -rf nvim.appimage
    sudo rm -rf squashfs-root

    printf "\nextracted nvim appimage installed"
  else
    printf "\nnvim already installed\n\n"
  fi
fi
