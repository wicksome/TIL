#!/usr/bin/env zsh

#alias sed="gsed"

# git
alias gs="git status"
alias gd="git diff"
alias gl='git lg1'
alias gc='git commit'

function git_find_branches()
{
    if [[ -z "$1" ]]; then
        echo "Usage: $FUNCNAME <branch>" >&2
        return 1
    fi

    if [[ -z "$2" ]]; then
        set -- "$1" "$(pwd)"
    fi

    if [[ ! -d "$2" ]]; then
        echo "Invalid dir specified: '${_dir}'"
        return 1
    fi

    local _branch="$1"
    local _dir="$2"

    echo "$(tput setaf 3)# root$(tput sgr0) $(cd $_dir; pwd)"
    # Subshell so we don't end up in a different dir than where we started.
    (
        local max_length=0 # 이 값으로 padding 설정할 것
        cd "$_dir"
        for sub in *; do
            [[ "$max_length" < "${#sub}" ]] && max_length=${#sub}
        done

        for sub in *; do
            [[ -d "${sub}/.git" ]] || continue
            local branches=$(cd "$sub"; git branch --all | grep "$_branch" | cut -c 3-)
            
            [[ -n $branches ]] || continue

            for branch in $branches; do
                # printf "$(tput setaf 2)%-5s$(tput sgr0) %s\n" $sub $branch
                printf "$(tput setaf 2)%s$(tput sgr0) %s\n" $sub $branch
            done
        done
    )
}

alias git_find_branches "$@"

function port() {
    lsof -i :"$1"
}
alias port='port $@'

alias dk='docker'
alias dkc='docker-compose'
