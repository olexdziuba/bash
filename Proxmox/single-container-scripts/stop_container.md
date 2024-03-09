# Container Stop Script for Proxmox VE

This script provides an interactive way to stop LXC containers on a Proxmox VE (Virtual Environment) server. It prompts the user to enter a container ID (CTID) and stops the specified container. This tool is especially useful for system administrators and users who manage multiple LXC containers in Proxmox VE.

## Features

- **Interactive**: Promptly asks for user input to select which container to stop.
- **Validation**: Checks if the entered container ID is a valid integer before attempting to stop the container.
- **User Feedback**: Provides success and error messages based on the operation outcome.

## Prerequisites

- A working Proxmox VE environment.
- User must have sufficient permissions to stop containers in Proxmox VE.
- The script must be run on the Proxmox VE host where the containers are located.

## Usage

To use this script, follow these steps:

1. Ensure you have shell access to your Proxmox VE host.
2. Save the script to a file, for example, `stop_container.sh`.
3. Make the script executable:
   ```bash
   chmod +x stop_container.sh
   
Run the script:
./stop_container.sh
Follow the interactive prompts:
Enter the container ID (CTID) of the container you wish to stop.
If successful, the script will indicate the container has been stopped.
If an invalid CTID is entered, the script will prompt for a valid integer ID.
Type exit to quit the script.

## Example

Please enter the container ID (CTID) or 'exit' to quit: 101
--Stopping container 101--
Container 101 has been successfully stopped.
Do you want to stop another container? (yes/no): no
Goodbye!

## Notes
This script assumes that pct command-line tool is available and configured correctly on the Proxmox VE host.
The script requires that the user running it has the necessary permissions to stop containers on the Proxmox VE system.
It is recommended to run this script from a secure and trusted account on the Proxmox VE host to prevent unauthorized container management operations.
Contributions
Contributions to this script are welcome! Please feel free to submit pull requests or open issues to suggest improvements or report bugs.

## License
This script is provided "as is", without warranty of any kind. Use it at your own risk.
