#!/bin/bash
# File: change_passwords.sh

while true; do
    read -p "Please enter the container ID (CTID) or 'exit' to quit: " CTID
    # Checks if the user wants to exit
    if [ "$CTID" == "exit" ]; then
        echo "Goodbye!"
        exit 0
    fi
    # Checks if the container ID is an integer
    if ! [[ "$CTID" =~ ^[0-9]+$ ]]; then
        echo "Please enter a valid container ID (integer)."
        continue
    fi
    read -s -p "Please enter the new password for the container $CTID: " PASSWORD
    echo  # Adds a new line after the password entry

    # Starting the container with the specified CTID
    echo "Starting the container $CTID"
    pct start $CTID
    # Checks if the container has started
    if [ "$(pct status $CTID | grep -oP 'status:\s*\K\w+')" != "running" ]; then
        echo "The container $CTID is not running!"
        continue
    fi

    # Changing the password for the root user to the password from the file
    echo "Changing the password for container $CTID"
    pct enter $CTID <<EOF
echo "root:$PASSWORD" | chpasswd
exit
EOF

    # Stopping the container
    echo "Stopping the container $CTID"
    pct stop $CTID

    # Display the message with the container ID and the new password
    echo "Password changed for container $CTID: $PASSWORD"
done
