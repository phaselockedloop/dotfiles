#!/usr/bin/env sh

sudo apt-get -y update && sudo apt-get -y upgrade && sudo apt-get -y dist-upgrade
$HOME/.cargo/bin/cargo install broot topgrade xsv just eza cargo-update dijo tere
sudo apt-get -y autoremove

# tldr
sudo npm install -g tldr
