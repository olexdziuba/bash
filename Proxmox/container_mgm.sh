#!/bin/bash
# File: cont_mgm.sh

# Global variables
TPLID=111               # Container template ID
HOSTNAMEPREFIX=410-     # Prefix for container names
IPPREFIX=10.10.0        # IP address prefix
DATE=$(date +%F-%H:%M)  # Date for naming the backup directory

# Request to enter the name of the file with the list of students
echo "Please enter the name of the file with the list of students (for example, montest.csv):"
read FILE

# Check if the file exists
if [ ! -f "$FILE" ]; then
    echo "File not found: $FILE"
    exit 1
fi

while true; do
    clear
    echo "Menu:"
    echo "1. Create container"
    echo "2. Start container"
    echo "3. Stop container"
    echo "4. Backup container"
    echo "5. Snapshot container"
    echo "6. Backup containers (stop mode)"
    echo "0. Exit"
    read -p "Select an option: " choice

    case $choice in
        1)
            echo "You have chosen to create a container."
            while IFS=';' read -r CTID IP ETUD PASSWORD LASTNAME FIRSTNAME; do
                echo "--Creating container $CTID--------------"
                pct clone $TPLID $CTID --full=yes --hostname=$HOSTNAMEPREFIX$ETUD --storage=DATA
                pct set $CTID --net0 name=eth0,bridge=vmbr0,ip=$IPPREFIX.$IP/19,gw=10.10.0.1
                echo
            done < "$FILE"
            ;;
        2)
            echo "You have chosen to start a container."
            while IFS=';' read -r CTID IP ETUD PASSWORD LASTNAME FIRSTNAME; do
                echo "--Starting container $CTID--------------"
                pct start $CTID
            done < "$FILE"
            ;;
        3)
            echo "You have chosen to stop a container."
            while IFS=';' read -r CTID IP ETUD PASSWORD LASTNAME FIRSTNAME; do
                echo "--Stopping container $CTID--------------"
                pct stop $CTID
            done < "$FILE"
            ;;
        4)
            echo "You have chosen to backup a container."
            while IFS=';' read -r CTID IP ETUD PASSWORD LASTNAME FIRSTNAME; do
                BACKUP_DIR="./$DATE"
                mkdir -p "$BACKUP_DIR"
                echo "--Backup of container $CTID-------------"
                pct pull $CTID /var/www/src/App.js "$BACKUP_DIR/$ETUD.js"
            done < "$FILE"
            ;;
        5)
            echo "You have chosen to make a snapshot of a container."
            while IFS=';' read -r CTID IP ETUD PASSWORD LASTNAME FIRSTNAME; do
                echo "--Snapshot of container $CTID-----------"
                pct snapshot $CTID "base"
                echo
            done < "$FILE"
            ;;
        6)
            echo "You have chosen to backup containers (stop mode)."
            BACKUP_DIR="./backups/$DATE"
            mkdir -p "$BACKUP_DIR"
            while IFS=';' read -r CTID IP ETUD PASSWORD LASTNAME FIRSTNAME; do
                echo "--Stopping container $CTID for backup--"
                pct stop $CTID && \
                echo "--Backing up container $CTID--" && \
                vzdump $CTID --mode stop --storage local --remove 0 --compress gzip --dumpdir "$BACKUP_DIR" && \
                echo "--Starting container $CTID after backup--" && \
                pct start $CTID
                echo
            done < "$FILE"
            ;;
        0)
            echo "You have chosen to exit the menu. Goodbye!"
            exit 0
            ;;
        *)
            echo "Invalid choice. Please try again."
            ;;
    esac

    read -p "Press Enter to continue..."
done

