# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=20000
HISTFILESIZE=20000

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

#export RBENV_ROOT="${HOME}/.rbenv"
#if [ -d "${RBENV_ROOT}" ]; then
#  export PATH="${RBENV_ROOT}/bin:${PATH}"
#  eval "$(rbenv init -)"
#fi

export PYTHONSTARTUP=$HOME/.pythonstartup
alias dquilt="quilt --quiltrc=${HOME}/.quiltrc-dpkg"

PATH="${PATH}:~/node_modules/.bin"

export GOROOT="${HOME}/apps/go"
export GOPATH="${HOME}/Personnel/go"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

for f in ~/.bash.d/*.sh; do
    [ -f "$f" ] && . $f
done

#export LP_PS1_FILE="${HOME}/.liquidprompt.ps1"

# Use the liquidprompt
source ~/.dependencies/liquidprompt/liquidprompt
