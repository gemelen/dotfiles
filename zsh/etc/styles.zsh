#!/usr/bin/env zsh

# see https://github.com/zsh-users/zsh-completions

zstyle :compinstall filename "${ZDOTDIR}/conf/styles.zsh"

zstyle ':completion:*:*:*:*:*' menu select

zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path $ZSH_CACHE_DIR

# cd
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories

# vcs in prompt
# disable everything but git
# if needed, add others, see https://github.com/zsh-users/zsh/tree/master/Functions/VCS_Info/Backends
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats '%b'

# ssh
_ssh_configfile="$HOME/.ssh/config"
if [[ -f "$_ssh_configfile" ]]; then
  _ssh_hosts=($(
    egrep '^Host.*' "$_ssh_configfile" |\
    awk '{for (i=2; i<=NF; i++) print $i}' |\
    sort |\
    uniq |\
    grep -v '^*' |\
    sed -e 's/\.*\*$//'
  ))
  zstyle ':completion:*:(ssh|scp|sftp):*' hosts $_ssh_hosts
  unset _ssh_hosts
fi
unset _ssh_configfile

# nvm
zstyle ':omz:plugins:nvm' lazy

# commands operating on processes, eg kill
if [[ "$OSTYPE" = solaris* ]]; then
  zstyle ':completion:*:*:*:*:processes' command "ps -u $USERNAME -o pid,user,comm"
else
  zstyle ':completion:*:*:*:*:processes' command "ps -u $USERNAME -o pid,user,comm -w -w"
fi



zstyle ':completion:*:*:*:users' ignored-patterns \
        apache at avahi avahi-autoipd beaglidx bin \
        clamav daemon dbus distcache dnsmasq dovecot fax ftp games gdm \
        gkrellmd gopher hacluster haldaemon halt hsqldb ident junkbust kdm \
        ldap lp mail mailman mailnull man messagebus mysql nagios \
        netdump news nfsnobody nobody nscd ntp nut nx obsrun openvpn \
        operator pcap polkitd postfix privoxy pulse pvm quagga \
        rpc rpcuser rpm rtkit scard shutdown squid sshd statd svn sync tftp \
        usbmux uucp vcsa wwwrun xfs '_*'
