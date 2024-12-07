# shortcuts
alias l="ls -lAh --color=auto"

# redefinitions
alias docker="podman"
alias dockerimages="podman images"
alias dockerinfo="podman info"
alias docker-machinels="podman machine list"
alias dockernetwork="podman network"
alias dockerps="podman ps"
alias dockerpull="podman pull"
alias dockersearch="podman search"
alias dockerversion="podman version"

# misc
alias zshrc='${EDITOR:-vim} "${ZDOTDIR:-$HOME}"/.zshrc'
alias zdot='cd ${ZDOTDIR:-~}'
