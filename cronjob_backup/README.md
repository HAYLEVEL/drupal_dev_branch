# Purpose of this script

This simple script do this routine work: 
 
1. Creates a backup of DB using drush sql:dump inside a docker container and move this on host machine.
2. Creates a backup of the site files and places the archive in dir described inside the script.
3. Cleans old backups if older than 5 days.
4. Logs all in the file described inside.(You can change the place where you want store logs.)
5. Sends email with the information about the backup process.

Also, you can find logrotate configuration file which can help you manage the log file:

1. Archives if its size is more than 10 MB.
2. Archives if it is more than one month old.
3. Delets if it is older than 12 months.

## Prerequisites

If you need to use this script do these steps before:

1. Create dirs /home/backups/files and /var/log/cronjob/
   ``` 
   mkdir -p /home/backups/files && mkdir -p /var/log/cronjob/
   ```
2. Set permissions on early-created dirs. The user who starts this script must have write and read permisions.
   ```
   chown $USER:$USER /home/backups/files && chown $USER:$USER /var/log/cronjob/
   ```
3. Make script executable.(chmod +x backup.sh)
   ```
   sudo chmod +x backup.sh
   ```
4. Install logrotate if it doesn't exist.
   ```
   if ! command -v logrotate &> /dev/null; then
       echo "Installing logrotate..."
       sudo apt-get update && sudo apt-get install -y logrotate
   else
       echo "logrotate is already installed."
   fi
   ```
5. Place logrotate configuration file in /etc/logrotate.d/
   ```
   mv cronjob_backup/backup /etc/logrotate.d/backup
   ```
6. Configure your cron for execution backup script. Example:
   ```cron 
    0  0    * * *   user /home/user/backup.sh
   ```

## Mailing feature

Configuring the mail server using Postfix.

1. Install Required Packages:
   ```
   sudo apt-get update && sudo apt-get install postfix libsasl2-modules
   ```
2. Add Postfix configuration and edit it with you credentials:
   ```
   mv /var/www/html/cronjob_backup/main.cf /etc/postfix/main.cf 
   ```
3. Add SASL Password File and edit it with you credentials, edit the /etc/postfix/sasl_passwd file with the MailerSend SMTP credentials.
   Set the correct permissions for the SASL password file and create the hash db file:
   ```
   mv /var/www/html/cronjob_backup/main.cf /etc/postfix/sasl_passwd
   sudo nano /etc/postfix/sasl_passwd
   sudo chmod 600 /etc/postfix/sasl_passwd && sudo postmap /etc/postfix/sasl_passwd
   ```
4. Reload or restart Postfix to apply the changes:
   ```
   sudo systemctl restart postfix
   ```
5. Test Your Configuration. Send a test email using the sendmail or mail command to check if everything is working:
   ```
   echo "Test email from Postfix via MailerSend" | mail -s "Test Email" recipient@example.com
   ```
6. If there are any issues, check the logs for more information:
   ```
   sudo tail -f /var/log/mail.log
   ```
7. Additional Tips:

 - Ensure that your DNS settings for SPF, DKIM, and DMARC are correctly configured for your domain to improve email deliverability.
 - If you encounter authentication errors, double-check your username and password in the sasl_passwd file.

