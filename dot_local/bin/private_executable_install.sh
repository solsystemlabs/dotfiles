#!/bin/bash

#read -s -p "Enter password for sudo: " sudoPW

printf "installing necessary packages\n\n"

apt update && apt upgrade -y
apt install vim git tmux zsh ripgrep make unzip gcc xclip curl -y

printf "\ninstalling nvim kickstart\n\n"

USER=$(who am i | awk '{print $1}')

if [ $USER == "root" ]; then
  USERDIR="/root"
else
  USERDIR="/home/$USER"
fi

git clone https://github.com/solsystemlabs/kickstart.nvim.git "${XDG_CONFIG_HOME:-$USERDIR/.config}"/nvim

if [[ $(dpkg -l | grep fuse3) ]]; then
  printf "\nfuse installed, installing nvim.appimage\n\n"
  
  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
  chmod u+x nvim.appimage
  
  mkdir -p /opt/nvim
  mv nvim.appimage /opt/nvim/nvim
  chown -R $USER /opt/nvim
  #mv nvim.appimage "${XDG_CONFIG_HOME:-$USERDIR/.local/bin}"

  printf "\nnvim appimage installed\n\n"
else
  printf "\nfuse not installed, installing extracted nvim.appimage\n\n"

  if [ ! -d "/usr/bin/nvim" ]; then
    if [ ! -L "/usr/bin/nvim" ]; then
      curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
      chmod u+x nvim.appimage

      ./nvim.appimage --appimage-extract
      ./squashfs-root/AppRun --version

      mv squashfs-root /

      mkdir /usr/bin/nvim 
      ln -s /squashfs-root/AppRun /usr/bin/nvim

      rm -rf nvim.appimage
      rm -rf squashfs-root

      printf "\nextracted nvim appimage installed"
    fi
    printf "\nnvim already installed\n\n"
  fi
fi
