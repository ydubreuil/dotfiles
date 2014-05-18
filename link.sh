#!/bin/bash
set -e

FILES="bash_aliases bashrc gitconfig gitignore inputrc pythonstartup tmux.conf"

# absolute path
HERE=$(dirname $(readlink -f $0))

for FILE in $FILES; do
  if [[ ! -h "$HOME/.$FILE" ]]; then
    [[ -f "$HOME/.$FILE" ]] && rm "$HOME/.$FILE"
    ln -s "$HERE/$FILE" "$HOME/.$FILE"
  fi
done
