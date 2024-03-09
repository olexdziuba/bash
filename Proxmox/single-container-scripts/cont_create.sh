#!/bin/bash
# File: cont_mgm.sh

echo "Please enter the Container template ID (e.g., 111):"
read TPLID

echo "Please enter the IP address prefix (e.g., 10.10.2):"
read IPPREFIX

echo "Please enter the Hostname prefix (e.g., 410-):"
read HOSTNAMEPREFIX

echo "Please enter the Container ID (e.g., 101):"
read CTID

echo "Please enter the last digits of the IP address (e.g., 15):"
read IP

# Using the provided values to create a container
echo "--Creating container $CTID--------------"
pct clone $TPLID $CTID --full=yes --hostname=$HOSTNAMEPREFIX$CTID --storage=DATA

# Assuming the gateway is always the same, if it's different it should also be asked from the user
pct set $CTID --net0 name=eth0,bridge=vmbr0,ip=$IPPREFIX.$IP/19,gw=10.10.0.1

echo "Container $CTID has been successfully created."
