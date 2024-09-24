#!/bin/bash

# Enable options for better error handling
set -euo pipefail

# Configuration
BACKUP_DIR="/home/backups/files"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
RETENTION_DAYS=5
TEMP_LOG=$(mktemp)

# Create folder for backup
NAME_DIR="$BACKUP_DIR/liqx_$DATE"

if mkdir -p "$NAME_DIR"; then
    echo "$DATE - Created directory $NAME_DIR"
else
    echo "$DATE - Error: Cannot create directory $NAME_DIR, please check permissions and Readme file"
    exit 1
fi

# Backup Database
if drush sql:dump --result-file=$NAME_DIR/backup-$DATE.sql --gzip --skip-tables-list=cache*; then
    echo "$DATE - Database backup created at $NAME_DIR/backup-$DATE.sql.gz"
else
    echo "$DATE - Error: Database backup failed."
    exit 1
fi

# Backup Website Files
if tar -czvf "$NAME_DIR/files_backup_$DATE.tar.gz" /var/www/html/web/sites/default/files; then
    echo "$DATE - Website files backup created at $NAME_DIR/files_backup_$DATE.tar.gz"
else
    echo "$DATE - Error: Website files backup failed."
    exit 1
fi

# Clean up old backups
find "$BACKUP_DIR" -type d -mtime +$RETENTION_DAYS -print > "$TEMP_LOG"
if [ -s "$TEMP_LOG" ]; then
    find "$BACKUP_DIR" -type d -mtime +$RETENTION_DAYS -exec rm -rf {} \;
    FILE=$(cat "$TEMP_LOG")
    echo "$DATE - Deleted backups older than $RETENTION_DAYS days $FILE"
else
    echo "Nothing to delete"
fi
