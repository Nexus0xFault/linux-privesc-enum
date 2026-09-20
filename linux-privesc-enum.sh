#!/bin/bash

RED=$'\e[31m'
RESET=$'\e[0m'

banner() {
    local title=$1
    printf '%s\n' "#############################################"
    printf '%s\n' "| ${title}"
    printf '%s\n\n' "#############################################"
}

show() {
    local label=$1
    shift
    printf '%s%s:%s\n' "$RED" "$label" "$RESET"
    "$@"
    printf '\n'
}

banner "Users"
show whoami   whoami
show hostname hostname
show id       id
show groups   groups
show users    cat /etc/passwd

banner "System"
show uname       uname -a
show os-release  cat /etc/os-release
show "version system" cat /proc/version
show "disk space" df -h

banner "Network"
show hosts cat /etc/hosts

banner "Other"
show "crontab (last 10)" tail -n 10 /etc/crontab
show "history (last 10)" tail -n 10 ~/.bash_history