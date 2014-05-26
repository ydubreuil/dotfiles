#!/bin/bash
set -e

FILES="bashrc bash.d dependencies gitconfig gitignore inputrc liquidprompt.theme liquidpromptrc pythonstartup tmux.conf"

# absolute path
HERE=$(dirname $(readlink -f $0))

for FILE in $FILES; do
  if [[ ! -h "$HOME/.$FILE" ]]; then
    [[ -f "$HOME/.$FILE" ]] && rm "$HOME/.$FILE"
    ln -s "$HERE/$FILE" "$HOME/.$FILE"
  fi
done
