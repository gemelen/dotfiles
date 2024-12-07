##### nvm (node version manager) #####
# placeholder nvm shell function
# On first use, it will set nvm up properly which will replace the `nvm`
# shell function with the real one
nvm() {
  if [[ -d "${XDG_CONFIG_HOME}/nvm" ]]; then
    NVM_DIR="${XDG_CONFIG_HOME}/nvm"
    export NVM_DIR
    # shellcheck disable=SC1090
    source "${NVM_DIR}/nvm.sh"
    nvm "$@"
  else
    echo "nvm is not installed" >&2
    return 1
  fi
}
