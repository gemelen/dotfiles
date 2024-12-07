autoload -U colors
colors

# expects `grc` installed
if [[ "$TERM" != dumb ]] && (( $+commands[grc] )) ; then
  # Prevent grc aliases from overriding zsh completions.
  setopt complete_aliases

  # Supported commands
  cmds=(
    blkid common configure curl df diff dig du dummy \
    env fdisk free gcc id ifconfig iostat_sar ip ipaddr ipneighbor iproute \
    iptables iwconfig jobs k kubectl last lsattr lsblk lsmod lsof lspci mount mtr mvn \
    netstat nmap ntpdate osc ping ping2 podman ps semanageboolean semanagefcontext semanageuser sensors \
    showmount sockstat ss stat sysctl systemctl tcpdump traceroute tune2fs ulimit uptime vmstat whois yaml
  );

  # Set alias for available commands.
  for cmd in $cmds ; do
    if (( $+commands[$cmd] )) ; then
      alias $cmd="grc -s -e --colour=auto $cmd"
    fi
  done

  # Clean up variables
  unset cmds cmd
fi
