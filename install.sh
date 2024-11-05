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
"${BASEDIR}/ohmyzsh.sh" --unattended
clone_repo "https://github.com/zsh-users/zsh-autosuggestions" "${PLUGINS_DIR}/zsh-autosuggestions"
clone_repo "https://github.com/Aloxaf/fzf-tab" "${PLUGINS_DIR}/fzf-tab"
clone_repo "https://github.com/zsh-users/zsh-syntax-highlighting.git" "${PLUGINS_DIR}/zsh-syntax-highlighting"
clone_repo "https://github.com/wfxr/forgit.git" "${PLUGINS_DIR}/forgit"

# Install packages
install_packages

# Create symlinks
ln -sf "${BASEDIR}/vimrc" "${HOME}/.vimrc"
ln -sf "${BASEDIR}/zshrc" "${HOME}/.zshrc"
ln -sf "${BASEDIR}/tmux.conf" "${HOME}/.tmux.conf"
ln -sf "${BASEDIR}/plug.vim" "${HOME}/.local/share/nvim/site/autoload/plug.vim"
ln -sf "${BASEDIR}/vimrc" "${HOME}/.config/nvim/init.vim"
ln -sf "${BASEDIR}/koehler2.vim" "${HOME}/.config/nvim/colors/koehler2.vim"

# Configure cargo
echo -e "\n" >> "${HOME}/.cargo/config.toml"
cat "${BASEDIR}/cargo_config" >> "${HOME}/.cargo/config.toml"

# Configure git
{
    echo "[user]"
    echo "    email = andrew.knowles@shopify.com"
    echo "    name = Andrew Knowles"
    echo "[include]"
    echo "    path = ${BASEDIR}/git-delta.conf"
} >> "${HOME}/.gitconfig"

# Install Rust
if [ -s "${HOME}/.rust/bin" ]; then
    ln -s "${HOME}/.rust/bin" "${HOME}/.cargo/bin"
fi
"${BASEDIR}/rustup.sh" -y --default-toolchain stable
nice -n 19 "${HOME}/.cargo/bin/cargo" install bat fd-find lsd ripgrep git-delta vivid difftastic zoxide git-absorb &

# Install FZF
git clone --depth 1 https://github.com/junegunn/fzf.git "${HOME}/.fzf"
"${HOME}/.fzf/install" --all

# Install Brew
CI=1 /bin/bash -c "${BASEDIR}/brew.sh"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
brew install withgraphite/tap/graphite

# Wait for background jobs to finish
wait
