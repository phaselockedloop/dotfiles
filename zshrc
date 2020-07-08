[ -s "$HOME/.pre.zsh" ] && source "$HOME/.pre.zsh"

export ZSH=$HOME/.oh-my-zsh
export FZF_CTRL_T_OPTS="--ansi --preview '(bat {} --color always || highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 1> /dev/null | head -400'"
export FZF_DEFAULT_COMMAND='fd --color=always'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export ZSH_THEME="knowles"
export HYPHEN_INSENSITIVE="true"
export UPDATE_ZSH_DAYS=1
export DISABLE_AUTO_TITLE="true"
export ENABLE_CORRECTION="true"
export COMPLETION_WAITING_DOTS="true"
export DISABLE_UNTRACKED_FILES_DIRTY="true"
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)

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

plugins=(git docker docker-compose tmuxinator tmux ansible-server fzf scm_breeze zsh-autosuggestions history-substring-search last-working-dir z cargo aws extract gpg-agent nvm helm kubectl)

source $ZSH/oh-my-zsh.sh

setopt shwordsplit
setopt HIST_IGNORE_ALL_DUPS
setopt no_complete_aliases
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $HOME/.zsh/cache
autoload -Uz compinit && compinit
autoload bashcompinit && bashcompinit


bindkey '^[^P' history-substring-search-up
bindkey '^[^N' history-substring-search-down
bindkey '^ ' autosuggest-accept

ZSH_AUTOSUGGEST_STRATEGY=(history completion)

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games"

[ -s "/usr/local/bin/nvim" ]                                                                 && export EDITOR="/usr/local/bin/nvim"
[ -s "/usr/bin/nvim" ]                                                                       && export EDITOR="/usr/bin/nvim"

[ -s "$HOME/configs/tmuxinator.zsh" ]                                                        && source "$HOME/configs/tmuxinator.zsh"
[ -s "$HOME/.fzf.zsh" ]                                                                      && source "$HOME/.fzf.zsh"
[ -s "$HOME/.iterm2_shell_integration.zsh" ]                                                 && source "$HOME/.iterm2_shell_integration.zsh"
[ -s "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] && source "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
[ -s "$HOME/.scm_breeze/scm_breeze.sh" ]                                                     && source "$HOME/.scm_breeze/scm_breeze.sh"
[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]                                                      && source "$SDKMAN_DIR/bin/sdkman-init.sh"
[ -s "$HOME/Library/Preferences/org.dystroy.broot/launcher/bash/br" ]                        && source "$HOME/Library/Preferences/org.dystroy.broot/launcher/bash/br"
[ -s "$HOME/.config/broot/launcher/bash/br" ]                                                && source "$HOME/.config/broot/launcher/bash/br"
[ -s "$HOME/.token.zsh" ]                                                                    && source "$HOME/.token.zsh"
[ -s "$HOME/configs/paste_hell.zsh" ]                                                        && source "$HOME/configs/paste_hell.zsh"

[ -s "$HOME/.rubies/ruby-2.6.5/bin" ]                                                        && export PATH="$HOME/.rubies/ruby-2.6.5/bin":$PATH
[ -s "$HOME/.cargo/bin" ]                                                                    && export PATH="$HOME/.cargo/bin":$PATH
[ -s "/usr/local/bin" ]                                                                      && export PATH="/usr/local/bin":$PATH
[ -s "/usr/local/go/bin" ]                                                                   && export PATH="/usr/local/go/bin":$PATH
[ -s "$HOME/.rubies/ruby-2.6.5/bin" ]                                                        && export PATH="$HOME/.rubies/ruby-2.6.5/bin":$PATH
[ -s "$HOME/.gem/ruby/2.7.0/bin" ]                                                           && export PATH="$HOME/.gem/ruby/2.7.0/bin":$PATH
[ -s "$HOME/src/git-fuzzy/bin" ]                                                             && export PATH="$HOME/src/git-fuzzy/bin":$PATH
[ -s "$HOME/tools" ]                                                                         && export PATH="$HOME/tools":$PATH
[ -s "/Library/Java/JavaVirtualMachines/graalvm-ce-19.2.0.1/Contents/Home" ]                 && export GRAALVM_HOME="/Library/Java/JavaVirtualMachines/graalvm-ce-19.2.0.1/Contents/Home"
[ -s "/usr/local/opt/scala" ]                                                                && export SCALA_HOME="/usr/local/opt/scala"

alias vi=nvim
alias vim=nvim
alias l="lsd -A1tlrh --blocks permission,size,date,name"
alias gfz="git fuzzy"
alias cat="bat"
alias aws-vault="aws-vault --keychain=login"

[ -s "$HOME/.post.zsh" ] && source "$HOME/.post.zsh"

fortune | cowsay | lolcat

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
