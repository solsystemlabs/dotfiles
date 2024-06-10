#!/bin/bash

apt update && apt install git -y

if [ ! -f ~/.ssh/id_ed25519.pub ]; then
    echo "Generating ed25519 SSH key pair..."
    ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -N ""
fi

if [ -z "$GITHUB_PAT" ]; then
    echo "Please ensure a valid personal access token is stored in GITHUB_PAT."
    echo "Exiting..."
    exit 0
fi

# Check if GitHub has an SSH key with the title matching hostname
HOSTNAME=$(hostname)
KEY_TITLE="$HOSTNAME $(date +%Y-%m-%d)"
SSH_KEY=$(cat ~/.ssh/id_ed25519.pub)
EXISTING_KEY=$(curl -s -H "Authorization: token $GITHUB_PAT" https://api.github.com/user/keys | grep "$KEY_TITLE")

if [ -z "$EXISTING_KEY" ]; then
    # Add SSH key to GitHub
    curl -X POST -d "{\"title\":\"$KEY_TITLE\",\"key\":\"$SSH_KEY\"}" -H "Authorization: token $GITHUB_PAT" https://api.github.com/user/keys
fi

echo "installing and initializing chezmoi..."

sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply git@github.com:solsystemlabs/dotfiles.git

~/.local/bin/install_packages.sh

~/.local/bin/setup.sh

if [[ ! -z "$(which zsh)" && "$(which zsh)" == "/usr/bin/zsh" ]]; then
  chsh -s $(which zsh)
  echo "changed shell"
fi
