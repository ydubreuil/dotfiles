#!/bin/bash -e

usage() {
  echo "usage: $0 <target_dir> <recipient_name>"
  exit 1
}

if [[ $# -ne 2 ]]; then
  usage
fi

target="$(readlink -f "$1")"
if [[ ! -d $target ]]; then
  usage
fi

recipient="$2"

find . -type f | grep -v "~$" | while read filename; do
  mkdir -p "$target/$(dirname "$filename")"
  gpg -a -r "$recipient" -o "$target/${filename}.asc" -e "$filename"
done
