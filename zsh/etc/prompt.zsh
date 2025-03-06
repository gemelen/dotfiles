#!/usr/bin/env zsh

autoload -U promptinit
autoload -Uz vcs_info

precmd() {
    vcs_info
    PROMPT="%m %~ %K{cyan}${vcs_info_msg_0_}%k%(#.#.>) "
}
