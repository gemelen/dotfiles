#!/usr/bin/env zsh

autoload -U colors
colors

# common grc.zsh paths
files=(
  /etc/grc.zsh               # default
  /usr/local/etc/grc.zsh     # homebrew darwin-x64
  /opt/homebrew/etc/grc.zsh  # homebrew darwin-arm64
  /home/linuxbrew/.linuxbrew/etc/grc.zsh # linuxbrew 
  /usr/share/grc/grc.zsh     # Gentoo Linux (app-misc/grc)
)

# verify the file is readable and source it
for file in $files; do
  if [[ -r "$file" ]]; then
    source "$file"
    break
  fi
done
unset file files

# expects `grc` installed
if [[ "$TERM" != dumb ]] && (( $+commands[grc] )) ; then
  # Prevent grc aliases from overriding zsh completions.
  setopt complete_aliases

  # Supported commands
  cmds=(
    blkid configure curl df diff dig du \
    env fdisk free id ifconfig iostat_sar ip ipaddr ipneighbor iproute \
    iptables iwconfig jobs k kubectl last lsattr lsblk lsmod lsof lspci mount mtr mvn \
    netstat nmap ntpdate osc ping ping2 podman ps sensors \
    sockstat ss stat sysctl systemctl tcpdump traceroute ulimit uptime vmstat whois yaml
  );

  for cmd in $cmds ; do
    if (( $+commands[$cmd] )) ; then
      alias $cmd="grc -s -e --colour=auto $cmd "
    fi
  done

  # Clean up variables
  unset cmds cmd
fi

# A script to make using 256 colors in zsh less painful.
# P.C. Shyamshankar <sykora@lucentbeing.com>
# Copied from https://github.com/sykora/etc/blob/master/zsh/functions/spectrum/

typeset -AHg FX FG BG

FX=(
  reset     "%{[00m%}"
  bold      "%{[01m%}" no-bold      "%{[22m%}"
  dim       "%{[02m%}" no-dim       "%{[22m%}"
  italic    "%{[03m%}" no-italic    "%{[23m%}"
  underline "%{[04m%}" no-underline "%{[24m%}"
  blink     "%{[05m%}" no-blink     "%{[25m%}"
  reverse   "%{[07m%}" no-reverse   "%{[27m%}"
)

for color in {000..255}; do
  FG[$color]="%{[38;5;${color}m%}"
  BG[$color]="%{[48;5;${color}m%}"
done

# Show all 256 colors with color number
function spectrum_ls() {
  setopt localoptions nopromptsubst
  local ZSH_SPECTRUM_TEXT=${ZSH_SPECTRUM_TEXT:-Arma virumque cano Troiae qui primus ab oris}
  for code in {000..255}; do
    print -P -- "$code: ${FG[$code]}${ZSH_SPECTRUM_TEXT}%{$reset_color%}"
  done
}

# Show all 256 colors where the background is set to specific color
function spectrum_bls() {
  setopt localoptions nopromptsubst
  local ZSH_SPECTRUM_TEXT=${ZSH_SPECTRUM_TEXT:-Arma virumque cano Troiae qui primus ab oris}
  for code in {000..255}; do
    print -P -- "$code: ${BG[$code]}${ZSH_SPECTRUM_TEXT}%{$reset_color%}"
  done
}
