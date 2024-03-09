# Proxmox Container Management

This script allows managing containers in Proxmox using a simple text file with a list of students. The script includes functionality for creating, starting, stopping containers, creating backups, and snapshots of container states.

## Features

- **Container Creation**: Clones a container from a specified template.
- **Container Start**: Starts the specified containers.
- **Container Stop**: Stops the operation of specified containers.
- **App.js Backup**: Creates a backup of the `App.js` file from each container.
- **Container Snapshot**: Creates a snapshot of the container states.
- **Container Backup (stop mode)**: Creates a backup of the containers, stopping them beforehand.
- **Container Backup (suspend mode)**: Creates a backup of the containers, using suspend mode to minimize disruption in their operation.

## Usage

1. Launch the script in the terminal.
2. Enter the name of the file with the list of students when prompted (CSV format).
3. Select an option in the menu to perform operations on the containers.

## Student List File Format

The file must be in CSV format, where each line contains information about a student and the container to be created or managed. The file structure:

CTID;IP;ETUD;PASSWORD;LASTNAME;FIRSTNAME


- `CTID` - Container identifier.
- `IP` - The last part of the container's IP address.
- `ETUD` - Username or student identifier.
- `PASSWORD` - Password.
- `LASTNAME` - The student's last name.
- `FIRSTNAME` - The student's first name.

## Instructions

1. Download and save the script in your Proxmox VE system.
2. Make the script executable with the command:

chmod +x container_mgm_liste.sh


3. Run the script:

./container_mgm_liste.sh


4. Follow the on-screen instructions to perform operations with the containers.

## Menu Options

1. **Create Container** - Creates a new container with a predefined template for each student according to the information provided in the CSV file.
2. **Start Container** - Starts the already created containers for each student listed in the CSV file.
3. **Stop Container** - Stops the operation of containers for each student listed in the CSV file.
4. **Backup `App.js`** - Creates a backup of the `App.js` file from each container into a separate folder named with the date and time of the backup creation.
5. **Snapshot Container** - Creates a state snapshot for each container listed in the CSV file.
6. **Backup Containers (stop mode)** - Stops the containers, creates their full backups, and automatically restarts the containers after the backup process is complete.
7. **Backup Containers (suspend mode)** - Suspends the containers, creates their full backups with minimal disruption to their operation, and automatically resumes their operation after the backup process is complete.
0. **Exit** - Closes the menu and terminates the script operation.

## Author

Oleksandr Dziuba
