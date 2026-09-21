#!/bin/bash

RED=$'\e[31m'
GREEN=$'\e[32m'
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

Help(){
    echo "1123"
}

Users() {
    banner "Users"

    show whoami     whoami
    show hostname   hostname
    show id         id
    show groups     groups
    show users      cat /etc/passwd
}

SUGID() {
    local path=$1

    banner "SUID / SGID"

    if [[ -n "$path" ]]; then
        echo "$GREEN Path: $path $RESET"

        show "SUID files" find "$path" -type f -perm -4000 2>/dev/null
        show "SGID files" find "$path" -type f -perm -2000 2>/dev/null
    else
        show "SUID files" find / -type f -perm -4000 2>/dev/null
        show "SGID files" find / -type f -perm -2000 2>/dev/null
    fi
}

System() {
    banner "System"

    show uname             uname -a
    show os-release        cat /etc/os-release
    show "version system"  cat /proc/version
    show "disk space"      df -h
}

Network() {
    banner "Network"

    show hosts  cat /etc/hosts
    show ss     ss -tulnp
}

Other() {
    banner "Other"

    show "crontab (last 10)" tail -n 10 /etc/crontab
    show "history (last 10)" tail -n 10 ~/.bash_history
}

arguments() {
    local -a args=()
    local arg

    for arg in "$@"; do
        if [[ ! " ${args[*]} " =~ " $arg " ]]; then
            args+=("$arg")

            # Always display the help message when the "help" argument is provided.
            if [ "$arg" = "help" ]; then
                Help

                return
            fi

        fi
    done

    if [[ ${#args[@]} -eq 0 ]]; then
        Users
        SUGID
        System
        Network
        Other
        return

    fi

    for arg in "${args[@]}"; do
        case "$arg" in
            u)
                Users
                ;;

            ss)
                SUGID /
                ;;

            ss=/*)
                local path="${arg#*=}"
                SUGID "$path"
                ;;

            s)
                System
                ;;

            n)
                Network
                ;;

            o)
                Other
                ;;

            *)
                printf 'Unknown argument: %s\n' "$arg" >&2
                ;;
        esac
    done
}

### Start ###
arguments "$@"