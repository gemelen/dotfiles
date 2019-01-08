# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
bindkey '^R' history-incremental-search-backward
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/gemelen/.zshrc'

autoload -Uz compinit
autoload -U promptinit
autoload colors

compinit
setopt prompt_subst

precmd() {
    PROMPT="%m %~ %(#.#.>) "
}

alias l="ls -lah --color"

