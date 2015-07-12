#!/usr/bin/env bash
# Install various base systems on ubuntu
# in Bash form until I decide to learn Ansible

bare_minimums () {
    # Basic machine installation, installs bare minimum packages
    # Init sudo
    sudo -v

    # Update packages
    sudo apt-get update -y
    sudo apt-get upgrade -y

    # Install bare essentials
    sudo apt-get install -y openssh-server default-jre 

    # Install tmux
    sudo apt-get install -y tmux

    # Install git
    sudo apt-get install -y vim git-core
    git config --global user.name "Nate Harada"
    git config --global user.email "nharada1@gmail.com"

    # Install zsh/oh-my-zsh
    sudo apt-get install -y zsh
    wget --no-check-certificate http://install.ohmyz.sh -O - | sh

    # Install vim/vundle
    sudo apt-get install -y vim
    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

    # Install dotfiles
    git clone https://github.com/nharada1/dotfiles.git ~/.dotfiles
    bash ~/.dotfiles/script/bootstrap
}

gnome_machine () {
    # Context menu terminal
    sudo apt-get install -y nautilus-open-terminal  
    # Flash install
    sudo apt-get install -y flashplugin-nonfree
}

build_machine () {
    # Build tools
    sudo apt-get install -y build-essential  
    # Augment tmux with information console
    sudo apt-get install -y cmake
    git clone https://github.com/thewtex/tmux-mem-cpu-load.git ~/Downloads/tmux-mem-cpu-load
    cd ~/Downloads/tmux-mem-cpu-load
    cmake .
    make
    sudo make install
    cd -
}

scikit_dev_machine () {
    # Python3
    sudo apt-get install -y python3 python3-numpy python3-scipy python3-nose

    # Python2 packages
    sudo apt-get install -y python-numpy python-scipy python-nose
}

python_dev_machine() {
    # Python3
    sudo apt-get install -y python3 python3-pip
}

michart_machine () {
    # Install VPN
    sudo apt-get install -y network-manager-openconnect-gnome

    # Install Citrix. This will require the icaclient deb package. 
    sudo dpkg -i ./icaclient_13.1.0.285639_amd64.deb
    sudo apt-get install -f -y
    sudo dpkg -i ./icaclient_13.1.0.285639_amd64.deb
}

# Run install, extras based on command line arguments
bare_minimums
for var in "$@"
do
    $var
done
