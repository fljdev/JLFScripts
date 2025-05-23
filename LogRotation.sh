#!/bin/bash
# File: log_rotate.sh
# Description: Rotates logs to manage disk space

LOG_DIR="/var/log/myapp"
MAX_SIZE="50M" # Max size before rotation
ARCHIVE_DIR="/var/log/myapp/archive"

# Create archive directory if it doesn't exist
mkdir -p $ARCHIVE_DIR

# Find and rotate logs larger than MAX_SIZE
find $LOG_DIR -type f -name "*.log" -size +$MAX_SIZE | while read LOG_FILE; do
    TIMESTAMP=$(date +%Y%m%d_%H%M%S)
    mv $LOG_FILE $ARCHIVE_DIR/$(basename $LOG_FILE)_$TIMESTAMP
    gzip $ARCHIVE_DIR/$(basename $LOG_FILE)_$TIMESTAMP
    touch $LOG_FILE
    echo "Rotated $LOG_FILE to $ARCHIVE_DIR/$(basename $LOG_FILE)_$TIMESTAMP.gz"
done

# Remove archives older than 30 days
find $ARCHIVE_DIR -name "*.gz" -mtime +30 -delete