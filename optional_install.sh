#!/usr/bin/env sh

$HOME/.cargo/bin/cargo install broot topgrade xsv just eza cargo-update dijo sccache tere
echo "[build]" >> $HOME/.cargo/config
SCCACHE_PATH=$HOME/.cargo/bin/sccache
echo "rustc-wrapper = \"$SCCACHE_PATH\"" >> $HOME/.cargo/config
