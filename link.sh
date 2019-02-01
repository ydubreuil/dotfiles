#!/bin/bash
set -e

HERE="$(dirname "$(readlink -f "$0")")"

now=$(date +"%Y.%m.%d.%H.%M.%S")
pushd $HERE/homedir > /dev/null 2>&1

for file in .*; do
  if [[ $file == "." || $file == ".." ]]; then
    continue
  fi

  source="$HERE/homedir/$file"
  target="$HOME/$file"

  # skip existing links
  if [[ "$(readlink -f "$source")" == "$(readlink -f "$target")" ]]; then
    continue
  fi

  # if the target file already exists:
  if [[ -e ~/$file ]]; then
    backup="$HOME/.dotfiles_backup/$now/$file"
    mkdir -p "$HOME/.dotfiles_backup/$now"
    mv "$target" "$backup"
    echo "backup saved as $backup"
  fi
  # symlink might still exist
  unlink ~/$file > /dev/null 2>&1 || true
  # create the link
  ln -sf "$source" "$target"
  echo "linked $source to $target"
done

popd > /dev/null 2>&1

