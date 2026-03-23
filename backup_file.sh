#!/bin/bash

function backup_file () {
    if [ -f "$1" ]; then
        BACK="/tmp/$(basename "$1").$(date +%F).$$"
        echo "Backing up $1 to ${BACK}"
        if cp "$1" "$BACK"; then
            return 0   # success
        else
            echo "Error: Failed to copy $1 to ${BACK}" >&2
            return 1   # failure
        fi
    else
        echo "Error: File $1 does not exist." >&2
        return 2       # file not found
    fi
}

backup_file /etc/hosts
case $? in
    0) echo "Backup succeeded!" ;;
    1) echo "Backup failed during copy." ;;
    2) echo "Backup failed: file not found." ;;
    *) echo "Unknown error occurred." ;;
esac