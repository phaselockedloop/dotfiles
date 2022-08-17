#!/usr/bin/env sh

BASEDIR="$(cd "$(dirname "$0")"; pwd)";

# tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# oh-my-zsh
$BASEDIR/ohmyzsh.sh --unattended
git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# forgit
mkdir -p ~/bin
git clone --depth 1 https://github.com/wfxr/forgit ~/bin/forgit

# misc installs
sudo apt-get -y update && sudo apt-get -y upgrade && sudo apt-get -y dist-upgrade
sudo apt-get -y install neovim wget npm fzf htop
sudo apt-get -y autoremove

# Dotfiles
ln -sf ~/dotfiles/vimrc ~/.vimrc
ln -sf ~/dotfiles/zshrc ~/.zshrc
ln -sf ~/dotfiles/tmux.conf ~/.tmux.conf

# Neovim

mkdir -p ~/.local/share/nvim/site/autoload
mkdir -p ~/.config/nvim/colors

ln -sf ~/dotfiles/plug.vim ~/.local/share/nvim/site/autoload/plug.vim
ln -sf ~/dotfiles/vimrc ~/.config/nvim/init.vim
ln -sf ~/dotfiles/vimrc ~/.vimrc
ln -sf ~/dotfiles/koehler2.vim ~/.config/nvim/colors/koehler2.vim

# scm puff
mkdir -p ~/bin
cd ~/bin
wget https://github.com/mroth/scmpuff/releases/download/v0.3.0/scmpuff_0.3.0_linux_x64.tar.gz
tar xzvf scmpuff_0.3.0_linux_x64.tar.gz &

# tldr
sudo npm install -g tldr &

# Update git diff
echo "[include]\n    path = ~/dotfiles/git-delta.conf" >> $HOME/.gitconfig

# Rust
[ -s "$HOME/.rust" ] && ln -s $HOME/.rust $HOME/.cargo
$HOME/.cargo/bin/rustup update stable
$HOME/.cargo/bin/cargo install bat fd-find lsd ripgrep git-delta &
