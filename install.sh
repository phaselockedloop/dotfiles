#!/usr/bin/env sh

BASEDIR="$(cd "$(dirname "$0")"; pwd)"
PLUGINS_DIR=~/.oh-my-zsh/custom/plugins

# Directories
mkdir -p ~/.tmux/plugins ~/bin ~/.local/share/nvim/site/autoload ~/.config/nvim/colors ~/.cargo

# tpm
git clone --depth 1 https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm &

# oh-my-zsh
$BASEDIR/ohmyzsh.sh --unattended
git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions $PLUGINS_DIR/zsh-autosuggestions &
git clone --depth 1 https://github.com/Aloxaf/fzf-tab $PLUGINS_DIR/fzf-tab &
git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git $PLUGINS_DIR/zsh-syntax-highlighting &
git clone --depth 1 https://github.com/wfxr/forgit.git $PLUGINS_DIR/forgit &

# misc installs
sudo apt-get -y install neovim wget npm htop mold clang

# Dotfiles
ln -sf $BASEDIR/vimrc ~/.vimrc
ln -sf $BASEDIR/zshrc ~/.zshrc
ln -sf $BASEDIR/tmux.conf ~/.tmux.conf
ln -sf $BASEDIR/plug.vim ~/.local/share/nvim/site/autoload/plug.vim
ln -sf $BASEDIR/vimrc ~/.config/nvim/init.vim
ln -sf $BASEDI/koehler2.vim ~/.config/nvim/colors/koehler2.vim

# mold
echo "\n" >> ~/.cargo/config
cat ~/dotfiles/cargo_config >> ~/.cargo/config.toml

# Update git diff
echo "[user]\n    email = andrew.knowles@shopify.com" >> $HOME/.gitconfig
echo "\n    name = Andrew Knowles" >> $HOME/.gitconfig
echo "[include]\n    path = ~/dotfiles/git-delta.conf" >> $HOME/.gitconfig

# Rust
[ -s "$HOME/.rust/bin" ] && ln -s $HOME/.rust/bin $HOME/.cargo/bin
$BASEDIR/rustup.sh -y --default-toolchain stable
nice -n 19 $HOME/.cargo/bin/cargo install bat fd-find lsd ripgrep git-delta vivid difftastic zoxide git-absorb&

# FZF
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all
