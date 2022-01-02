#!/bin/bash

# Pulling all git repositories in $1
function update {
    local BASE=~/projects
    if [ -n "$1" ]; then
        BASE="$PWD/$1"
    fi

    cd "$BASE" || return
    for i in */.git; do (
        echo "$i"
        cd "$i"/.. || return
        git pull
    ); done
    cd - || return
}

# SCP Send/Receive - Port number is not mandatory
function transfer {
    if [ "$1" = "send" ]; then
        if [ "$#" -ne 5 ] && [ "$#" -ne 6 ]; then
            echo "Usage(send): transfer send {path_for_file_to_send} {remote_username} {remote_address} {remote_folder_path} {port_number}"
            return
        fi
        if [ -z "$6" ]; then
            scp "$2" "$3@$4:$5"
        else
            scp "$2" "$3@$4:$5" -p "$6"
        fi
    elif [ "$1" = "receive" ]; then
        if [ "$#" -ne 5 ] && [ "$#" -ne 6 ]; then
            echo "Usage(receive): transfer receive {remote_username} {remote_address} {remote_file_path} {path_for_file_to_receive} {port_number}"
            return
        fi
        if [ -z "$6" ]; then
            scp "$2@$3:$4" "$5"
        else
            scp -p "$6" "$2@$3:$4" "$5"
        fi
    else
        echo "Usage(send): transfer send {path_for_file_to_send} {remote_username} {remote_address} {remote_folder_path} {port_number}"
        echo "Usage(receive): transfer receive {remote_username} {remote_address} {remote_file_path} {path_for_file_to_receive} {port_number}"
    fi
}

# Look for filenames which includes $1 recursively; starting directory $2(default: ".")
function ffile {
    if [ -n "$1" ]; then
        if [ -z "$2" ]; then
            find . -name "*$1*"
        else
            find "$2" -name "*$1*"
        fi
    fi
}

# Searches for $1 recursively; starting directory $2(default: ".")
function ftext {
    if [ -n "$1" ]; then
        if [ -z "$2" ]; then
            grep -iIHrnF --color=always "$1" .
        else
            grep -iIHrnF --color=always "$1" "$2"
        fi
    fi
}

# Go upwards
# Usage: up 3 -> results in cd ../../..
function up {
    local d=""
    limit=$1
    for ((i = 1; i <= limit; i++)); do
        d=$d/..
    done
    d=$(echo $d | sed 's/^\///')
    if [ -z "$d" ]; then
        d=..
    fi
    cd $d || return 0
}

# Backup file with date-time stamp
# Usage "backup filename.txt"
function backup {
    # Create backup folder if it does not exit
    if [ ! -d "$HOME/.backup" ]; then
        mkdir -p "$HOME/.backup"
    fi
    FILENAMETOBACKUP=$1-$(/bin/date +%Y%m%d%H%M).backup
    cp "$1" "$HOME/.backup/$FILENAMETOBACKUP"
}

# Create new directory and cd
function mkcd {
    mkdir -p "$1" && cd "$1" || return
}

# Zip file/folder, recursively
function zipf {
    zip -r "$1".zip "$1"
}

# Check site headers, following redirections
function headers {
    /usr/bin/curl -I -L "$@"
}

# https://blog.cloudflare.com/a-question-of-timing/
function dcurl {
  /usr/bin/curl -s "$@" -o /dev/null -w \
    "Cumulative duration in seconds\n`
    `DNS Lookup: %{time_namelookup}\n`
    `TCP Handshake: %{time_connect}\n`
    `SSL Handshake: %{time_appconnect}\n`
    `Preparing Actual Request: %{time_pretransfer}\n`
    `First Response: %{time_starttransfer}\n`
    `Total Response: %{time_total}\n`
    `Transferred Size: %{size_download}\n"
}
