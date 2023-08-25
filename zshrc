# -*- sh -*-
[ -s "$HOME/.pre.zsh" ] && source "$HOME/.pre.zsh"

export CONFIG_DIR=dotfiles

export ZSH_DISABLE_COMPFIX=true
export DISABLE_UPDATE_PROMPT=true
export GIT_COMPLETION_CHECKOUT_NO_GUESS=true

#zmodload zsh/zprof
export ZSH=$HOME/.oh-my-zsh
export FZF_CTRL_T_OPTS="--ansi --preview '(bat {} --color always || highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 1> /dev/null | head -400'"
export FZF_DEFAULT_COMMAND='fd --color=always --type f'
export FZF_DEFAULT_OPTS='--height 90% --border'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export ZSH_THEME=""
export HYPHEN_INSENSITIVE="true"
export UPDATE_ZSH_DAYS=1
export DISABLE_AUTO_TITLE="true"
export DISABLE_AUTO_UPDATE="true"
export ENABLE_CORRECTION="true"
export COMPLETION_WAITING_DOTS="true"
export DISABLE_UNTRACKED_FILES_DIRTY="true"
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export PURE_PROMPT_PATH_FORMATTING=%~
export PURE_GIT_PULL=0

export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY

export SHELL="/bin/zsh"
export TERM='xterm-256color'

export LANGUAGE=en_US:en
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_TYPE=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export GPG_TTY=$(tty)
export SDKMAN_DIR="$HOME/.sdkman"

export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export FZF_COMPLETION_TRIGGER=":"
export FZF_COMPLETION_DIR_COMMANDS="cd rmdir tree git"

plugins=(git gitfast tmux fzf fzf-tab zsh-autosuggestions history-substring-search last-working-dir z extract gpg-agent rbenv ruby rails)

source $ZSH/oh-my-zsh.sh

setopt shwordsplit
setopt HIST_IGNORE_ALL_DUPS
setopt no_complete_aliases
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $HOME/.zsh/cache

setopt EXTENDEDGLOB

bindkey '^[^P' history-substring-search-up
bindkey '^[^N' history-substring-search-down
bindkey '^ ' autosuggest-accept

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

[ -s "/usr/local/bin/nvim" ]                                                                 && export EDITOR="/usr/local/bin/nvim"
[ -s "/usr/bin/nvim" ]                                                                       && export EDITOR="/usr/bin/nvim"
[ -s "/usr/local/opt/scala" ]                                                                && export SCALA_HOME="/usr/local/opt/scala"

[ -s "$HOME/$CONFIG_DIR/paste_hell.zsh" ]                                                    && source "$HOME/$CONFIG_DIR/paste_hell.zsh"
[ -s "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] && source "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]                                                      && source "$SDKMAN_DIR/bin/sdkman-init.sh"
[ -s "$HOME/.ghcup/env" ]                                                                    && source "$HOME/.ghcup/env"
[ -f "$HOME/.fzf.zsh" ]                                                                      && source "$HOME/.fzf.zsh"

[ -s "$HOME/.cargo/bin" ]                                                                    && export PATH="$HOME/.cargo/bin":$PATH
[ -s "$HOME/.rust/bin" ]                                                                     && export PATH="$HOME/.rust/bin":$PATH
[ -s "$HOME/src/git-fuzzy/bin" ]                                                             && export PATH="$HOME/src/git-fuzzy/bin":$PATH
[ -s "$HOME/tools" ]                                                                         && export PATH="$HOME/tools":$PATH
[ -s "$HOME/bin" ]                                                                           && export PATH="$HOME/bin":$PATH
[ -s "$HOME/$CONFIG_DIR" ]                                                                   && export PATH="$HOME/$CONFIG_DIR":$PATH
[ -s "$HOME/.rbenv/bin/" ]                                                                   && export PATH="$HOME/.rbenv/bin/:$PATH"
[ -s "$HOME/.emacs.d/bin/" ]                                                                 && export PATH="$HOME/.emacs.d/bin/:$PATH"

[ -s "/usr/local/bin" ]                                                                      && export PATH="/usr/local/bin":$PATH
[ -s "/usr/local/go/bin" ]                                                                   && export PATH="/usr/local/go/bin":$PATH
[ -s "/opt/rubies/3.0.1-pshopify2/bin/" ]                                                    && export PATH="/opt/rubies/3.0.1-pshopify2/bin/":$PATH
[ -s "$HOME/Library/Python/3.9/bin" ]                                                        && export PATH="$HOME/Library/Python/3.9/bin":$PATH

[ -s "/usr/local/bin/bit" ]                                                                  && complete -o nospace -C /usr/local/bin/bit bit

alias vi=nvim
alias vim=nvim
alias l="lsd -A1tlrh --blocks permission,size,date,name"
alias gfz="git fuzzy"
alias cat="bat"
alias gll='git log --graph --pretty="format:%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
alias grsh="git reset --hard"
alias c="cd ~/src"
alias gs="git status"
alias multipull="find . -mindepth 1 -maxdepth 1 -type d -print -exec git -C {} pull \;"
alias tree="lsd --tree"
alias mig="DISABLE_SPRING=1 bin/rails db:migrate db:test:prepare"
alias myprs='gh pr list -S '\''is:open is:pr author:jameskieley archived:false'\'
alias clean_clipboard="pbpaste | sed 's#\\n#\n#g' | pbcopy"
alias dt="dev test"
alias force_remote='git fetch origin && git reset --hard origin/$(git rev-parse --abbrev-ref HEAD)'

gbb() {
    git show --format='%C(auto)%D %s' -s $(git for-each-ref --sort=committerdate --format='%(refname:short)' refs/heads/)
}

if [ -x "$(command -v scmpuff)" ]; then
  eval "$(scmpuff init -s)"
fi

delete-branches() {
  results=$(git branch |
    grep --invert-match '\*' |
    cut -c 3- |
    fzf --multi --preview="git log --no-merges --color --stat -p {}")
    test "$results" && git branch --delete --force $results
}

rgl() {
  rg -B5 -A5 -g "*.rb" -g"!*test*" -p "$1" | less
}

rglc() {
  rg -B5 -A5 -g "*.rb" -g"!*test*" -p "$1" "$2" | less
}

rglt() {
  rg -g "*.rb" -p "$1" | less
}

fpath+=$HOME/$CONFIG_DIR'/purer-prompt/functions'

autoload -U promptinit; promptinit
prompt purer

autoload -U +X bashcompinit && bashcompinit

[[ -f /opt/dev/sh/chruby/chruby.sh ]] && { type chruby >/dev/null 2>&1 || chruby () { source /opt/dev/sh/chruby/chruby.sh; chruby "$@"; } }

[[ -x /opt/homebrew/bin/brew ]] && eval $(/opt/homebrew/bin/brew shellenv)

tere() {
    local result=$($HOME/.cargo/bin/tere "$@")
    [ -n "$result" ] && cd -- "$result"
}

export LS_COLORS="$(vivid --color-mode 24-bit generate molokai)"
export ZLS_COLORS=$LS_COLORS
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'

enable-fzf-tab

[ -s "$HOME/.post.zsh" ] && source "$HOME/.post.zsh"

if [ "$TERM_PROGRAM" = tmux ]; then
    $HOME/$CONFIG_DIR/fix_blink.sh
fi

function _fzf_complete_dt() {
    _fzf_complete --prompt="test:" -- "$@" < <(
        fd -t f -p "_test.rb" components/*/test
    )
}

function _fzf_compgen_path() {
    rg --files --glob "!.git" . "$1"
}

function _fzf_compgen_dir() {
   fd --color always --type d --hidden --follow --exclude ".git" . "$1"
}

#zprof

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
