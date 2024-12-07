# redundant, but safe
export XDG_CONFIG_HOME=$HOME/.config
export ZDOTDIR=${XDG_CONFIG_HOME}/zsh

# generic
export EDITOR=vim
export TZ=America/Montevideo
# locale
locale_en="en_US.UTF-8"
locale_c="C"
export LANG=${locale_en}
export LC_CTYPE=${LANG}
export LC_COLLATE=${LANG}
export LC_MONETARY=${LANG}
export LC_MESSAGES=${LANG}
export LC_NAME=${LANG}
export LC_ADDRESS=${LANG}
export LC_TELEPHONE=${LANG}
export LC_IDENTIFICATION=${LANG}
export LC_ALL=${LANG}
export LC_NUMERIC=${local_c}
export LC_TIME=${local_c}
export LC_PAPER=${local_c}
export LC_MEASUREMENT=${local_c}

# Github
export GH_REGISTRY_RO=$(kwallet-query -f local kdewallet -r gh_registry_ro)
export GH_REGISTRY_RW=$(kwallet-query -f local kdewallet -r gh_registry_rw)

export RIPGREP_CONFIG_PATH=${XDG_CONFIG_HOME}/rg.conf

# https://minsw.github.io/fzf-color-picker/
export FZF_DEFAULT_OPTS='--keep-right --info=hidden --border=none --color=fg:-1,bg:-1,hl:#003a7d --color=fg+:#d0d0d0,bg+:#173691,hl+:#b891ff --color=info:#a5a84a,prompt:#e04f0b,pointer:#ff21b9 --color=marker:#80ff00,spinner:#8800ff,header:#58c0c4'
