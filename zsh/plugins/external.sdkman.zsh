#!/usr/bin/env zsh

if [[ -d "${SDKMAN_DIR}" && -s "${SDKMAN_DIR}/bin/sdkman-init.sh" ]]; then
  source "${SDKMAN_DIR}/bin/sdkman-init.sh"
else
  echo "sdkmanager is not installed" >&2
fi
