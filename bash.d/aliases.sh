# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && \
    eval "$(dircolors -b ~/.dircolors)" || \
    eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# some cd aliases
alias ..='cd ..'
alias ...='cd ../..'

init_dot_aliases() {
  local slashes
  slashes="../.."

  for c in $(seq 3 10)
  do
    slashes="../${slashes}"
    alias .$c="cd ${slashes}"
  done
}; init_dot_aliases

# generate new password
newpass() {
  local length; length=$1; [ -z "$length" ] && length=12
  apg -a 1 -m $length -x $length -n 1 -E \'\"
}


ssh() {
  local args=( "${@}" )
  local i x
  for (( i=0; i<${#args[@]}; i++ )) ; do
    x=${args[i]}
    [[ -z ${x%%-[bcDeFIiLlmOopRSWw]} ]] && (( i++ )) && continue
    [[ -z ${x%%-*} ]] && continue
    x=${x#http://}
    x=${x#https://}
    x=${x/@http:\/\//@}
    x=${x/@https:\/\//@}
    args[i]=${x}
    break
  done
  command ssh "${args[@]}"
}

tabandstrip() {
  local args=( "${@}" )
  local i
  for (( i=0; i<${#args[@]}; i++ )) ; do
    local filename=${args[i]}
    unexpand -t 4 -a "$filename" | \
      sed -E "s/[[:space:]]$//" | \
      sponge "$filename"
  done
}

# do something on all git repositories found under the working directory
# example: allgit grep mystring
gitall() {
  find * -type d -name .git | \
    while read repo; do
      (cd $(dirname $repo); git "$@")
    done
}

# do something on all git repositories found under the working directory
# example: allgit grep mystring
gitallv() {
  find * -type d -name .git | \
    while read repo; do
      local repo_dir=$(dirname $repo)
      echo "==> in $repo_dir"
      (cd $repo_dir; git "$@")
    done
}


psme() {
  ps awwf -U $(id -u)
}

