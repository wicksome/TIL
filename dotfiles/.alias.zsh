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

function epoch2date() {
  if [[ "$1" == "help" ]]; then
    echo "Usage: epoch2date <timestamp> <timezone1> <timezone2> ..."
    echo "       epoch2date"
    echo "       epoch2date help"
    echo ""
    echo "Converts an epoch timestamp (in milliseconds or seconds) to different timezones."
    echo ""
    echo "Usage details:"
    echo "  epoch2date <timestamp> <timezone1> <timezone2> ..."
    echo "      - Converts the given epoch timestamp to the specified timezones."
    echo "      - The timestamp can be in milliseconds (13 digits) or seconds (10 digits)."
    echo "      - Example: epoch2date 1709122800000 \"America/New_York\" \"Asia/Tokyo\" \"Europe/London\""
    echo ""
    echo "  epoch2date"
    echo "      - Uses the current system time as the timestamp and converts it to local time and UTC."
    echo ""
    echo "  epoch2date help"
    echo "      - Displays this help message."
    echo ""
    echo "Example Output:"
    echo "  2025-02-28 15:00:00 (UTC)"
    echo "  2025-03-01 00:00:00 (+0900)"
    echo "  2025-02-28 10:00:00 (America/New_York)"
    echo "  2025-02-28 23:00:00 (Asia/Tokyo)"
    echo "  2025-02-28 15:00:00 (Europe/London)"
    return 0
  fi

  if [ -z "$1" ]; then
    # echo "Usage: epoch2date <epoch_time>"
    # return 1
    input=$(date +%s000) # 현재 시간의 epoch milliseconds
    #input=$(date +%s) # 현재 시간의 epoch seconds
  else
    input=$1
  fi

  # 입력 길이에 따라 밀리초인지 초인지 판단
  if [ ${#input} -gt 10 ]; then
    # 밀리초인 경우
    time_unit="milliseconds"
    epoch_time=$(($input / 1000))
  else
    # 초인 경우
    time_unit="seconds"
    epoch_time=$input
  fi

  if [ -z "$1" ]; then
    echo "${input} (${time_unit})"
  fi

  # UTC 변환
  utc=$(TZ=UTC date -j -f "%s" "$epoch_time" "+%Y-%m-%d %H:%M:%S")
  echo "${utc} (UTC)"

  # 로컬 시간 변환
  local=$(date -j -f "%s" "$epoch_time" "+%Y-%m-%d %H:%M:%S")
  offset=$(date +%z)
  echo "${local} ($offset)"

  shift
  timezones=("$@")
  for tz in  "${timezones[@]}"; do
    tz_time=$(TZ=$tz date -j -f "%s" "$epoch_time" "+%Y-%m-%d %H:%M:%S")
    echo "${tz_time} (${tz})"
  done
}

alias epoch2date="epoch2date $@"
alias epoch="epoch2date $@"
