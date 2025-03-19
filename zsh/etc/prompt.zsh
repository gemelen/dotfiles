#!/usr/bin/env zsh

autoload -U promptinit
autoload -Uz vcs_info

function zle-keymap-select() {
    RPROMPT="${${KEYMAP/vicmd/[ N ]}/(main|viins)/[ I ]}"

    # 1 - blinking rect
    # 0,2 - white rect
    # 3,4 - underscore
    # 5,6 - thin bar
    local _shape=1
    case "${1:-${VI_KEYMAP:-main}}" in
      main)    _shape=2 ;; # vi insert: line
      viins)   _shape=2 ;; # vi insert: line
      isearch) _shape=1 ;; # inc search: line
      command) _shape=4 ;; # read a command name
      vicmd)   _shape=4 ;; # vi cmd: block
      visual)  _shape=1 ;; # vi visual mode: block
      viopp)   _shape=4 ;; # vi operation pending: blinking block
      *)       _shape=6 ;;
    esac
    printf $'\e[%d q' "${_shape}"
}

zle -N zle-keymap-select

precmd() {
    vcs_info
    PROMPT="%m %~ %K{053}${vcs_info_msg_0_}%k%(#.#.>) "
}
