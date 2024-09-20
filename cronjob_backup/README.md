# Purpose of this script

This simple script do this routine work: 
 
1. Creates a backup of DB using drush sql:dump inside a docker container and move this on host machine.
2. Creates a backup of the site files and places the archive in dir described inside the script.
3. Cleans old backups if older than 5 days.
4. Logs all in the file described inside.(You can change the place where you want store logs.)

Also, you can find logrotate configuration file which can help you manage the log file:

1. Archives if its size is more than 10 MB.
2. Archives if it is more than one month old.
3. Delets if it is older than 12 months.

# Prerequisites

If you need to use this script do these steps before:

1. Create dirs /home/backups/files and /var/log/cronjob/
2. Set permissions on early-created dirs. The user who starts this script must have write and read permisions. 
3. Make script executable.(chmod +x backup.sh)
4. Install logrotate if it doesn't exist.
5. Place logrotate configuration file in /etc/logrotate.d/
6. Configure your cron for execution backup script. Example:
   ```cron 
    0  0    * * *   user /home/user/backup.sh
   ```
