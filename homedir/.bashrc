#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
PS1='[\u@\h \W]\$ '

# no clutter here please!
if [[ -e "${HOME}/.bashrc.d" ]]; then
    pushd "${HOME}/.bashrc.d" > /dev/null 2>&1
    for file in *.sh; do
        source "$file"
    done
    popd > /dev/null 2>&1
fi
