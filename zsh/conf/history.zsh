setopt extended_history          # Write the history file in the ":start:elapsed;command" format.
setopt inc_append_history        # Write to the history file immediately, not when the shell exits.
setopt share_history             # Share history between all sessions.
setopt hist_ignore_dups          # Don't record an entry that was just recorded again.
setopt hist_find_no_dups         # Do not display a line previously found.
setopt hist_save_no_dups         # Don't write duplicate entries in the history file.
setopt hist_ignore_space         # Don't record an entry starting with a space.

HISTFILE=$ZDOTDIR/histfile
HISTSIZE=1000000000
SAVEHIST=$HISTSIZE

HISTORY_IGNORE="(#i)(cd|cd ..|clear|l|(${(j:|:k)aliases[(R)ls*]})(| *)|exit)"
