#!/usr/bin/env zsh
# web_search from terminal

function open_command() {
  local open_cmd

  # define the open command
  case "$OSTYPE" in
    darwin*)  open_cmd='open' ;;
    cygwin*)  open_cmd='cygstart' ;;
    linux*)   [[ "$(uname -r)" != *icrosoft* ]] && open_cmd='nohup xdg-open' || {
                open_cmd='cmd.exe /c start ""'
                [[ -e "$1" ]] && { 1="$(wslpath -w "${1:a}")" || return 1 }
              } ;;
    msys*)    open_cmd='start ""' ;;
    *)        echo "Platform $OSTYPE not supported"
              return 1
              ;;
  esac

  # If a URL is passed, $BROWSER might be set to a local browser within SSH.
  # See https://github.com/ohmyzsh/ohmyzsh/issues/11098
  if [[ -n "$BROWSER" && "$1" = (http|https)://* ]]; then
    "$BROWSER" "$@"
    return
  fi

  ${=open_cmd} "$@" &>/dev/null
}

function web_search() {
  emulate -L zsh

  # define search engine URLS
  typeset -A urls
  urls=(
    $ZSH_WEB_SEARCH_ENGINES
    google          "https://www.google.com/search?q="
    bing            "https://www.bing.com/search?q="
    brave           "https://search.brave.com/search?q="
    yahoo           "https://search.yahoo.com/search?p="
    duckduckgo      "https://www.duckduckgo.com/?q="
    github          "https://github.com/search?q="
    stackoverflow   "https://stackoverflow.com/search?q="
    archive         "https://web.archive.org/web/*/"
    scholar         "https://scholar.google.com/scholar?q="
    youtube         "https://www.youtube.com/results?search_query="
    deepl           "https://www.deepl.com/translator#auto/auto/"
    dockerhub       "https://hub.docker.com/search?q="
    npmpkg          "https://www.npmjs.com/search?q="
    chatgpt         "https://chatgpt.com/?q="
    reddit          "https://www.reddit.com/search/?q="
    ppai            "https://www.perplexity.ai/search/new?q="
  )

  # check whether the search engine is supported
  if [[ -z "$urls[$1]" ]]; then
    echo "Search engine '$1' not supported."
    return 1
  fi

  # search or go to main page depending on number of arguments passed
  if [[ $# -gt 1 ]]; then
    # if search goes in the query string ==> space as +, otherwise %20
    # see https://stackoverflow.com/questions/1634271/url-encoding-the-space-character-or-20
    local param="-P"
    [[ "$urls[$1]" == *\?*= ]] && param=""

    # build search url:
    # join arguments passed with '+', then append to search engine URL
    url="${urls[$1]}$(omz_urlencode $param ${(s: :)@[2,-1]})"
  else
    # build main page url:
    # split by '/', then rejoin protocol (1) and domain (2) parts with '//'
    url="${(j://:)${(s:/:)urls[$1]}[1,2]}"
  fi

  open_command "$url"
}


alias bing='web_search bing'
alias brs='web_search brave'
alias google='web_search google'
alias yahoo='web_search yahoo'
alias ddg='web_search duckduckgo'

alias scholar='web_search scholar'
alias youtube='web_search youtube'
alias stackoverflow='web_search stackoverflow'
alias archive='web_search archive'
alias deepl='web_search deepl'
alias reddit='web_search reddit'

alias github='web_search github'
alias dockerhub='web_search dockerhub'
alias npmpkg='web_search npmpkg'

alias chatgpt='web_search chatgpt'
alias ppai='web_search ppai'

#add your own !bang searches here
alias wiki='web_search duckduckgo \!w'
alias news='web_search duckduckgo \!n'
alias map='web_search duckduckgo \!m'
alias image='web_search duckduckgo \!i'
alias ducky='web_search duckduckgo \!'

# other search engine aliases
if [[ ${#ZSH_WEB_SEARCH_ENGINES} -gt 0 ]]; then
  typeset -A engines
  engines=($ZSH_WEB_SEARCH_ENGINES)
  for key in ${(k)engines}; do
    alias "$key"="web_search $key"
  done
  unset engines key
fi
