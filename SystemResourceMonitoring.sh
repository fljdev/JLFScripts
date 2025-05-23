#!/bin/bash
# File: system_monitor.sh
# Description: Monitors CPU, memory, and disk usage on a Linux server

LOG_FILE="/var/log/system_monitor.log"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# Function to log resource usage
log_resources() {
    echo "===== System Resource Report: $TIMESTAMP =====" >> $LOG_FILE
    echo "CPU Usage:" >> $LOG_FILE
    top -bn1 | head -n 3 >> $LOG_FILE
    echo "" >> $LOG_FILE
    echo "Memory Usage:" >> $LOG_FILE
    free -h >> $LOG_FILE
    echo "" >> $LOG_FILE
    echo "Disk Usage:" >> $LOG_FILE
    df -h >> $LOG_FILE
    echo "=====================================" >> $LOG_FILE
    echo "" >> $LOG_FILE
}

# Check if log file directory exists
if [ ! -d "/var/log" ]; then
    mkdir -p /var/log
fi

# Run the monitoring function
log_resources

# Optional: Email alert if disk usage exceeds 80%
DISK_USAGE=$(df / | grep / | awk '{ print $5 }' | sed 's/%//g')
if [ $DISK_USAGE -gt 80 ]; then
    echo "Warning: Disk usage is above 80%!" | mail -s "Disk Usage Alert" admin@example.com
fi