#!/usr/bin/env sh

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# misc installs
sudo apt-get -y update && sudo apt-get -y upgrade && sudo apt-get -y dist-upgrade
sudo apt-get -y install neovim wget npm fzf htop
sudo apt-get -y autoremove

# Dotfiles
ln -sf ~/dotfiles/vimrc ~/.vimrc
ln -sf ~/dotfiles/zshrc ~/.zshrc
ln -sf ~/dotfiles/tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/gitconfig ~/.gitconfig

# Neovim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
mkdir -p ~/.config/nvim/colors
ln -sf ~/dotfiles/vimrc ~/.config/nvim/init.vim
ln -sf ~/dotfiles/vimrc ~/.vimrc
ln -sf ~/dotfiles/koehler2.vim ~/.config/nvim/colors/koehler2.vim

# scm puff
mkdir -p ~/bin
cd ~/bin
wget https://github.com/mroth/scmpuff/releases/download/v0.3.0/scmpuff_0.3.0_linux_x64.tar.gz
tar xzvf scmpuff_0.3.0_linux_x64.tar.gz

# tldr
sudo npm install -g tldr

# purer
git clone https://github.com/DFurnes/purer ~/purer
ln -s ~/purer/pure.zsh ~/purer/purer.plugin.zsh 
ln -s ~/purer/pure.zsh ~/purer/prompt_purer_setup
ln -s ~/purer/async.zsh ~/purer/async

# Rust
curl https://sh.rustup.rs -sSf | sh -s -- -y
$HOME/.cargo/bin/cargo install sccache
echo "[build]" >> $HOME/.cargo/config
SCCACHE_PATH=$HOME/.cargo/bin/sccache
echo "rustc-wrapper = \"$SCCACHE_PATH\"" >> $HOME/.cargo/config
$HOME/.cargo/bin/cargo install bat fd-find lsd ripgrep
$HOME/.cargo/bin/cargo install broot topgrade xsv git-delta just exa cargo-update dijo
