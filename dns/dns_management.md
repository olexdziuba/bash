# DNS Management Script

This script provides a menu-based interface to add or delete DNS records using dnsmasq as the DNS server. It allows users to add or remove DNS records by providing the IP address and domain.

## Usage

1. Run the script using the command `./dns_management.sh`.
2. Choose an option from the menu:
   - Option 1: Add DNS
   - Option 2: Delete DNS
   - Option 3: Exit

## Functionality

- Option 1: Add DNS
   - Reads DNS records from the `add_dns.txt` file.
   - Displays the list of DNS records.
   - Prompts the user to confirm adding the DNS records.
   - Adds each DNS record to the dnsmasq configuration file.
   - Restarts the dnsmasq service.
   - Displays a success message for each DNS record added.

- Option 2: Delete DNS
   - Reads DNS records from the `del_dns.txt` file.
   - Displays the list of DNS records.
   - Prompts the user to confirm deleting the DNS records.
   - Deletes each DNS record from the dnsmasq configuration file.
   - Restarts the dnsmasq service.
   - Displays a success message for each DNS record deleted.

- Option 3: Exit
   - Exits the script.

## Files

- `add_dns.txt`: Contains the list of DNS records to be added in the format "IP,Domain".
- `del_dns.txt`: Contains the list of DNS records to be deleted in the format "IP,Domain".

## Requirements

- This script requires dnsmasq to be installed and running as the DNS server.

## Note

- Ensure that the script has executable permissions (`chmod +x dns_management.sh`).
- Run the script with root privileges or as a user with sufficient permissions to modify dnsmasq configuration.

