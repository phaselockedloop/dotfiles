STATUS_COLOR='cyan'
prompt_pure_clear_screen() {
	zle -I
	print -n '\e[2J\e[0;0H'
	prompt_pure_preprompt_render precmd
}
prompt_pure_preexec() {
	[[ $2 =~ (git|hub)\ .*(pull|fetch) ]] && async_flush_jobs 'prompt_pure'
	prompt_pure_cmd_timestamp=$EPOCHSECONDS
}
prompt_pure_string_length_to_var() {
	local str=$1 var=$2 length
	typeset -g "${var}"="${length}"
}
prompt_pure_preprompt_render() {
	local prompt_subst_status=$options[prompt_subst]
	setopt local_options no_prompt_subst
	[[ -n ${prompt_pure_cmd_timestamp+x} && "$1" != "precmd" ]] && return
	local git_color=242
	[[ -n ${prompt_pure_git_last_dirty_check_timestamp+x} ]] && git_color=red
	local preprompt=""
	local symbol_color="%(?.${PURE_PROMPT_SYMBOL_COLOR:-magenta}.red)"
	local path_formatting="${PURE_PROMPT_PATH_FORMATTING:-%c}"
	preprompt+="%B%F{$STATUS_COLOR}$path_formatting%f%b"
	preprompt+="%F{$git_color}${vcs_info_msg_0_}%f"
	if [[ -v SPIN_INSTANCE_FQDN ]]; then
		preprompt+=" %F{red}$SPIN_INSTANCE_FQDN"
	else
		preprompt+=$prompt_pure_username
	fi
	preprompt+=" %F{cyan}❯%F{blue}❯%F{green}❯%f "
	typeset -g -a prompt_pure_last_preprompt
	PROMPT="$preprompt"
	if [[ "$1" != "precmd" ]]; then
		zle && zle .reset-prompt
		setopt no_prompt_subst
	fi
	prompt_pure_last_preprompt=("$preprompt" "${(S%%)preprompt}")
}
prompt_pure_precmd() {
	prompt_pure_cmd_timestamp=
	vcs_info
	psvar[12]=
	prompt_pure_preprompt_render "precmd"
	PURER_PROMPT_COMMAND_COUNT=$((PURER_PROMPT_COMMAND_COUNT+1))
	prompt_pure_preprompt_render "precmd"
	unset prompt_pure_cmd_timestamp
}
prompt_pure_setup() {
	export PROMPT_EOL_MARK=''
	zmodload zsh/datetime
	zmodload zsh/zle
	zmodload zsh/parameter
	autoload -Uz add-zsh-hook
	autoload -Uz vcs_info
	autoload -Uz async && async
	add-zsh-hook precmd prompt_pure_precmd
	add-zsh-hook preexec prompt_pure_preexec
	zstyle ':vcs_info:*' enable git
	zstyle ':vcs_info:*' use-simple true
	zstyle ':vcs_info:*' max-exports 2
	zstyle ':vcs_info:git*' formats ' %b' 'x%R'
	zstyle ':vcs_info:git*' actionformats ' %b|%a' 'x%R'
	if [[ $widgets[clear-screen] == 'builtin' ]]; then
		zle -N clear-screen prompt_pure_clear_screen
	fi
	[[ "$SSH_CONNECTION" != '' ]] && prompt_pure_username=' %F{242}%n@%m%f'
	[[ $UID -eq 0 ]] && prompt_pure_username=' %F{white}%n%f%F{242}@%m%f'
	prompt_pure_preprompt_render 'precmd'
}
prompt_pure_setup "$@"
