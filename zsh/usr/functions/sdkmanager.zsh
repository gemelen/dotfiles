SDKMAN_DIR="$HOME/.sdkman"
if [[ -d "${SDKMAN_DIR}" && -s "${SDKMAN_DIR}/bin/sdkman-init.sh" ]]; then
  export SDKMAN_DIR
  source "${SDKMAN_DIR}/bin/sdkman-init.sh"
else
  echo "sdkmanager is not installed" >&2
fi
