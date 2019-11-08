if [ $UID -eq 0 ]; then CARETCOLOR="red"; else CARETCOLOR="blue"; fi

local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

PROMPT='%{${fg_bold[red]}%}%@%  %{${fg[blue]}%}::%{${reset_color}%} %m %{${fg[blue]}%}:: %{$reset_color%}%{${fg[green]}%}%~ $(git_prompt_info)%{${fg_bold[$CARETCOLOR]}%}λ%{${reset_color}%} '

RPS1="${return_code}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"
