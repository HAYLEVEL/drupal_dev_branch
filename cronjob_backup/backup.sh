#!/bin/bash

# Configuration
BACKUP_DIR="/home/backups/files"
LOG_FILE="/var/log/cronjob/backup.log"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
RETENTION_DAYS=5
TEMP_LOG=$(mktemp)

# Create folder for backup
NAME_DIR="$BACKUP_DIR/liqx_$DATE"
mkdir -p "$NAME_DIR"

# Backup Database
docker exec php vendor/bin/drush sql:dump --result-file=/var/www/html/back_sql/backup.sql --skip-tables-key=common
docker cp php:/var/www/html/back_sql/backup.sql $NAME_DIR/backup-$DATE.sql
echo "$DATE - Database backup created at $NAME_DIR/backup-$DATE.sql" >> "$LOG_FILE"

# Backup Website Files
tar -czf "$NAME_DIR/files_backup_$DATE.tar.gz" /var/www/html/web/sites/default/files
echo "$DATE - Website files backup created at $NAME_DIR/files_backup_$DATE.tar.gz" >> "$LOG_FILE"

# Clean up old backups
find "$BACKUP_DIR" -type d -mtime +$RETENTION_DAYS -print > "$TEMP_LOG"
if [ -s "$TEMP_LOG" ]; then
    find "$BACKUP_DIR" -type d -mtime +$RETENTION_DAYS -exec rm -rf {} \;
    FILE=$(cat "$TEMP_LOG")
    echo "$DATE - Deleted backups older than $RETENTION_DAYS days $FILE" >> "$LOG_FILE"
else
    echo "Nothing to delete"
fi