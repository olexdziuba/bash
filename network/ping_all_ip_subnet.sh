#!/bin/bash

# Prompt for network address and subnet mask
read -p "Enter the network address (e.g., 192.168.1.0): " network_address
read -p "Enter the subnet mask (e.g., 24): " subnet_mask

# Calculate the network address
network=$(ipcalc "$network_address/$subnet_mask" | grep "Network:" | awk '{print $2}')

# Perform ping for all addresses in the network
echo "Pinging IP addresses in the network $network ..."
for ((i=1; i<=254; i++))
do
    ip_address="$network.$i"
    ping -c 1 -W 1 "$ip_address" >/dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "Ping successful - $ip_address"
    fi
done
