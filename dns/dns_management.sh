#!/bin/bash

# Function to add DNS record
add_dns_record() {
    ip=$1
    domain=$2

    # Check if IP address and domain already exist in DNS records
    if grep -q "^address=/$domain/$ip$" /etc/dnsmasq.conf; then
        echo "DNS record already exists for IP: $ip, Domain: $domain"
        return 1
    fi

    # Check for duplicate DNS records
    if grep -q "^address=/$domain/" /etc/dnsmasq.conf; then
        echo "Duplicate DNS record found for Domain: $domain"
        return 1
    fi

    # Add record to DNSmasq configuration file
    echo "address=/$domain/$ip" >> /etc/dnsmasq.conf

    # Restart DNSmasq service
    systemctl restart dnsmasq
    echo "DNS record added successfully for IP: $ip, Domain: $domain"
}

# Function to delete DNS record
delete_dns_record() {
    ip=$1
    domain=$2

    # Check if IP address and domain exist in DNS records
    if ! grep -q "^address=/$domain/$ip$" /etc/dnsmasq.conf; then
        echo "DNS record does not exist for IP: $ip, Domain: $domain"
        return 1
    fi

    # Remove record from DNSmasq configuration file
    sed -i "/address=\/$domain\/$ip/d" /etc/dnsmasq.conf

    # Restart DNSmasq service
    systemctl restart dnsmasq
    echo "DNS record deleted successfully for IP: $ip, Domain: $domain"
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
