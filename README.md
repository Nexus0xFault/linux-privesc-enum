# linux-privesc-enum
Bash-based Linux enumeration tool for security assessments, CTFs, and privilege escalation research.

## Overview
`linux-privesc-enum` is a simple Bash script designed to collect useful information from a Linux system during the enumeration phase of a security assessment.
The script gathers information about users, the operating system, kernel, disk space, network configuration, cron jobs, and shell history.

## Features
### Users
- Current user
- Hostname
- User and group IDs
- User groups
- Local users from /etc/passwd

### System
- Kernel information
- Operating system information
- /proc/version
- Disk usage

### Network
- /etc/hosts

### Other
- System crontab
- Last 10 entries from Bash history

## Installation
Clone the repository:
```bash
git clone https://github.com/Nexus0xFault/linux-privesc-enum.git
cd linux-privesc-enum
```
Make the script executable:
```bash
chmod +x linux-privesc-enum.sh
```

## Usage
Run the script:
```bash
./linux-privesc-enum.sh
```

## Example
The script organizes the collected information into several sections:
```
#############################################
| Users
#############################################

whoami:
hostname:
id:
groups:

#############################################
| System
#############################################

uname:
os-release:
version system:
disk space:

etc...
```

## Disclaimer
This project is intended for educational purposes, CTFs, authorized security assessments, and laboratory environments.
Do not use this tool against systems without proper authorization.

## License
MIT
