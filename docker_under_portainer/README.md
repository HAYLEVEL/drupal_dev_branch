# Backups | Using docker container solution

This file describes how to use backup.sh script and backup container for creating backups.

## Overview

After the successful configuration described below you will get these features.

1. Creates a backup of DB using drush sql:dump.
2. Creates a backup of the site files.
3. Cleans old backups if older than 5 days.
4. Logs all in standart container log output.

# Prerequisites

If you need to use this script do these steps on host machine before:

1. Create dirs /home/backups/files
   ``` 
   mkdir -p /home/backups/files
   ```
2. Set permissions on early-created dirs.
   ```
   sudo chown $USER:$USER /home/backups/files
   ```
3. Make script executable.(chmod +x backup.sh)
   ```
   sudo chmod +x /var/www/html/docker_under_portainer/backup.sh
   ```

## How it works?

1. Firstly, container 'backup' waits successfully start php and mariadb containers.
2. After that mount the host directory for storing backups. '/home/backups/files'
3. Create a backup every day at 4:00. You can change time in docker stack file configuration. 
