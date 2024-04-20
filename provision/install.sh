#!/usr/bin/env bash
# Install various base systems on ubuntu
# in Bash form until I decide to learn Ansible

bare_minimums () {
    # Basic machine installation, installs bare minimum packages
    # Init sudo
    sudo -v

    # Update packages
    sudo apt update -y
    sudo apt upgrade -y

    # Install other packages for management
    sudo apt install -y exfat-fuse exfat-utils

    # Install other utlities
    sudo apt install -y tree ncdu wget awscli

    # Install tmux
    sudo apt install -y tmux

    # Install git
    sudo apt install -y vim git-core
    git config --global user.name "Nate Harada"
    git config --global user.email "nharada1@gmail.com"

    # Install zsh/oh-my-zsh
    sudo apt install -y zsh
    wget --no-check-certificate http://install.ohmyz.sh -O - | sh

    # Install dotfiles
    git clone https://github.com/nharada1/dotfiles.git ~/.dotfiles
    bash ~/.dotfiles/script/bootstrap

    # Augment tmux with information console
    sudo apt install -y cmake
    git clone https://github.com/thewtex/tmux-mem-cpu-load.git ~/Downloads/tmux-mem-cpu-load
    cd ~/Downloads/tmux-mem-cpu-load
    cmake .
    make
    sudo make install
    cd -

}

dev() {
    # Build tools
    sudo apt install -y build-essential  
}

# Run install, extras based on command line arguments
bare_minimums
for var in "$@"
do
    $var
done
