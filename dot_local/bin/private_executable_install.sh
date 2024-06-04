#!/bin/bash

#read -s -p "Enter password for sudo: " sudoPW

printf "installing necessary packages\n\n"

#echo $sudoPW | sudo -S apt update 
#echo $sudoPW | sudo -S apt upgrade -y
#echo $sudoPW | sudo -S apt install vim git tmux zsh ripgrep make unzip gcc xclip curl -y

apt update && apt upgrade -y
apt install vim git tmux zsh ripgrep make unzip gcc xclip curl -y

printf "\ninstalling nvim kickstart\n\n"

USER=$(who am i | awk '{print $1}')

if [ $USER == "root" ]; then
  USERDIR="/root"
else
  USERDIR="/home/$USER"
fi

git clone https://github.com/solsystemlabs/kickstart.nvim.git "${USERDIR/.config}"/nvim

if [[ $(dpkg -l | grep fuse3) ]]; then
  printf "\nfuse installed, installing nvim.appimage\n\n"
  
  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
  chmod u+x nvim.appimage
  
 # echo $sudoPW | sudo -S mv nvim.appimage /opt/nvim/nvim
   mv nvim.appimage /opt/nvim/nvim
   mkdir -p /opt/nvim
 # echo $sudoPW | sudo -S mkdir -p /opt/nvim

  printf "\nnvim appimage installed\n\n"
else
  printf "\nfuse not installed, installing extracted nvim.appimage\n\n"


  if [ ! -d "/usr/bin/nvim" ]; then
    if [ ! -L "/usr/bin/nvim" ]; then
      curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
      chmod u+x nvim.appimage

      ./nvim.appimage --appimage-extract
      ./squashfs-root/AppRun --version

  #    echo $sudoPW | sudo -S mv squashfs-root /

  #    echo $sudoPW | sudo -S mkdir /usr/bin/nvim 
  #    echo $sudoPW | sudo -S ln -s /squashfs-root/AppRun /usr/bin/nvim

  #    echo $sudoPW | sudo -S rm -rf nvim.appimage
  #    echo $sudoPW | sudo -S rm -rf squashfs-root

      printf "\nextracted nvim appimage installed"
    fi
    printf "\nnvim already installed\n\n"
  fi
fi
