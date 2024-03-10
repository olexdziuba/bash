# sys_info_full.sh

`sys_info_full.sh` is a Bash script designed to provide a detailed overview of your system's health and status. It consolidates various checks into a single script, offering an interactive menu to select specific diagnostics or a complete system check. This tool is invaluable for system administrators and users who need quick insights into their system's performance and resource utilization.

## Features

- **Memory Usage**: Displays the current memory usage, including total, used, and free memory, in a human-readable format.
- **Disk Space and Partitioning**: Shows the disk space usage of all mounted filesystems and provides disk partitioning information using `fdisk`.
- **CPU Load/Uptime**: Reports the current CPU load and system uptime, offering a glimpse into the system's performance under load.
- **TCP Connections**: Counts the number of active TCP connections, which can be useful for network troubleshooting or monitoring.
- **Kernel Version**: Outputs the currently running kernel version, useful for debugging or system information purposes.
- **IP Information**: Displays IP addresses assigned to the system, aiding in network configuration and troubleshooting.

## Usage

To use `sys_info_full.sh`, simply execute the script in your terminal. Upon execution, you'll be greeted with a menu offering the following options:

1. Memory usage
2. CPU load/uptime
3. Number of TCP connections
4. Kernel version
5. Check All
0. Exit

Select an option by entering the corresponding number. If you wish to perform all checks at once, choose option 5.

## Requirements

This script is designed to run on Linux systems and requires no special dependencies outside of standard system utilities (`free`, `df`, `fdisk`, `uptime`, `cat`, `uname`, `ip`) which are typically pre-installed on most distributions.

## Installation

1. Clone this repository or download the script directly.
2. Make the script executable: `chmod +x sys_info_full.sh`.
3. Execute the script: `./sys_info_full.sh`.

## Customization

You can customize the script by editing it to add more checks or modify existing ones. It's structured in functions, making it easy to adjust to your specific needs.

## Contribution

Contributions to `sys_info_full` are welcome! Whether it's adding new features, improving existing ones, or reporting bugs, your input is valuable.

## License

This project is open-sourced under the MIT License. Feel free to use, modify, and distribute it as you see fit.

Enjoy monitoring and diagnosing your system with `sys_info_full`!
