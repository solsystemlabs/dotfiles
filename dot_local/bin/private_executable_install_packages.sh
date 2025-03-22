#!/bin/bash

printf "installing necessary packages\n\n"

apt update && apt upgrade -y
apt install vim fish eza git tmux zsh ripgrep make unzip gcc xclip curl -y

