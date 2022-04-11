HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

alias l="ls -lAhG"

bindkey -e
bindkey '^R' history-incremental-search-backward

if type brew &>/dev/null; then
    brewfpath=$(brew --prefix)/share/zsh/site-functions
fi

zstyle :compinstall filename '/home/gemelen/.zshrc'
zstyle ':vcs_info:git:*' formats '%b'

autoload -Uz compinit && compinit
autoload -U promptinit
autoload -Uz vcs_info
autoload colors

setopt prompt_subst

precmd() {
    vcs_info
    PROMPT="%m %~ %K{cyan}${vcs_info_msg_0_}%k%(#.#.>) "
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
