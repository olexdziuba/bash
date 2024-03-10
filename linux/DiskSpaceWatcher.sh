#!/bin/bash

# Set variables
email="admin@localserver.com"

# Function for sending email
send_email() {
    subject="$1"
    message="$2"
    to="$3"
    echo -e "Subject:$subject\n\n$message" | sendmail "$to"
}

# Get volume information
volume_info=$(df -h / | awk 'NR==2 {printf "Taille du volume racine : %s\nEspace utilisé du volume : %s\nEspace disponible : %s\nPourcentage d’utilisation : %s", $2, $3, $4, $5}')


# Info about /
volume_size=$(echo "$volume_info" | awk '{print $5}')
used_space=$(echo "$volume_info" | awk '{print $6}')
available_space=$(echo "$volume_info" | awk '{print $7}')
usage_percentage=$(echo "$volume_info" | awk '{print $8}')

# Check usage percentage and send email accordingly
if [ "${usage_percentage%\%}" -ge 80 2>/dev/null ]; then



    # More than 80%, send email
    subject="Status - Disk Overloaded"
    message="$volume_info"
    send_email "$subject" "$message" "$email"
    echo "$message"
else
    # Tout est correct
    subject="Status / est correct"
    message="$volume_info\n\ntout est correct"
    send_email "$subject" "$message" "$email"
    echo "$message"
fi
