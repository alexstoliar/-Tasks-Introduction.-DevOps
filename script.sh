#!/bin/bash

# Script to display OS version, users with Bash shell, and open ports.

echo "------------------------------------"
echo "Operating System Information:"
echo "------------------------------------"
if [[ -f /etc/os-release ]]; then
    cat /etc/os-release
else
    echo "OS information not found in /etc/os-release."
fi
echo "Kernel Version: $(uname -r)"
echo

echo "------------------------------------"
echo "Users with Bash Shell:"
echo "------------------------------------"
awk -F: '/\/bin\/bash$/{print $1}' /etc/passwd
echo

echo "------------------------------------"
echo "Open Ports:"
echo "------------------------------------"
if command -v netstat &> /dev/null; then
    netstat -tuln | awk 'NR==1 || $6=="LISTEN"'
elif command -v ss &> /dev/null; then
    ss -tuln
else
    echo "Neither netstat nor ss command found to display open ports."
fi
echo

echo "Script Execution Completed."
