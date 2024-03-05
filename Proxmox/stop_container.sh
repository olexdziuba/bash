#!/bin/bash
# File: stop_container.sh
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

    # Stopping the container with the specified CTID
    echo "--Stopping container $CTID--"
    pct stop $CTID
    if [ $? -eq 0 ]; then
        echo "Container $CTID has been successfully stopped."
    else
        echo "Failed to stop container $CTID. Please check if the container ID is correct and if you have the necessary permissions."
    fi

    # Asking the user if they want to stop another container or exit
    read -p "Do you want to stop another container? (yes/no): " answer
    if [[ $answer != [Yy]* ]]; then
        echo "Goodbye!"
        break
    fi
done
