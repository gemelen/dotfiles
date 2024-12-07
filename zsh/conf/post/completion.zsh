fpath=(
  $fpath
  $ZDOTDIR/usr/completions
  /usr/share/zsh/site-functions
)

# ignore grc in completion
_grc () {
    setopt localoptions
    # setopt extended_glob
    local environ e cmd
    local -a args
    local -a _comp_priv_prefix
    zstyle -a ":completion:${curcontext}:" environ environ
    for e in "${environ[@]}"
    do
        local -x "$e"
    done
    cmd="$words[1]"
    args=(
        '(-e --stderr)'{-e,--stderr}'[redirect stderr; do not automatically redirect stdout]'
        '(-s --stdout)'{-s,--stdout}'[redirect stdout; even with -e/--stderr]'
        '(-c <name>--config=<name>)'{-c+,--config=-}'[use <name> as configuration file for grcat]:file:_files'
        '--color=-[colo?urize output]:color:(on off auto)'
        '(-h --help)'{-h,--help}'[display help message and exit]'
        '--pty[run command in pseudotermnial (experimental)]'
        '*::arguments:{ _normal }'
    ) 
    _arguments -s -S $args
}

autoload -Uz compinit
autoload -Uz $fpath/*(.:t)

# completion; use cache if updated within 24h
if [[ -n $ZDOTDIR/.zcompdump(#qN.mh+24) ]]; then
  compinit -d $ZDOTDIR/.zcompdump;
else
  compinit -C;
fi;

# see https://github.com/zsh-users/zsh-completions
