#!/bin/bash
# File: cont_mgm.sh

# Global variables
TPLID=111               # Container template ID
HOSTNAMEPREFIX=410-     # Prefix for container names
IPPREFIX=10.10.2        # IP address prefix
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
    echo "4. Backup fichier App.js"
    echo "5. Snapshot container"
    echo "6. Backup containers (stop mode)"
    echo "7. Backup containers (suspend mode)"
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
            echo "You have chosen to backup un fichier App.js."
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
            echo "Is your backup directory /mnt/data/dump? (Y/N)"
            read answer  # Lire la réponse de l'utilisateur.
            if [[ $answer == [Yy]* ]]; then
                BACKUP_DIR="/mnt/data/dump"
                # Continuer avec le processus de sauvegarde comme avant.
                while IFS=';' read -r CTID IP ETUD PASSWORD LASTNAME FIRSTNAME; do
                     echo "--Stopping container $CTID for backup--"
                     pct stop $CTID && \
                     echo "--Backing up container $CTID--" && \
                     vzdump $CTID --mode stop --remove 0 --compress lzo --dumpdir "$BACKUP_DIR" && \
                     #-- compress gzip (more compres) lzo (fast compress)
                     echo "--Starting container $CTID after backup--" && \
                     pct start $CTID
                     echo
                done < "$FILE"
            else
              echo "Please change the backup directory and try again."
                # Ici, vous pouvez soit demander à l'utilisateur de saisir un nouveau répertoire,
               # soit simplement retourner au menu principal.
                # Retour au menu principal.
            fi
            ;;
        7)
            echo "You have chosen to backup containers (suspend mode)."
            echo "Is your backup directory /mnt/data/dump? (Y/N)"
            read answer  # Lire la réponse de l'utilisateur.
            if [[ $answer == [Yy]* ]]; then
              BACKUP_DIR="/mnt/data/dump"
              # Continuer avec le processus de sauvegarde comme avant.
              while IFS=';' read -r CTID IP ETUD PASSWORD LASTNAME FIRSTNAME; do
                 echo "--Suspending container $CTID for backup--"
                 # Remplacer --mode stop par --mode suspend pour minimiser l'interruption
                 vzdump $CTID --mode suspend --remove 0 --compress lzo --dumpdir "$BACKUP_DIR" && \ 
                 #-- compress gzip (more compress) lzo (fast compress) 
                 echo "Backup of container $CTID completed."
                # Pas besoin de redémarrer le container, car le mode suspend le reprend automatiquement
                 echo
               done < "$FILE"
            else
              echo "Please change the backup directory and try again."
                # Ici, vous pouvez soit demander à l'utilisateur de saisir un nouveau répertoire,
               # soit simplement retourner au menu principal.
                # Retour au menu principal.
            fi
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

