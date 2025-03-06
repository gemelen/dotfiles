#!/usr/bin/env zsh

# locale
locale_en="en_US.UTF-8"
locale_c="C"
LANG=${locale_en}
LC_CTYPE=${locale_en}
LC_COLLATE=${locale_en}
LC_MONETARY=${locale_en}
LC_MESSAGES=${locale_en}
LC_NAME=${locale_en}
LC_ADDRESS=${locale_en}
LC_TELEPHONE=${locale_en}
LC_IDENTIFICATION=${locale_en}
LC_NUMERIC=${locale_c}
LC_TIME=${locale_c}
LC_PAPER=${locale_c}
LC_MEASUREMENT=${locale_c}

export LANG LC_CTYPE LC_COLLATE LC_MONETARY LC_MESSAGES LC_NAME LC_ADDRESS LC_TELEPHONE LC_IDENTIFICATION LC_NUMERIC LC_TIME LC_PAPER LC_MEASUREMENT

# fzf, https://minsw.github.io/fzf-color-picker/
export FZF_DEFAULT_OPTS="--keep-right --info=hidden --border=none --color=fg:-1,bg:-1,hl:#003a7d --color=fg+:#d0d0d0,bg+:#173691,hl+:#b891ff --color=info:#a5a84a,prompt:#e04f0b,pointer:#ff21b9 --color=marker:#80ff00,spinner:#8800ff,header:#58c0c4"

# ssh
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# podman as docker
export DOCKER_HOST="unix:///run/user/1000/podman/podman.sock"

source $ZDOTDIR/env/host.`hostname`
