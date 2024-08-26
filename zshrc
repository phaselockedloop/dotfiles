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

plugins=(git gitfast tmux zsh-autosuggestions history-substring-search last-working-dir extract gpg-agent fzf-tab zsh-syntax-highlighting docker)

GENCOMPL_PY=python3
source $ZSH/oh-my-zsh.sh
source $HOME/$CONFIG_DIR/zsh-completion-generator.plugin.zsh
zstyle :plugin:zsh-completion-generator programs   rg bat

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

# Set PATH
path_dirs=(
  "/usr/local/sbin"
  "/usr/local/bin"
  "/usr/sbin"
  "/usr/bin"
  "/sbin"
  "/bin"
  "$HOME/.cargo/bin"
  "$HOME/.rust/bin"
  "$HOME/src/git-fuzzy/bin"
  "$HOME/tools"
  "$HOME/bin"
  "$HOME/$CONFIG_DIR"
  "$HOME/.rbenv/bin/"
  "$HOME/.emacs.d/bin/"
  "$HOME/.config/emacs.d/bin/"
  "$HOME/Library/Python/3.9/bin"
  "$HOME/.fzf/bin"
  "$HOME/.local/bin"
)

for dir in "${path_dirs[@]}"; do
  [ -s "$dir" ] && export PATH="$dir:$PATH"
done

[ -s "/usr/local/bin/nvim" ]                                                                 && export EDITOR="/usr/local/bin/nvim"
[ -s "/usr/bin/nvim" ]                                                                       && export EDITOR="/usr/bin/nvim"

source "$HOME/$CONFIG_DIR/paste_hell.zsh"

alias vi=nvim
alias vim=nvim
alias l="lsd -A1tlrh --blocks size,date,name"
alias gfz="git fuzzy"
alias cat="bat"
alias gll='git log --graph --pretty="format:%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
alias grsh="git reset --hard"
alias c="cd ~/src"
alias gs="git status"
alias multipull="find . -mindepth 1 -maxdepth 1 -type d -print -exec git -C {} pull \;"
alias tree="lsd --tree"
alias mig="DISABLE_SPRING=1 bin/rails db:migrate db:test:prepare"
alias myprs='gh pr list -S '\''is:open is:pr author:@me archived:false'\'
alias clean_clipboard="pbpaste | sed 's#\\n#\n#g' | pbcopy"
alias dt="dev test"
alias force_remote='git fetch origin $(git rev-parse --abbrev-ref HEAD) && git reset --hard origin/$(git rev-parse --abbrev-ref HEAD)'
alias clean_local_branches='git branch --merged | grep -v main | grep -v master | xargs git branch --delete'
alias rebase_remote_main='git fetch origin main && git rebase origin/main && git push --force-with-lease'

gbb() {
    git show --format='%C(auto)%D %s' -s $(git for-each-ref --sort=committerdate --format='%(refname:short)' refs/heads/)
}

delete-branches() {
  branches=$(git branch --format='%(refname:short)' |
    grep --invert-match '\*')
  selected_branches=$(echo "$branches" | fzf --multi --preview="git log --no-merges --color --stat -p {}")
  for branch in $selected_branches
  do
    git branch --delete --force "$branch"
  done
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

fpath=($ZSH/'completions' $fpath)
fpath=($HOME/$CONFIG_DIR'/purer-prompt/functions' $fpath)

autoload -U promptinit; promptinit
prompt purer

[[ -f /opt/dev/sh/chruby/chruby.sh ]] && { type chruby >/dev/null 2>&1 || chruby () { source /opt/dev/sh/chruby/chruby.sh; chruby "$@"; } }

[[ -x /opt/homebrew/bin/brew ]] && eval $(/opt/homebrew/bin/brew shellenv)

if [ -x "$(command -v scmpuff)" ]; then
  eval "$(scmpuff init -s)"
fi

if [ -x "$(command -v zoxide)" ]; then
  eval "$(zoxide init zsh)"
fi

if whence -v vivid > /dev/null 2>&1; then
  export LS_COLORS="$(vivid --color-mode 8-bit generate molokai)"
  export ZLS_COLORS=$LS_COLORS
fi
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'

enable-fzf-tab

[ -s "$HOME/bin/fzf-git.sh" ] && source "$HOME/bin/fzf-git.sh"

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

source "$HOME/$CONFIG_DIR/completion.zsh"
source "$HOME/$CONFIG_DIR/key-bindings.zsh"

typeset -U fpath
autoload -U +X bashcompinit && bashcompinit
compinit

#zprof
