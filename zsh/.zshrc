HISTFILE=~/.zsh/histfile
HISTSIZE=1000000000
SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.

autoload -Uz compinit
autoload -U promptinit
autoload -Uz vcs_info
autoload colors

bindkey -e
bindkey '^R' history-incremental-search-backward

zstyle :compinstall filename '/home/gemelen/.zshrc'
zstyle ':vcs_info:git:*' formats '%b'

# fzf
[ -f /usr/share/zsh/site-functions/_fzf ] && source "/usr/share/zsh/site-functions/_fzf"
[ -f /etc/zsh_completion.d/fzf-key-bindings ] && source "/etc/zsh_completion.d/fzf-key-bindings"

compinit
setopt prompt_subst

precmd() {
    vcs_info
    PROMPT="%m %~ %K{cyan}${vcs_info_msg_0_}%k%(#.#.>) "
}

alias l="ls -lAh --color=auto"
alias vim="nvim -u ~/.vimrc --noplugin"
alias k="kubectl"
alias dl="aws ecr get-login-password --region eu-west-2|docker login --username AWS --password-stdin 482523557101.dkr.ecr.eu-west-2.amazonaws.com"

