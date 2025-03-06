#!/usr/bin/env zsh

_async_load() {
  local script_path=$1
  
  {
    test -f "$script_path" && {
      source "$script_path"
      zcompile "$script_path"
    }
  } &!
}

source "${ZDOTDIR}"/plugins/github.zsh-defer.zsh
autoload -Uz zsh-defer
_deferred_load() {
  local script_path=$1
  
  {
    if test -f "$script_path"; then
      zsh-defer zcompile "$script_path"
      zsh-defer source "$script_path"
    fi
  }
}

# https://zsh.sourceforge.io/Doc/Release/Expansion.html#Parameter-Expansion
# ${file%pattern} transformed into string stripped of pattern if it's present

_dirwalk() {
  local dir_path=$1
  local callback_func=$2
  local pre_dir="${dir_path}/stage.pre.d"
  local post_dir="${dir_path}/stage.post.d"
  
  if test -d "$pre_dir"; then
    for file in "$pre_dir"/*(.N); do
      test "${file%.zwc}" != "$file" && continue
      "$callback_func" "$file"
    done
  fi
  
  for file in "$dir_path"/*(.N); do
    test "${file%.zwc}" != "$file" && continue
    "$callback_func" "$file"
  done
  
  if test -d "$post_dir"; then
    for file in "$post_dir"/*(.N); do
      test "${file%.zwc}" != "$file" && continue
      "$callback_func" "$file"
    done
  fi
}

source_directory() {
  local dir_path=$1
  local callback_func=source
  _dirwalk $dir_path $callback_func
}

defer_directory() {
  local dir_path=$1
  local callback_func=_deferred_load
  _dirwalk $dir_path $callback_func
}
