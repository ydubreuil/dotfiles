#!/bin/bash
set -e

FILES="bashrc bash.d dependencies gitconfig gitignore gtkrc-2.0 inputrc liquidprompt.theme liquidpromptrc pam_environment pythonstartup tmux.conf vim vimrc"

# absolute path
HERE=$(dirname $(readlink -f $0))

for FILE in $FILES; do
  source=$HERE/$FILE
  target=$HOME/.$FILE
  
  if [[ -d "$target" && ! -h "$target" ]]; then
    echo "skipping directory $target"
    continue
  fi

  [[ "$(readlink -f $source)" == "$(readlink -f $target)" ]] && continue
  echo "linking $source to $target"
  
  [[ -r "$target" ]] && rm "$HOME/.$FILE"
  ln -s "$HERE/$FILE" "$HOME/.$FILE"
done
