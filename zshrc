# -*- sh -*-
[ -s "$HOME/.pre.zsh" ] && source "$HOME/.pre.zsh"

export CONFIG_DIR=dotfiles

export ZSH_DISABLE_COMPFIX=true
export GIT_COMPLETION_CHECKOUT_NO_GUESS=true

export ZSH_DISABLE_COMPFIX=true
skip_global_compinit=1
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
export DISABLE_UPDATE_PROMPT=true
export DISABLE_COMPFIX="true"
export ENABLE_CORRECTION="true"
export COMPLETION_WAITING_DOTS="false"
export DISABLE_UNTRACKED_FILES_DIRTY="true"
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)

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
export FZF_COMPLETION_DIR_COMMANDS="cd rmdir tree git gt"
export EDITOR="nvim"
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE="20"
export ZSH_AUTOSUGGEST_USE_ASYNC=1

plugins=(git gitfast tmux zsh-autosuggestions history-substring-search last-working-dir extract fzf-tab zsh-syntax-highlighting)

GENCOMPL_PY=python3
source $ZSH/oh-my-zsh.sh
source $HOME/$CONFIG_DIR/zsh-completion-generator.plugin.zsh
zstyle :plugin:zsh-completion-generator programs rg bat

setopt shwordsplit
setopt HIST_IGNORE_ALL_DUPS
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $HOME/.zsh/cache

setopt EXTENDEDGLOB

bindkey '^[^P' history-substring-search-up
bindkey '^[^N' history-substring-search-down
bindkey '^ ' autosuggest-accept

[[ -x /opt/homebrew/bin/brew ]] && eval $(/opt/homebrew/bin/brew shellenv)
[[ -x /home/linuxbrew/.linuxbrew/bin/brew ]] && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

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
  "$HOME/$CONFIG_DIR/scripts"
  "$HOME/.rbenv/bin/"
  "$HOME/.emacs.d/bin/"
  "$HOME/.config/emacs.d/bin/"
  "$HOME/Library/Python/3.9/bin"
  "$HOME/.fzf/bin"
  "$HOME/.local/bin"
  "/home/linuxbrew/.linuxbrew/bin"
  "$HOME/node_modules/.bin/"
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
alias c="cursor ."
alias multipull="find . -mindepth 1 -maxdepth 1 -type d -print -exec git -C {} pull \;"
alias tree="lsd --tree"
alias mig="DISABLE_SPRING=1 bin/rails db:migrate db:test:prepare"
alias myprs='gh pr list -S '\''is:open is:pr author:@me archived:false'\'
alias clean_clipboard="pbpaste | sed 's#\\n#\n#g' | pbcopy"
alias dt="dev test"
alias force-remote='git fetch origin $(git rev-parse --abbrev-ref HEAD) && git reset --hard origin/$(git rev-parse --abbrev-ref HEAD)'
alias clean-local-branches='git branch --merged | grep -v main | grep -v master | xargs git branch --delete'
if command -v gt &> /dev/null; then
  alias rebase-remote-main='gco main && git pull && gco - && gt restack && gt submit'
fi
alias my-branches="git branch --list 'phaselockedloop*'"
alias wt="cdworktree"
alias bbat="bat --paging=never --plain --color always"
alias cc="claude update && claude --dangerously-skip-permissions"

# Graphite
if command -v gt &> /dev/null; then
  alias gs="gt status"
  alias gco="gt checkout"
  alias gca="gt create"
  alias gm="gt modify --all"
fi

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

autoload -U promptinit; promptinit

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

[ -s "$HOME/.config/broot/launcher/bash/br" ] && source "$HOME/.config/broot/launcher/bash/br"

if [ "$TERM_PROGRAM" = tmux ]; then
    $HOME/$CONFIG_DIR/scripts/fix_blink.sh
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

killport() {
  if [ "$#" -lt 2 ]; then
    echo "Usage: killport <hostname> <port>"
    return 1
  fi

  HOSTNAME=$1
  PORT=$2
  PID=$(lsof -t -i @$HOSTNAME:$PORT)

  if [ -n "$PID" ]; then
    echo "Killing process $PID running on $HOSTNAME:$PORT"
    kill -9 "$PID"
  else
    echo "No process is running on $HOSTNAME:$PORT"
  fi
}

# Function to navigate directories using fzf and fd
cd_fzf_full() {
  local current_dir=$(pwd)
  local paths=()
  local parent_paths=()

  # Populate with every parent directory
  # But exclude current directory and root directory
  # Put newlines between parent paths so FZF works
  while [[ "$current_dir" != "/" ]]; do
    parent_paths+=($current_dir$'\n')
    current_dir=$(dirname "$current_dir")
  done

  parent_paths=("${parent_paths[@]:1:${#parent_paths[@]}-1}")

  # Get directories by depth, limited to 50 total
  local nested_dirs=""
  local count=0
  local depth=1

  while [[ $count -lt 50 ]]; do
    # Get directories at current depth and make paths relative to current directory
    local dirs_at_depth=$(fd --type d --exclude ".git" --exclude "target/release" --max-depth $depth --min-depth $depth . "$(pwd)" | \
      while read -r dir; do
        echo "${dir#$(pwd)/}"
      done | head -n $((50 - count)))

    if [[ -z "$dirs_at_depth" ]]; then
      break
    fi

    nested_dirs+=$dirs_at_depth$'\n'
    count=$((count + $(echo "$dirs_at_depth" | wc -l)))
    depth=$((depth + 1))
  done

  local all_dirs=$(printf "%s\n%s" "${parent_paths[@]}" "$nested_dirs" | sed '/^$/d' | sort -r)
  local selected_dir=$(echo "$all_dirs" | fzf --tac)

  if [[ -n "$selected_dir" ]]; then
    cd "$selected_dir"
  fi
  zle reset-prompt  # Refresh prompt to reflect new directory
}

# Create a zle widget
zle -N cd_fzf_full_widget cd_fzf_full

# Bind Control-o to the above widget
bindkey "^o" cd_fzf_full_widget

# Make a widget for zoxide interactive
zoxide_query_interactive() {
  local selected_dir=$(zoxide query --interactive)
  if [[ -n "$selected_dir" ]]; then
    cd "$selected_dir"
  fi
  zle reset-prompt  # Refresh prompt to reflect new directory
}
zle -N zoxide_query_interactive_widget zoxide_query_interactive

# Bind control-i to zoxide interactive
bindkey "^u" zoxide_query_interactive_widget

source "$HOME/$CONFIG_DIR/completion.zsh"
source "$HOME/$CONFIG_DIR/key-bindings.zsh"

typeset -U fpath
autoload -U +X bashcompinit && bashcompinit
autoload -Uz compinit
if [ "$(date +'%j')" != "$(stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)" ]; then
    compinit
else
    compinit -C
fi

if command -v gt &> /dev/null; then
  #compdef gt
  ###-begin-gt-completions-###
  #
  # yargs command completion script
  #
  # Installation: gt completion >> ~/.zshrc
  #    or gt completion >> ~/.zprofile on OSX.
  #
  _gt_yargs_completions()
  {
    local reply
    local si=$IFS
    IFS=$'
' reply=($(COMP_CWORD="$((CURRENT-1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" gt --get-yargs-completions "${words[@]}"))
    IFS=$si
    _describe 'values' reply
  }
  compdef _gt_yargs_completions gt
  ###-end-gt-completions-###
fi

function cdworktree() {
    # Get the root git directory
    local git_root=$(git rev-parse --git-common-dir 2>/dev/null)

    if [[ -z "$git_root" ]]; then
        echo "Not in a git repository"
        return 1
    fi

    # Remove .git from the end if present
    git_root=${git_root%.git}

    # Get list of worktrees and change directory
    local selected_dir=$(git worktree list |
        fzf --height 40% --reverse --header="Select a worktree" |
        awk '{print $1}')

    if [[ -n "$selected_dir" ]]; then
        cd "${selected_dir}"
        # Print current directory for confirmation
        echo "Changed to: $(pwd)"
    fi
}

correct_ignore=(claude)
eval "$(starship init zsh)"
