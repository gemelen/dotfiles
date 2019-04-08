HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

bindkey -e
bindkey '^R' history-incremental-search-backward

zstyle :compinstall filename '/home/gemelen/.zshrc'

autoload -Uz compinit
autoload -U promptinit
autoload colors

compinit
setopt prompt_subst

precmd() {
    PROMPT="%m %~ %(#.#.>) "
}

getmetals() {
    if [ -n "$1" ]
    then
        coursier bootstrap \
          --java-opt -XX:+UseG1GC \
          --java-opt -XX:+UseStringDeduplication  \
          --java-opt -Xss4m \
          --java-opt -Xms100m \
          --java-opt -Dmetals.client=vim-lsc \
          org.scalameta:metals_2.12:$1 \
          -r bintray:scalacenter/releases \
          -r sonatype:releases \
          -r sonatype:snapshots \
          -o ${HOME}/bin/metals-vim -f
    fi
}

alias l="ls -lAh --color=auto"
alias 2html="vim -n -c ':so $VIMRUNTIME/syntax/2html.vim' -c ':wqa $1.html' $1 > /dev/null 2> /dev/null" 

