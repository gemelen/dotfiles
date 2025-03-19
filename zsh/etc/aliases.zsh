#!/usr/bin/env zsh

# shortcuts
alias ls="ls --color=auto --group-directories-first"
alias l="ls -lAhv"
alias ll="ls -Ahv"

alias ps="grc ps -eFLww"

alias sbt="sbt -ivy $XDG_CACHE_HOME/ivy2 -sbt-dir $XDG_DATA_HOME/sbt"

local ammonite_opts="--home $XDG_CACHE_HOME/ammonite --output-directory $XDG_RUNTIME_DIR/ammonite --no-home-predef --predef $XDG_CONFIG_HOME/ammonite/predef.sc"
alias amm="cs launch ammonite --scala 3.3 -- $ammonite_opts"
alias amo="cs launch ammonite --scala 2.13 -- $ammonite_opts"
alias amn="cs launch ammonite --scala 3.6 -- $ammonite_opts"

local rawi="rsync -avz --append-verify --partial --progress --human-readable --stats --password-file=$XDG_CONFIG_HOME/rsync/FIXME rsync://USER@HOST:PORT/"
alias rawif="$rawi/files ."
alias rawiv="$rawi/video ."

# places
alias zdot='cd ${ZDOTDIR:-~}'
alias ndot='cd ${HOME}/.config/nvim'

# media
(( $+commands[xclip] )) && {
    alias pbpaste='xclip -i -selection clipboard -o'
    alias pbcopy='xclip -selection clipboard'
}
(( $+commands[wl-clip] )) && {
    alias pbpaste='wl-paste'
    alias pbcopy='wl-copy'
}
alias ya='(){yt-dlp -x --audio-format mp3 -o "%(title)s.%(ext)s" $(pbpaste);}'

# work with date ISO 8601 easy
alias isodate="date +%Y-%m-%dT%H:%M:%S%z"
alias isodate_utc="date -u +%Y-%m-%dT%H:%M:%SZ"
alias isodate_basic="date -u +%Y%m%dT%H%M%SZ"
alias unixstamp="date +%s"
alias date_locale="date +"%c""

# misc
alias moar=less
alias tldr=less
alias rtfm=man
alias wft=dmesg

# podman shortcuts
alias p="podman "
alias ppu="podman pull "

alias pj="podman exec -til bash"

alias prit="podman container run --interactive --tty "
alias prm="podman container rm "
alias pls="podman container ls "
alias plsa="podman container ls --all "

alias pib="podman image build "
alias pils="podman images -a"
alias pirm="podman image rm "
alias prmi="pils --filter dangling=true --noheading --format \"{{.ID}}\"|xargs podman rmi -f"

#source aliases.d/react-native.zsh
#source aliases.d/xcode.zsh

# vim: nospell
