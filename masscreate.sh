#!/bin/bash
# Default values
prefix="vu"
count=1000
password=""
# Function to display usage
usage() {
    echo "Usage: $0 --prefix <prefix> --count <number_of_users> --pass <password>"
    exit 1
}

# Parse command line arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --prefix) prefix="$2"; shift ;;
        --count) count="$2"; shift ;;
        --pass) password="$2"; shift ;;
        *) usage ;;
    esac
    shift
done
# Check if password is set
if [ -z "$password" ]; then
    echo "Error: Password must be specified with --pass option."
    usage
fi
# Create users
for ((i=0; i<count; i++)); do
    # Format the user suffix
    suffix=$(printf "%03d" $i)
    username="${prefix}${suffix}"

   # Check if the user already exists
    if id "$username" &>/dev/null; then
        echo "User $username already exists, skipping..."
    else 
    # Create the user
     sudo useradd -m "$username" -p "$(openssl passwd -1 "$password")"

    # For demonstration, just print the user that would be created
    echo "Creating user: $username with password: $password"
   fi
done
