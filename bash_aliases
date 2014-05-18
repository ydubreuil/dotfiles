init_dot_aliases() {
  local slashes; slashes=
  for c in $(seq 1 10); do
    slashes="../${slashes}"
    alias .$c="cd ${slashes}"
  done
}; init_dot_aliases

newpass() {
  local length; length=$1
  [ -z "$length" ] && length=12
  apg -a 1 -m $length -x $length -n 1 -E \'\"
}
