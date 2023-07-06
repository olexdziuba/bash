#!/bin/bash

# Function to add DNS record
add_dns_record() {
    ip=$1
    domain=$2

    # Add record to DNSmasq configuration file
    echo "address=/$domain/$ip" >> /etc/dnsmasq.conf

    # Restart DNSmasq service
    systemctl restart dnsmasq
}

# Function to delete DNS record
delete_dns_record() {
    ip=$1
    domain=$2

    # Remove record from DNSmasq configuration file
    sed -i "/address=\/$domain\/$ip/d" /etc/dnsmasq.conf

    # Restart DNSmasq service
    systemctl restart dnsmasq
}

# Function to print DNS records
print_dns_records() {
    file=$1

    echo "List of DNS records:"
    while IFS=',' read -r ip domain; do
        echo "IP: $ip, Domain: $domain"
    done < "$file"
}

# Main menu
while true; do
    echo "Menu:"
    echo "1. Add DNS"
    echo "2. Delete DNS"
    echo "3. Exit"

    read -p "Please choose an option: " option

    case $option in
        1)
            # Adding DNS record
            print_dns_records "add_dns.txt"
            read -p "Do you want to add these DNS records? (Y/N) " choice
            if [[ $choice == "Y" || $choice == "y" ]]; then
                while IFS=',' read -r ip domain; do
                    add_dns_record "$ip" "$domain"
                done < "add_dns.txt"
            fi
            ;;
        2)
            # Deleting DNS record
            print_dns_records "del_dns.txt"
            read -p "Do you want to delete these DNS records? (Y/N) " choice
            if [[ $choice == "Y" || $choice == "y" ]]; then
                while IFS=',' read -r ip domain; do
                    delete_dns_record "$ip" "$domain"
                done < "del_dns.txt"
            fi
            ;;
        3)
            # Exit the script
            break
            ;;
        *)
            echo "Invalid option. Please choose a valid option."
            ;;
    esac
done
# add file "add_dns.txt" and "del_dns.txt"
