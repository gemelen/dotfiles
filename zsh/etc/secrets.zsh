#!/usr/bin/env zsh

# Github

if test $(test $XDG_CURRENT_DESKTOP = 'KDE') -o $(test $XDG_SESSION_DESKTOP = 'KDE'); then
  GH_REGISTRY_RO=$(kwallet-query -f local kdewallet -r gh_registry_ro)
  GH_REGISTRY_RW=$(kwallet-query -f local kdewallet -r gh_registry_rw)

  export GH_REGISTRY_RO GH_REGISTRY_RW
fi
