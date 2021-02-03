# -*- sh -*-
[ -s "$HOME/.pre.zsh" ] && source "$HOME/.pre.zsh"

export ZSH_DISABLE_COMPFIX=true
export DISABLE_UPDATE_PROMPT=true

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
export ENABLE_CORRECTION="true"
export COMPLETION_WAITING_DOTS="true"
export DISABLE_UNTRACKED_FILES_DIRTY="true"
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export PURE_PROMPT_PATH_FORMATTING=%~
export PURE_GIT_PULL=0

export SHELL="/bin/zsh"
export TERM='xterm-256color'

export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_TYPE=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export GPG_TTY=$(tty)
export SDKMAN_DIR="$HOME/.sdkman"

export MANPAGER="sh -c 'col -bx | bat -l man -p'"

export REDIS_CLUSTER_IP=0.0.0.0

plugins=(git docker docker-compose tmuxinator tmux fzf zsh-autosuggestions history-substring-search last-working-dir z extract gpg-agent rbenv ruby rails)

source $ZSH/oh-my-zsh.sh

setopt shwordsplit
setopt HIST_IGNORE_ALL_DUPS
setopt no_complete_aliases
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $HOME/.zsh/cache

setopt EXTENDEDGLOB

autoload bashcompinit && bashcompinit

bindkey '^[^P' history-substring-search-up
bindkey '^[^N' history-substring-search-down
bindkey '^ ' autosuggest-accept

ZSH_AUTOSUGGEST_STRATEGY=(history completion)

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games"

[ -s "/usr/local/bin/nvim" ]                                                                 && export EDITOR="/usr/local/bin/nvim"
[ -s "/usr/bin/nvim" ]                                                                       && export EDITOR="/usr/bin/nvim"

[ -s "$HOME/configs/tmuxinator.zsh" ]                                                        && source "$HOME/configs/tmuxinator.zsh"
[ -s "$HOME/.iterm2_shell_integration.zsh" ]                                                 && source "$HOME/.iterm2_shell_integration.zsh"
[ -s "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] && source "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]                                                      && source "$SDKMAN_DIR/bin/sdkman-init.sh"
[ -s "$HOME/Library/Preferences/org.dystroy.broot/launcher/bash/br" ]                        && source "$HOME/Library/Preferences/org.dystroy.broot/launcher/bash/br"
[ -s "$HOME/.config/broot/launcher/bash/br" ]                                                && source "$HOME/.config/broot/launcher/bash/br"
[ -s "$HOME/.token.zsh" ]                                                                    && source "$HOME/.token.zsh"
[ -s "$HOME/configs/paste_hell.zsh" ]                                                        && source "$HOME/configs/paste_hell.zsh"

[ -s "$HOME/.cargo/bin" ]                                                                    && export PATH="$HOME/.cargo/bin":$PATH
[ -s "/usr/local/bin" ]                                                                      && export PATH="/usr/local/bin":$PATH
[ -s "/usr/local/go/bin" ]                                                                   && export PATH="/usr/local/go/bin":$PATH
[ -s "$HOME/src/git-fuzzy/bin" ]                                                             && export PATH="$HOME/src/git-fuzzy/bin":$PATH
[ -s "$HOME/tools" ]                                                                         && export PATH="$HOME/tools":$PATH
[ -s "$HOME/bin" ]                                                                           && export PATH="$HOME/bin":$PATH
[ -s "$HOME/configs" ]                                                                       && export PATH="$HOME/configs":$PATH
[ -s "/Library/Java/JavaVirtualMachines/graalvm-ce-19.2.0.1/Contents/Home" ]                 && export GRAALVM_HOME="/Library/Java/JavaVirtualMachines/graalvm-ce-19.2.0.1/Contents/Home"
[ -s "/usr/local/opt/scala" ]                                                                && export SCALA_HOME="/usr/local/opt/scala"
[ -s "$HOME/bin/google-cloud-sdk/bin/" ]                                                     && export PATH="$HOME/bin/google-cloud-sdk/bin/:$PATH"
[ -s "$HOME/bin/cqlsh-5.1.19/bin/" ]                                                         && export PATH="$HOME/bin/cqlsh-5.1.19/bin/:$PATH"
[ -s "$HOME/.rbenv/bin/" ]                                                                   && export PATH="$HOME/.rbenv/bin/:$PATH"

alias vi=nvim
alias vim=nvim
alias l="lsd -A1tlrh --blocks permission,size,date,name"
alias gfz="git fuzzy"
alias cat="bat"
alias gll='git log --graph --pretty="format:%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'

rgl() {
    rg -g "*.rb" -g"!*_test.*" -p "$1" | less
}

rglt() {
    rg -g "*.rb" -p "$1" | less
}

multi_file_search_replace() {
    echo "Running rg --files-with-matches ""$1"" | xargs gsed -i 's/""$1""/""$2""/g'"
    rg --files-with-matches "$1" | xargs gsed -i 's/$1/$2/g'
}

autoload -U promptinit; promptinit
prompt purer

[ -s "$HOME/.post.zsh" ] && source "$HOME/.post.zsh"
#zprof
