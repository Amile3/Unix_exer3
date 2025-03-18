#!/bin/bash

# Script to add users vu000 to vu009 to the sudo group

# Loop through user numbers from 0 to 9
for i in {0..9}; do
    # Format user as vuXXX
    user="vu$(printf "%03d" $i)"
    
    # Check if user exists
    if id "$user" &>/dev/null; then
        # Add user to the sudo group
        sudo usermod -aG sudo "$user"
        echo "Added $user to the sudo group."
    else
        echo "User $user does not exist."
    fi
done
