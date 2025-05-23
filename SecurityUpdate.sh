#!/bin/bash
# File: security_update.sh
# Description: Updates system packages and logs the process

LOG_FILE="/var/log/security_updates.log"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

echo "===== System Update: $TIMESTAMP =====" >> $LOG_FILE

# Update package lists
echo "Updating package lists..." >> $LOG_FILE
apt-get update >> $LOG_FILE 2>&1

# Upgrade packages
echo "Upgrading packages..." >> $LOG_FILE
apt-get upgrade -y >> $LOG_FILE 2>&1

# Perform dist-upgrade (optional)
echo "Performing dist-upgrade..." >> $LOG_FILE
apt-get dist-upgrade -y >> $LOG_FILE 2>&1

# Clean up
echo "Cleaning up..." >> $LOG_FILE
apt-get autoremove -y >> $LOG_FILE 2>&1
apt-get autoclean >> $LOG_FILE 2>&1

echo "Update completed." >> $LOG_FILE