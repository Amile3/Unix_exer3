#!/bin/bash

# Check if the script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root. Please use sudo."
    exit 1
fi

# Parse command line arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --username) username="$2"; shift ;;
        *) echo "Usage: $0 --username <username>"; exit 1 ;;
    esac
    shift
done

# If no username provided, disable all users with the prefix vu
if [ -z "$username" ]; then
    for user in $(getent passwd | cut -d: -f1 | grep '^vu[0-9][0-9][0-9]$'); do
        usermod -L "$user"  # Lock the user account
        echo "Disabled user: $user"
    done
else
    # Disable a specific user
    if id "$username" &>/dev/null; then
        usermod -L "$username"
        echo "Disabled user: $username"
    else
        echo "User $username does not exist."
    fi
fi

