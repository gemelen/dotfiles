SNAP=/snap/bin
HOMEDIR_PATH=$HOME/bin
CS_PATH=~/.local/share/coursier/bin

PATH=$HOMEDIR_PATH:$CS_PATH:$SNAP:$PATH

# Ensure path arrays do not contain duplicates.
typeset -gU path fpath

export -U PATH
