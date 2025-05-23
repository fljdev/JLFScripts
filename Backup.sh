#!/bin/bash
# File: backup.sh
# Description: Backs up specified directories to a compressed tarball

BACKUP_DIR="/backup"
SOURCE_DIRS="/home /etc /var/www"
BACKUP_NAME="backup_$(date +%Y%m%d_%H%M%S).tar.gz"

# Create backup directory if it doesn't exist
mkdir -p $BACKUP_DIR

# Create backup
tar -czf $BACKUP_DIR/$BACKUP_NAME $SOURCE_DIRS 2>> $BACKUP_DIR/backup_errors.log

# Check if backup was successful
if [ $? -eq 0 ]; then
    echo "Backup completed: $BACKUP_NAME"
else
    echo "Backup failed! Check $BACKUP_DIR/backup_errors.log"
    exit 1
fi

# Remove backups older than 7 days
find $BACKUP_DIR -name "backup_*.tar.gz" -mtime +7 -delete