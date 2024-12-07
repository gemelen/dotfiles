autoload -U promptinit
autoload -Uz vcs_info

zstyle :compinstall filename "${ZDOTDIR}/.zshrc"
zstyle ':vcs_info:git:*' formats '%b'

setopt prompt_subst

precmd() {
    vcs_info
    PROMPT="%m %~ %K{cyan}${vcs_info_msg_0_}%k%(#.#.>) "
}
