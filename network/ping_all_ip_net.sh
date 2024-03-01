#!/bin/bash

# Запитуємо базову частину IP-адреси
echo -n "Entre votre plage IP pour faire le ping (ex. 192.168.1): "
read base_ip

# Виконуємо пінг для кожної адреси в діапазоні
for i in $(seq 1 254); do
    ping -c 1 -W 1 ${base_ip}.$i | grep "from" &
done

