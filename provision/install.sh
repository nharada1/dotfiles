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

    # Install bare essentials
    sudo apt install -y openssh-server default-jre 

    # Install tmux
    sudo apt install -y tmux

    # Install git
    sudo apt install -y vim git-core
    git config --global user.name "Nate Harada"
    git config --global user.email "nharada1@gmail.com"

    # Install zsh/oh-my-zsh
    sudo apt install -y zsh
    wget --no-check-certificate http://install.ohmyz.sh -O - | sh

    # Install vim/vundle
    sudo apt install -y vim
    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

    # Install dotfiles
    git clone https://github.com/nharada1/dotfiles.git ~/.dotfiles
    bash ~/.dotfiles/script/bootstrap
}

dev() {
    # Build tools
    sudo apt install -y build-essential  

    # Augment tmux with information console
    sudo apt install -y cmake
    git clone https://github.com/thewtex/tmux-mem-cpu-load.git ~/Downloads/tmux-mem-cpu-load
    cd ~/Downloads/tmux-mem-cpu-load
    cmake .
    make
    sudo make install
    cd -
}

ml() {
    # Python3
    sudo apt install -y python3 python3-numpy python3-scipy python3-nose

    # Python2 packages
    sudo apt install -y python-numpy python-scipy python-nose
}

desktop() {
    # Update the sources list and add the GPG keys for the non-free PPAs
    curl https://repogen.simplylinux.ch/txt/artful/sources_64c0fd6a1e3342c3239f00b4d6818507d73a88ec.txt | sudo tee /etc/apt/sources.list
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 6A68F637
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D2C19886

    # Update the whole thing
    sudo apt update
}

# Run install, extras based on command line arguments
bare_minimums
for var in "$@"
do
    $var
done
