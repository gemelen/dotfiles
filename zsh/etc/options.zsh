#!/usr/bin/env zsh

# https://zsh.sourceforge.io/Doc/Release/Options.html#Description-of-Options

# cd
setopt autocd
setopt autopushd
setopt pushd_minus
setopt pushd_silent
setopt pushd_to_home
setopt pushd_ignore_dups

# history
setopt share_history             # Share history between all sessions.
setopt extended_history          # Write the history file in the ":start:elapsed;command" format.
setopt inc_append_history        # Write to the history file immediately, not when the shell exits.
setopt hist_ignore_dups          # Don't record an entry that was just recorded again.
setopt hist_ignore_all_dups      # Older duplicate is trimmed on adding
setopt hist_ignore_space         # Don't record an entry starting with a space.
setopt hist_find_no_dups         # Do not display a line previously found.
setopt hist_lex_words            # Split history records with more accuracy
setopt hist_save_no_dups         # Don't write duplicate entries in the history file.
setopt hist_verify               # Show command with history expansion to user before running it

# prompt
setopt prompt_subst

# completion
setopt autolist                  # Automatically list choices on an ambiguous completion.
setopt automenu                  # Automatically use menu completion after the second consecutive request, overridden by MENU_COMPLETE.
setopt list_packed               # Make menu more compact

# globs
setopt glob_dots                 # Do not require a leading ‘.’ in a filename to be matched explicitly.

# behaviour
setopt print_exit_value          # Message if the command returned non-zero exit code
setopt no_flow_control           # Disable ^S/^Q
setopt no_beep
setopt no_list_beep              # (Do not) Beep on an ambiguous completion
