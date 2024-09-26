#!/bin/bash

# Enable options for better error handling
set -euo pipefail

# Configuration
BACKUP_DIR="/home/backups/files"
LOG_FILE="/var/log/cronjob/backup.log"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
RETENTION_DAYS=5
TEMP_LOG=$(mktemp)
MAIL_RECIPIENT="s.vlasiuk@dev-branch.com"
SUBJECT_SUCCESS="Backup Success on $DATE"
SUBJECT_ERROR="Backup Failure on $DATE"

# Function to send an email
send_mail() {
    local subject="$1"
    local message="$2"
    echo "$message" | mail -s "$subject" "$MAIL_RECIPIENT"
}

# Create folder for backup
NAME_DIR="$BACKUP_DIR/liqx_$DATE"

if mkdir -p "$NAME_DIR"; then
    echo "$DATE - Created directory $NAME_DIR" >> "$LOG_FILE"
else
    ERROR_MSG="$DATE - Error: Cannot create directory $NAME_DIR, please check permissions and Readme file"
    echo "$ERROR_MSG" >> "$LOG_FILE"
    send_mail "$SUBJECT_ERROR" "$ERROR_MSG"
    exit 1
fi

# Backup Database
if docker exec php vendor/bin/drush sql:dump --result-file=/var/www/html/back_sql/backup.sql --gzip --skip-tables-key=common; then
    docker cp php:/var/www/html/back_sql/backup.sql.gz $NAME_DIR/backup-$DATE.sql.gz
    echo "$DATE - Database backup created at $NAME_DIR/backup-$DATE.sql.gz" >> "$LOG_FILE"
else
    ERROR_MSG="$DATE - Error: Database backup failed."
    echo "$ERROR_MSG" >> "$LOG_FILE"
    send_mail "$SUBJECT_ERROR" "$ERROR_MSG"
    exit 1
fi

# Backup Website Files
if tar -czf "$NAME_DIR/files_backup_$DATE.tar.gz" /var/www/html/web/sites/default/files; then
    echo "$DATE - Website files backup created at $NAME_DIR/files_backup_$DATE.tar.gz" >> "$LOG_FILE"
else
    ERROR_MSG="$DATE - Error: Website files backup failed."
    echo "$ERROR_MSG" >> "$LOG_FILE"
    send_mail "$SUBJECT_ERROR" "$ERROR_MSG"
    exit 1
fi

# Clean up old backups
find "$BACKUP_DIR" -type d -mtime +$RETENTION_DAYS -print > "$TEMP_LOG"
if [ -s "$TEMP_LOG" ]; then
    find "$BACKUP_DIR" -type d -mtime +$RETENTION_DAYS -exec rm -rf {} \;
    FILE=$(cat "$TEMP_LOG")
    echo "$DATE - Deleted backups older than $RETENTION_DAYS days $FILE" >> "$LOG_FILE"
else
    echo "Nothing to delete"
fi

# Success notification
SUCCESS_MSG="$DATE - Backup process completed successfully."
send_mail "$SUBJECT_SUCCESS" "$SUCCESS_MSG"
