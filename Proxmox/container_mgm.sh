#!/bin/bash
# Файл: cont_mgm.sh

# Глобальні змінні
TPLID=111               # ID шаблону контейнера
HOSTNAMEPREFIX=410-     # Префікс для імен контейнерів
IPPREFIX=10.10.0        # Префікс IP адрес
DATE=$(date +%F-%H:%M)  # Дата для іменування каталогу резервних копій

# Запит на введення імені файлу зі списком студентів
echo "Будь ласка, введіть ім'я файлу зі списком студентів (наприклад, montest.csv):"
read FILE

# Перевірка на існування файлу
if [ ! -f "$FILE" ]; then
    echo "Файл не знайдено: $FILE"
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
    echo "6. Зробити снапшот всіх контейнерів"
    echo "0. Exit"
    read -p "Select an option: " choice

    case $choice in
        1)
            echo "Ви вибрали створення контейнера."
            while IFS=';' read -r CTID IP ETUD PASSWORD LASTNAME FIRSTNAME; do
                echo "--Створення контейнера $CTID--------------"
                pct clone $TPLID $CTID --full=yes --hostname=$HOSTNAMEPREFIX$ETUD --storage=DATA
                pct set $CTID --net0 name=eth0,bridge=vmbr0,ip=$IPPREFIX.$IP/19,gw=10.10.0.1
                echo
            done < "$FILE"
            ;;
        2)
            echo "Ви вибрали запуск контейнера."
            while IFS=';' read -r CTID IP ETUD PASSWORD LASTNAME FIRSTNAME; do
                echo "--Запуск контейнера $CTID--------------"
                pct start $CTID
            done < "$FILE"
            ;;
        3)
            echo "Ви вибрали зупинку контейнера."
            while IFS=';' read -r CTID IP ETUD PASSWORD LASTNAME FIRSTNAME; do
                echo "--Зупинка контейнера $CTID--------------"
                pct stop $CTID
            done < "$FILE"
            ;;
        4)
            echo "Ви вибрали зробити резервну копію контейнера."
            while IFS=';' read -r CTID IP ETUD PASSWORD LASTNAME FIRSTNAME; do
                BACKUP_DIR="./$DATE"
                mkdir -p "$BACKUP_DIR"
                echo "--Резервна копія контейнера $CTID-------------"
                pct pull $CTID /var/www/src/App.js "$BACKUP_DIR/$ETUD.js"
            done < "$FILE"
            ;;
        5)
            echo "Ви вибрали зробити знімок контейнера."
            while IFS=';' read -r CTID IP ETUD PASSWORD LASTNAME FIRSTNAME; do
                echo "--Знімок контейнера $CTID-----------"
                pct snapshot $CTID "base"
                echo
            done < "$FILE"
            ;;
        6)
            echo "Ви вибрали зробити снапшот всіх контейнерів."
            SNAPSHOT_DIR="$CONTAINER_PATH/snapshots"
            mkdir -p "$SNAPSHOT_DIR"
            while IFS=';' read -r CTID IP ETUD PASSWORD LASTNAME FIRSTNAME; do
                echo "--Снапшот контейнера $CTID-----------"
                vzdump $CTID --mode snapshot --dumpdir $SNAPSHOT_DIR
                echo
            done < "$FILE"
            ;;
        0)
            echo "Ви обрали вийти з меню. До побачення!"
            exit 0
            ;;
        *)
            echo "Недійсний вибір. Спробуйте ще раз."
            ;;
    esac

    read -p "Натисніть Enter для продовження..."
done

