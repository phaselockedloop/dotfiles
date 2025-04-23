#!/usr/bin/env bash

set -euo pipefail

BASEDIR="$(cd "$(dirname "$0")" && pwd)"
PLUGINS_DIR="${HOME}/.oh-my-zsh/custom/plugins"

# Function to install packages
install_packages() {
    sudo apt-get update
    sudo apt-get install -y neovim wget npm htop mold clang
}

# Function to clone repositories
clone_repo() {
    git clone --depth 1 "$1" "$2" &
}

# Create directories
mkdir -p "${HOME}/.tmux/plugins" "${HOME}/bin" "${HOME}/.local/share/nvim/site/autoload" "${HOME}/.config/nvim/colors" "${HOME}/.cargo"

# Clone repositories
clone_repo "https://github.com/tmux-plugins/tpm" "${HOME}/.tmux/plugins/tpm"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
clone_repo "https://github.com/zsh-users/zsh-autosuggestions" "${PLUGINS_DIR}/zsh-autosuggestions"
clone_repo "https://github.com/Aloxaf/fzf-tab" "${PLUGINS_DIR}/fzf-tab"
clone_repo "https://github.com/zsh-users/zsh-syntax-highlighting.git" "${PLUGINS_DIR}/zsh-syntax-highlighting"
clone_repo "https://github.com/wfxr/forgit.git" "${PLUGINS_DIR}/forgit"
clone_repo "https://github.com/junegunn/fzf.git" "${HOME}/.fzf"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Install packages
install_packages

# Create symlinks
ln -sf "${BASEDIR}/vimrc" "${HOME}/.vimrc"
ln -sf "${BASEDIR}/zshrc" "${HOME}/.zshrc"
ln -sf "${BASEDIR}/tmux.conf" "${HOME}/.tmux.conf"
ln -sf "${BASEDIR}/vimrc" "${HOME}/.config/nvim/init.vim"
ln -sf "${BASEDIR}/koehler2.vim" "${HOME}/.config/nvim/colors/koehler2.vim"

# Configure cargo
echo -e "\n" >> "${HOME}/.cargo/config.toml"
cat "${BASEDIR}/cargo_config" >> "${HOME}/.cargo/config.toml"

if [ -s "${HOME}/.rust/bin" ]; then
    ln -s "${HOME}/.rust/bin" "${HOME}/.cargo/bin"
fi
sh -c "$(curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs)" -y
"${HOME}/.cargo/bin/cargo" install bat fd-find lsd ripgrep git-delta vivid difftastic zoxide git-absorb &

# Install FZF
"${HOME}/.fzf/install" --all

# Install Brew
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Wait for background jobs to finish
wait
