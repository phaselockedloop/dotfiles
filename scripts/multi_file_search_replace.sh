#!/usr/bin/env sh

set -x
rg --files-with-matches "$1" | xargs gsed -i "s#$1#$2#g"
