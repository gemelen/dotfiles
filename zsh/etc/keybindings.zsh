#!/usr/bin/env zsh

# use `cat -v`

# Make sure that the terminal is in application mode when zle is active, since
# only then values from $terminfo are valid
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init() {
    echoti smkx
  }
  function zle-line-finish() {
    echoti rmkx
  }
  zle -N zle-line-init
  zle -N zle-line-finish
fi

bindkey -v

# Edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line

# [Esc-Esc] - Up a line of history
bindkey '^[^[' edit-command-line

# [PageUp] - Up a line of history
bindkey -M viins "${terminfo[kpp]}" up-line-or-history
bindkey -M vicmd "${terminfo[kpp]}" up-line-or-history
# [PageDown] - Down a line of history
bindkey -M viins "${terminfo[knp]}" down-line-or-history
bindkey -M vicmd "${terminfo[knp]}" down-line-or-history
# [Home] - Go to beginning of line
bindkey -M viins "${terminfo[khome]}" beginning-of-line
bindkey -M vicmd "${terminfo[khome]}" beginning-of-line
# [End] - Go to end of line
bindkey -M viins "${terminfo[kend]}"  end-of-line
bindkey -M vicmd "${terminfo[kend]}"  end-of-line
# [Shift-Tab] - move through the completion menu backwards
bindkey -M viins "${terminfo[kcbt]}" reverse-menu-complete
bindkey -M vicmd "${terminfo[kcbt]}" reverse-menu-complete
# [Backspace] - delete backward
bindkey -M viins '^?' backward-delete-char
bindkey -M vicmd '^?' backward-delete-char
# [Delete] - delete forward
if [[ -n "${terminfo[kdch1]}" ]]; then
  bindkey -M viins "${terminfo[kdch1]}" delete-char
  bindkey -M vicmd "${terminfo[kdch1]}" delete-char
else
  bindkey -M viins "^[[3~" delete-char
  bindkey -M viins "^[3;5~" delete-char
  bindkey -M vicmd "^[[3~" delete-char
  bindkey -M vicmd "^[3;5~" delete-char
fi
# [Ctrl-RightArrow] - move forward one word
bindkey -M viins '^[[1;5C' forward-word
bindkey -M vicmd '^[[1;5C' forward-word
# [Ctrl-LeftArrow] - move backward one word
bindkey -M viins '^[[1;5D' backward-word
bindkey -M vicmd '^[[1;5D' backward-word
# [Ctrl-r] - Search backward incrementally
bindkey '^R' history-incremental-search-backward
# [Esc-.]
bindkey "^[m" copy-prev-shell-word # ?insert-last-word

# fzf
[[ -f /etc/zsh_completion.d/fzf-key-bindings ]] && source "/etc/zsh_completion.d/fzf-key-bindings"
