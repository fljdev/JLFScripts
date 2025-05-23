#!/bin/bash
# File: service_check.sh
# Description: Checks and restarts specified services if they are not running

SERVICES=("nginx" "mysql" "ssh")
LOG_FILE="/var/log/service_check.log"

# Function to check and restart services
check_service() {
    local SERVICE=$1
    if systemctl is-active --quiet $SERVICE; then
        echo "$TIMESTAMP: $SERVICE is running" >> $LOG_FILE
    else
        echo "$TIMESTAMP: $SERVICE is not running, restarting..." >> $LOG_FILE
        systemctl restart $SERVICE
        if [ $? -eq 0 ]; then
            echo "$TIMESTAMP: $SERVICE restarted successfully" >> $LOG_FILE
        else
            echo "$TIMESTAMP: Failed to restart $SERVICE" >> $LOG_FILE
        fi
    fi
}

# Loop through services
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
for SERVICE in "${SERVICES[@]}"; do
    check_service $SERVICE
done