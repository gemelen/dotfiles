#!/usr/bin/env zsh
for xdg_dir in "XDG_CONFIG_HOME" "XDG_DATA_HOME" "XDG_CACHE_HOME" "XDG_RUNTIME_DIR"
do
  test -d "${(P)xdg_dir}" || (echo "${xdg_dir}=${(P)xdg_dir} configured but doesn't exist" && mkdir -p "${(P)xdg_dir}")
done

# XDG configuration
_JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java

AWS_CONFIG_FILE="$XDG_CONFIG_HOME"/aws/config
AWS_DATA_PATH="$XDG_CONFIG_HOME"/aws/models
AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME"/aws/credentials

CARGO_HOME="$XDG_DATA_HOME"/cargo

GNUPGHOME="${XDG_DATA_HOME}"/gnupg

GOPATH="$XDG_DATA_HOME"/go

GTK_RC_FILES="$XDG_CONFIG_HOME"/gtk-1.0/gtkrc
GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc

KUBECONFIG="${XDG_CONFIG_HOME}"/kube/config
KUBECACHEDIR="$XDG_CACHE_HOME"/kube

MAVEN_OPTS=-Dmaven.repo.local="$XDG_DATA_HOME"/maven/repository

NVM_DIR="$XDG_DATA_HOME"/nvm
NPM_CONFIG_TMP="$XDG_RUNTIME_DIR"/npm
NPM_CONFIG_CACHE="$XDG_CACHE_HOME"/npm

RIPGREP_CONFIG_PATH=${XDG_CONFIG_HOME}/rg.conf

SDKMAN_DIR="${XDG_DATA_HOME}"/sdkman

XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority

HOMEDIR_PATH=$HOME/.local/bin
CS_PATH="${XDG_DATA_HOME}"/coursier/bin

PATH=$HOMEDIR_PATH:$CS_PATH:$PATH

# Ensure path arrays do not contain duplicates.
typeset -gU path fpath

export AWS_CONFIG_FILE AWS_DATA_PATH AWS_SHARED_CREDENTIALS_FILE \
  GNUPGHOME GTK_RC_FILES GTK2_RC_FILES \
  NVM_DIR NPM_CONFIG_CACHE NPM_CONFIG_TMP \
  KUBECONFIG RIPGREP_CONFIG_PATH SDKMAN_DIR XAUTHORITY \
  _JAVA_OPTIONS
export KUBECACHEDIR
export CARGO_HOME GOPATH MAVEN_OPTS
export -U PATH
